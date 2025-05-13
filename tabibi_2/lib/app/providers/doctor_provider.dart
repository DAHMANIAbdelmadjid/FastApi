import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:tabibi_2/domain/models/doctor.dart';
import 'package:tabibi_2/domain/repository/repository.dart';

enum DoctorLoadingState { initial, loading, loaded, error }

class DoctorProvider extends ChangeNotifier {
  final Repository _repository;
  Timer? _debounceTimer;

  List<Doctor> _allDoctors = [];
  List<Doctor> _filteredDoctors = [];
  String _searchQuery = '';
  String _selectedCity = '';
  String? _error;
  DoctorLoadingState _loadingState = DoctorLoadingState.initial;

  DoctorProvider(this._repository);

  // Getters
  List<Doctor> get doctors => _filteredDoctors.isEmpty && _searchQuery.isEmpty && _selectedCity.isEmpty 
    ? _allDoctors 
    : _filteredDoctors;
  bool get isLoading => _loadingState == DoctorLoadingState.loading;
  String? get error => _error;
  DoctorLoadingState get loadingState => _loadingState;

  // Initialize and fetch all doctors
  Future<void> init() async {
    await fetchDoctors();
  }

  // Fetch all doctors
  Future<void> fetchDoctors() async {
    _loadingState = DoctorLoadingState.loading;
    _error = null;
    notifyListeners();

    try {
      final response = await _repository.getDoctors();
      if (response.succeeded == true) {
        _allDoctors = response.toDomain();
        _filteredDoctors = [];
        _loadingState = DoctorLoadingState.loaded;
      } else {
        _error = response.error ?? 'Failed to fetch doctors';
        _loadingState = DoctorLoadingState.error;
      }
    } catch (e) {
      _error = e.toString();
      _loadingState = DoctorLoadingState.error;
    }

    notifyListeners();
  }

  // Search doctors with debouncing
  // Future<void> searchDoctors(String query) async {
  //   _searchQuery = query;
    
  //   // Cancel previous timer
  //   _debounceTimer?.cancel();

  //   // If query and city are empty, reset to all doctors
  //   if (query.isEmpty && _selectedCity.isEmpty) {
  //     _filteredDoctors = [];
  //     notifyListeners();
  //     return;
  //   }

  //   // Set new timer
  //   final completer = Completer<void>();
  //   _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
  //     _loadingState = DoctorLoadingState.loading;
  //     notifyListeners();

  //     try {
  //       final response = await _repository.searchDoctors(query, _selectedCity);
  //       if (response.succeeded == true) {
  //         _filteredDoctors = response.toDomain();
  //         _loadingState = DoctorLoadingState.loaded;
  //       } else {
  //         _error = response.error ?? 'Failed to search doctors';
  //         _loadingState = DoctorLoadingState.error;
  //       }
  //     } catch (e) {
  //       _error = e.toString();
  //       _loadingState = DoctorLoadingState.error;
  //     }

  //     notifyListeners();
  //     completer.complete();
  //   });

  //   return completer.future;
  // // }

  // // Update selected city
  // void updateCity(String city) {
  //   if (_selectedCity == city) return;
  //   _selectedCity = city;
  //   if (_searchQuery.isNotEmpty) {
  //     searchDoctors(_searchQuery);
  //   }
  // }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}