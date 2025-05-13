import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tabibi_2/data/network/requests.dart';
import 'package:tabibi_2/data/repository/repository_impl.dart';
import 'package:tabibi_2/data/response/patient_response.dart';
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
  String? _authToken;

  PatientProvider(this._repository);

  String? get authToken => _authToken;
  
  set authToken(String? value) {
    _authToken = value;
    notifyListeners();
  }

  PatientState get state => _state;

Future<void> fetchPatient(String token) async {
  // print("fetchPatient called with token: $token");
  try {
    _authToken = token;
    _state = PatientState.loading();
    notifyListeners();
    
    print("Making repository call");
    final result = await _repository.getPatient(token);
    
    if (result.succeeded == true && result.data != null) {
      print("API call successful, parsing data");
      
      // The issue is here. Check what type result.data is
      print("Result data type: ${result.data.runtimeType}");
      
      // If result.data is already a Map/JSON object, no need to decode it
      final Map<String, dynamic> jsonData;
      if (result.data is PatientData) {
        final patientData = result.data as PatientData;
        // Check if patientData is null or essential fields are missing
        if (patientData == null) {
          throw Exception('Patient data is null');
        }
        
        // Create jsonData with explicit null checks and include userId
        jsonData = {
          'id': patientData.id ?? '',
          'fullName': patientData.fullName ?? '',
          'gender': patientData.gender ?? 0,
          'birthDate': patientData.birthDate ?? DateTime.now().toIso8601String(),
          'phoneNumber': patientData.phoneNumber ?? '',
          'email': patientData.email ?? '',
          'state': patientData.state ?? '',
          'city': patientData.city ?? '',
          'userId': patientData.id ?? '', // Use id as userId if not provided
        };

        // Validate essential fields
        if (jsonData['id'] == '' || jsonData['fullName'] == '') {
          throw Exception('Essential patient data is missing');
        }
      } else {
        throw Exception('Invalid patient data format');
      }
      
      final patient = Patient.fromResponse(jsonData);
      _state = PatientState.success(patient);
      print("Patient loaded: ${patient.fullName}");
    } else {
      print("API call failed: ${result.error}");
      _state = PatientState.error(result.error ?? "فشل في استرجاع معلومات المريض");
    }
    notifyListeners();
  } catch (e) {
    print("Exception in fetchPatient: $e");
    _state = PatientState.error(e.toString());
    notifyListeners();
  }
}
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
      
      if (result.succeeded == true && result.data != null) {
        // Create a patient object with the returned ID and request data
        final patient = Patient(
          id: result.data!,
          fullName: fullName,
          gender: gender,
          birthDate: birthDate,
          phoneNumber: phoneNumber,
          email: email,
          userId: userId
        );
        
        
        // Update state with new patient data
        _state = PatientState.success(patient);
        debugPrint('Patient created successfully: ${patient.id}');
      } else {
        final errorMessage = result.error ?? 'Failed to create patient';
        debugPrint('Patient creation failed: $errorMessage');
        _state = PatientState.error(errorMessage);
      }
      // Remove redundant logging since we already logged success above

      notifyListeners();
    } catch (e) {
      debugPrint('Error creating patient: ${e.toString()}');
      _state = PatientState.error(e.toString());
      notifyListeners();
    }
  }

  bool get isLoading => _state.isLoading;
  String? get error => _state.error;
  Patient? get patient => _state.patient;
}