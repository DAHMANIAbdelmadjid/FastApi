import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabibi_2/app/providers/patient_provider.dart';
import 'package:tabibi_2/data/data_source/remote_data_source.dart';
import 'package:tabibi_2/data/response/response.dart';

class AuthState {
  final bool isLoading;
  final LoginResponse? loginResponse;
  final String? error;

  AuthState({
    this.isLoading = false,
    this.loginResponse,
    this.error,
  });

  factory AuthState.initial() => AuthState();
  factory AuthState.loading() => AuthState(isLoading: true);
  factory AuthState.success(LoginResponse response) => AuthState(loginResponse: response);
  factory AuthState.error(String error) => AuthState(error: error);
}

class AuthProvider extends ChangeNotifier {
  final RemoteDataSource _remoteDataSource;
  final SharedPreferences _prefs;
  bool _isInitialized = false;
  bool _rememberMe = false;

  AuthState _state = AuthState.initial();
  AuthState get state => _state;

  bool get isAuthenticated => _state.loginResponse?.data!= null;
  bool get loading => _state.isLoading;

  AuthProvider(this._remoteDataSource, this._prefs);

  bool get rememberMe => _rememberMe;
  void setRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

Future<void> init(PatientProvider patientProvider) async {
  if (_isInitialized) return;

  final token = _prefs.getString('token');
  if (token != null) {
    _state = AuthState.success(
      LoginResponse(succeeded: true, data: token),
    );

    // استدعاء جلب معلومات المريض
    await patientProvider.fetchPatient(token);
  }

  _isInitialized = true;
  notifyListeners();
}



  Future<void> login(String email, String password, {PatientProvider? patientProvider}) async {
    try {
      _state = AuthState.loading();
      notifyListeners();

      final response = await _remoteDataSource.login(email, password);

      if (response.succeeded == true) {
        _state = AuthState.success(response);
        if (response.data != null) {
          if (_rememberMe) {
            await _prefs.setString('token', response.data!);
          }
          // Update PatientProvider's token if provided
          patientProvider?.authToken = response.data;
        }
      } else {
        _state = AuthState.error(response.error ?? 'Login failed');
      }
      notifyListeners();
    } catch (e) {
      _state = AuthState.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> signup(String fullName, String email, String password) async {
    try {
      _state = AuthState.loading();
      notifyListeners();

      final response = await _remoteDataSource.signup(fullName, email, password);

      if (response.succeeded == true) {
        _state = AuthState.success(response);
      } else {
        _state = AuthState.error(response.error ?? 'Signup failed');
      }
      notifyListeners();
    } catch (e) {
      _state = AuthState.error(e.toString());
      notifyListeners();
    }
  }

  Future<void> logout({PatientProvider? patientProvider}) async {
    await _prefs.remove('token');
    _state = AuthState.initial();
    // Clear token in PatientProvider if provided
    patientProvider?.authToken = null;
    notifyListeners();
  }
}