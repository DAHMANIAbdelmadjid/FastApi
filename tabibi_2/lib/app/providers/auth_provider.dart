import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabibi_2/app/services/rate_limiter.dart';
import 'package:tabibi_2/data/data_source/remote_data_source.dart';
import 'package:tabibi_2/data/network/requests.dart';
import 'package:tabibi_2/data/response/response.dart';

enum AuthStatus { initial, authenticated, unauthenticated }

class AuthProvider extends ChangeNotifier {
  final RemoteDataSource _remoteDataSource;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final SharedPreferences _prefs;
  late final RateLimiter _rateLimiter;
  
  AuthStatus _status = AuthStatus.initial;
  bool _rememberMe = false;
  String? _token;
  String? _error;
  bool _loading = false;

  AuthProvider(this._remoteDataSource, this._prefs) {
    _rateLimiter = RateLimiter(_prefs);
    _rememberMe = _prefs.getBool('remember_me') ?? false;
  }

  // Getters
  AuthStatus get status => _status;
  String? get token => _token;
  String? get error => _error;
  bool get loading => _loading;
  bool get isAuthenticated => _status == AuthStatus.authenticated;
  bool get rememberMe => _rememberMe;
  RateLimiter get rateLimiter => _rateLimiter;

  // Initialize auth state
  Future<void> init() async {
    _token = await _storage.read(key: 'auth_token');
    if (_token != null) {
      _status = AuthStatus.authenticated;
    } else {
      _status = AuthStatus.unauthenticated;
      if (_rememberMe) {
        await _loadSavedCredentials();
      }
    }
    notifyListeners();
  }

  Future<void> setRememberMe(bool value) async {
    _rememberMe = value;
    await _prefs.setBool('remember_me', value);
    if (!value) {
      await _clearSavedCredentials();
    }
    notifyListeners();
  }

  Future<void> _saveCredentials(String email, String password) async {
    if (_rememberMe) {
      await _storage.write(key: 'saved_email', value: email);
      await _storage.write(key: 'saved_password', value: password);
    }
  }

  Future<void> _clearSavedCredentials() async {
    await _storage.delete(key: 'saved_email');
    await _storage.delete(key: 'saved_password');
  }

  Future<Map<String, String?>> _loadSavedCredentials() async {
    final email = await _storage.read(key: 'saved_email');
    final password = await _storage.read(key: 'saved_password');
    return {'email': email, 'password': password};
  }

  // Login
  Future<bool> login(String email, String password) async {
    try {
      if (!await _rateLimiter.checkRateLimit()) {
        final remainingTime = _rateLimiter.getFormattedRemainingTime();
        _error = 'Too many failed attempts. Please try again in $remainingTime';
        notifyListeners();
        return false;
      }

      _loading = true;
      _error = null;
      notifyListeners();

      final loginRequest = LoginRequest(email, password);
      final response = await _remoteDataSource.login(loginRequest);

      _loading = false;

      if (response.succeeded == true && response.token != null) {
        await _storage.write(key: 'auth_token', value: response.token);
        _token = response.token;
        _status = AuthStatus.authenticated;
        if (_rememberMe) {
          await _saveCredentials(email, password);
        }
        await _rateLimiter.recordAttempt(success: true);
        notifyListeners();
        return true;
      } else {
        _error = response.error ?? 'Login failed';
        _status = AuthStatus.unauthenticated;
        await _rateLimiter.recordAttempt(success: false);
        notifyListeners();
        return false;
      }
    } catch (e) {
      _loading = false;
      _error = e.toString();
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  // Signup
  Future<bool> signup(String fullName, String email, String password) async {
    try {
      _loading = true;
      _error = null;
      notifyListeners();

      final response = await _remoteDataSource.signup(
        fullName,
        email,
        password
      );

      _loading = false;

      if (response.succeeded == true && response.token != null) {
        await _storage.write(key: 'auth_token', value: response.token);
        _token = response.token;
        _status = AuthStatus.authenticated;
        notifyListeners();
        return true;
      } else {
        _error = response.error ?? 'Signup failed';
        _status = AuthStatus.unauthenticated;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _loading = false;
      _error = e.toString();
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    await _storage.delete(key: 'auth_token');
    _token = null;
    _status = AuthStatus.unauthenticated;
    if (!_rememberMe) {
      await _clearSavedCredentials();
    }
    notifyListeners();
  }

  // Get stored token
  Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  // Check if token is valid
  Future<bool> validateToken() async {
    final token = await getToken();
    if (token == null) {
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    }
    // TODO: Add token validation logic here
    // For now, just return true if token exists
    return true;
  }
}