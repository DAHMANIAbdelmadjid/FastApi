import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabibi_2/data/data_source/remote_data_source.dart';
import 'package:tabibi_2/data/response/response.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final LoginResponse? loginResponse;

  AuthState({
    this.isLoading = false,
    this.error,
    this.loginResponse,
  });

  factory AuthState.initial() => AuthState();
  factory AuthState.loading() => AuthState(isLoading: true);
  factory AuthState.error(String message) => AuthState(error: message);
  factory AuthState.success(LoginResponse response) => AuthState(loginResponse: response);
}

class AuthProvider extends ChangeNotifier {
  final RemoteDataSourceImpl _remoteDataSource;
  final SharedPreferences _prefs;
  AuthState _state = AuthState.initial();
  bool _loading = false;
  bool _isAuthenticated = false;
  bool _rememberMe = false;

  AuthProvider(this._remoteDataSource, this._prefs);

  // Getters
  AuthState get state => _state;
  bool get loading => _loading;
  bool get isAuthenticated => _isAuthenticated;
  bool get rememberMe => _rememberMe;

  Future<void> init() async {
    _loading = true;
    notifyListeners();

    _rememberMe = _prefs.getBool('rememberMe') ?? false;
    final token = _prefs.getString('token');
    _isAuthenticated = _rememberMe && token != null;

    _loading = false;
    notifyListeners();
  }

  void setRememberMe(bool value) {
    _rememberMe = value;
    _prefs.setBool('rememberMe', value);
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    try {
      _loading = true;
      _state = AuthState.loading();
      notifyListeners();

      final response = await _remoteDataSource.login(email, password);

      if (response.succeeded == true) {
        _isAuthenticated = true;
        if (_rememberMe && response.token != null) {
          await _prefs.setString('token', response.token!);
        }
        _state = AuthState.success(response);
      } else {
        _state = AuthState.error(response.error ?? 'Login failed');
      }

      _loading = false;
      notifyListeners();
    } catch (e) {
      _loading = false;
      _state = AuthState.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> signup(String fullName, String email, String password) async {
    try {
      _loading = true;
      _state = AuthState.loading();
      notifyListeners();

      final response = await _remoteDataSource.signup(fullName, email, password);

      if (response.succeeded == true) {
        _state = AuthState.success(response);
      } else {
        _state = AuthState.error(response.error ?? 'Signup failed');
      }

      _loading = false;
      notifyListeners();
    } catch (e) {
      _loading = false;
      _state = AuthState.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _prefs.remove('token');
    _isAuthenticated = false;
    _state = AuthState.initial();
    notifyListeners();
  }
}