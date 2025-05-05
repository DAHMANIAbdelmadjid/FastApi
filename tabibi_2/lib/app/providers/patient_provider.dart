import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:tabibi_2/data/network/requests.dart';
import 'package:tabibi_2/data/repository/repository_impl.dart';
import 'package:tabibi_2/domain/models/patient.dart';
import 'package:intl/intl.dart';

class PatientState {
  final bool isLoading;
  final String? error;
  final Patient? patient;

  PatientState({
    this.isLoading = false,
    this.error,
    this.patient,
  });

  factory PatientState.initial() => PatientState();
  factory PatientState.loading() => PatientState(isLoading: true);
  factory PatientState.error(String message) => PatientState(error: message);
  factory PatientState.success(Patient patient) =>
      PatientState(patient: patient);
}

class PatientProvider extends ChangeNotifier {
  final RepositoryImpl _repository;
  PatientState _state = PatientState.initial();

  PatientProvider(this._repository);

  PatientState get state => _state;

  Future<void> createPatient({
    required String fullName,
    required Gender gender,
    required DateTime birthDate,
    required String phoneNumber,
    required String email,
    required String userId,
  }) async {
    try {
      _state = PatientState.loading();
      notifyListeners();

      final request = PatientRequest(
        fullName: fullName,
        gender: gender.value,
        birthDate: DateFormat('yyyy-MM-dd').format(birthDate),
        phoneNumber: phoneNumber,
        email: email,
        userId: userId,
      );

      final result = await _repository.createPatient(request);
      print(result);
      if (result.succeeded! && result.data != null) {
        print(result.data!);
        
      } else {
        _state = PatientState.error(result.error ?? 'Failed to create patient');
      }

      notifyListeners();
    } catch (e) {
      _state = PatientState.error(e.toString());
      notifyListeners();
    }
  }

  bool get isLoading => _state.isLoading;
  String? get error => _state.error;
  Patient? get patient => _state.patient;
}
