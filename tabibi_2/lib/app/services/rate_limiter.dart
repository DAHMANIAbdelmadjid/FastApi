import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RateLimiter {
  static const String _attemptsKey = 'login_attempts';
  static const String _lockoutKey = 'lockout_until';
  static const int maxAttempts = 5;
  static const Duration lockoutDuration = Duration(minutes: 15);
  static const Duration attemptWindow = Duration(hours: 1);

  final SharedPreferences _prefs;

  RateLimiter(this._prefs);

  Future<bool> checkRateLimit() async {
    final lockoutUntil = _prefs.getString(_lockoutKey);
    if (lockoutUntil != null) {
      final lockoutTime = DateTime.parse(lockoutUntil);
      if (lockoutTime.isAfter(DateTime.now())) {
        return false;
      } else {
        await _prefs.remove(_lockoutKey);
        await clearAttempts();
      }
    }

    final attempts = _getAttempts();
    final recentAttempts = _filterRecentAttempts(attempts);
    return recentAttempts.length < maxAttempts;
  }

  Future<void> recordAttempt({required bool success}) async {
    final attempts = _getAttempts();
    attempts.add({
      'timestamp': DateTime.now().toIso8601String(),
      'success': success,
    });

    await _prefs.setString(_attemptsKey, jsonEncode(attempts));

    if (!success) {
      final recentAttempts = _filterRecentAttempts(attempts);
      if (recentAttempts.length >= maxAttempts) {
        final lockoutUntil = DateTime.now().add(lockoutDuration);
        await _prefs.setString(_lockoutKey, lockoutUntil.toIso8601String());
      }
    } else {
      await clearAttempts();
    }
  }

  Future<void> clearAttempts() async {
    await _prefs.remove(_attemptsKey);
  }

  Future<Duration?> getRemainingLockout() async {
    final lockoutUntil = _prefs.getString(_lockoutKey);
    if (lockoutUntil != null) {
      final lockoutTime = DateTime.parse(lockoutUntil);
      if (lockoutTime.isAfter(DateTime.now())) {
        return lockoutTime.difference(DateTime.now());
      }
    }
    return null;
  }

  List<Map<String, dynamic>> _getAttempts() {
    final attemptsString = _prefs.getString(_attemptsKey);
    if (attemptsString != null) {
      final attemptsList = jsonDecode(attemptsString) as List;
      return attemptsList.cast<Map<String, dynamic>>();
    }
    return [];
  }

  List<Map<String, dynamic>> _filterRecentAttempts(List<Map<String, dynamic>> attempts) {
    final cutoffTime = DateTime.now().subtract(attemptWindow);
    return attempts.where((attempt) {
      final timestamp = DateTime.parse(attempt['timestamp'] as String);
      return timestamp.isAfter(cutoffTime) && !(attempt['success'] as bool);
    }).toList();
  }

  String? getFormattedRemainingTime() {
    final lockoutUntil = _prefs.getString(_lockoutKey);
    if (lockoutUntil != null) {
      final lockoutTime = DateTime.parse(lockoutUntil);
      if (lockoutTime.isAfter(DateTime.now())) {
        final difference = lockoutTime.difference(DateTime.now());
        final minutes = difference.inMinutes;
        final seconds = difference.inSeconds % 60;
        return '$minutes:${seconds.toString().padLeft(2, '0')}';
      }
    }
    return null;
  }
}