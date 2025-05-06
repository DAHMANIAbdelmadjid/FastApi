import 'package:tabibi_2/data/data_source/remote_data_source.dart';
import 'package:tabibi_2/data/network/requests.dart';
import 'package:tabibi_2/data/response/api_response.dart';
import 'package:tabibi_2/data/response/appointment_response.dart';
import 'package:tabibi_2/data/response/patient_response.dart';
import 'package:tabibi_2/data/response/response.dart';
import 'package:tabibi_2/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;

  RepositoryImpl(this._remoteDataSource);

  @override
  Future<LoginResponse> login(String email, String password) async {
    return await _remoteDataSource.login(email, password);
  }

  @override
  Future<LoginResponse> signup(String fullName, String email, String password) async {
    return await _remoteDataSource.signup(fullName, email, password);
  }


  @override
  Future<DoctorsResponse> getDoctors() async {
    return await _remoteDataSource.getDoctors();
  }

  @override
  Future<DoctorsResponse> searchDoctors(String query, String city) async {
    return await _remoteDataSource.searchDoctors(query, city);
  }

  @override
  Future<ApiResponse<String>> createAppointment(AppointmentRequest request) async {
    return await _remoteDataSource.createAppointment(request);
  }

  @override
  Future<ApiResponse<List<AppointmentResponse>>> getAppointments(String workScheduleId) async {
    return await _remoteDataSource.getAppointments(workScheduleId);
  }

  @override
  Future<ApiResponse<void>> confirmAppointment(String id) async {
    return await _remoteDataSource.confirmAppointment(id);
  }

  @override
  Future<ApiResponse<void>> cancelAppointment(String id) async {
    return await _remoteDataSource.cancelAppointment(id);
  }


  @override
  Future<PatientResponse> createPatient(PatientRequest request) async {
    final response = await _remoteDataSource.createPatient(request);
    return response;
  }
}
