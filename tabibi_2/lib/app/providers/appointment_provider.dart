import 'package:flutter/foundation.dart';
import 'package:tabibi_2/data/data_source/remote_data_source.dart';
import 'package:tabibi_2/data/network/requests.dart';
import 'package:tabibi_2/data/response/appointment_response.dart';
import 'package:tabibi_2/data/response/api_response.dart';

class AppointmentProvider extends ChangeNotifier {
  final RemoteDataSource _remoteDataSource;
  bool _isLoading = false;
  String? _error;

  AppointmentProvider(this._remoteDataSource);

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<bool> createAppointment({
    required String workScheduleId,
    required String patientId,
    required int number,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final request = AppointmentRequest(
        workScheduleId: workScheduleId,
        patientId: patientId,
        number: number,
      );

      final response = await _remoteDataSource.createAppointment(request);
      
      _isLoading = false;
      if (response.succeeded == true) {
        notifyListeners();
        return true;
      } else {
        _error = response.error ?? 'Failed to create appointment';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateAppointment({
    required String id,
    required int number,
    required String workScheduleId,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final request = UpdateAppointmentRequest(
        id: id,
        number: number,
        workScheduleId: workScheduleId,
      );

      final response = await _remoteDataSource.updateAppointment(request);
      
      _isLoading = false;
      if (response.succeeded == true) {
        notifyListeners();
        return true;
      } else {
        _error = response.error ?? 'Failed to update appointment';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> confirmAppointment(String id) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _remoteDataSource.confirmAppointment(id);
      
      _isLoading = false;
      if (response.succeeded == true) {
        notifyListeners();
        return true;
      } else {
        _error = response.error ?? 'Failed to confirm appointment';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> cancelAppointment(String id) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _remoteDataSource.cancelAppointment(id);
      
      _isLoading = false;
      if (response.succeeded == true) {
        notifyListeners();
        return true;
      } else {
        _error = response.error ?? 'Failed to cancel appointment';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
}