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
    required DateTime startTime,
    required DateTime endTime,
    String? notes,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final request = AppointmentRequest(
        workScheduleId: workScheduleId,
        patientId: patientId,
        startTime: startTime.toIso8601String(),
        endTime: endTime.toIso8601String(),
        notes: notes,
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
}