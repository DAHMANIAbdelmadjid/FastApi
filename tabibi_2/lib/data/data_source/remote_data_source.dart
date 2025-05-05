import 'package:tabibi_2/data/network/app_api.dart';
import 'package:tabibi_2/data/network/requests.dart';
import 'package:tabibi_2/data/response/api_response.dart';
import 'package:tabibi_2/data/response/appointment_response.dart';
import 'package:tabibi_2/data/response/doctor_response.dart';
import 'package:tabibi_2/data/response/patient_response.dart';
import 'package:tabibi_2/data/response/response.dart';

abstract class RemoteDataSource {
  Future<LoginResponse> login(String email, String password);
  Future<LoginResponse> signup(String fullName, String email, String password);

  Future<DoctorsResponse> getDoctors();
  Future<DoctorsResponse> searchDoctors(String query, String city);
  Future<ApiResponse<String>> createAppointment(AppointmentRequest request);
  Future<ApiResponse<List<AppointmentResponse>>> getAppointments(String workScheduleId);
  Future<ApiResponse<void>> confirmAppointment(String id);
  Future<ApiResponse<void>> cancelAppointment(String id);
  Future<PatientResponse> createPatient(PatientRequest request);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppApi _appApi;

  RemoteDataSourceImpl(this._appApi);

  @override
  Future<LoginResponse> login(String email, String password) async {
    return await _appApi.login(email, password);
  }

  @override
  Future<LoginResponse> signup(String fullName, String email, String password) async {
    return await _appApi.signup(fullName, email, password);
  }


  @override
  Future<DoctorsResponse> getDoctors() async {
    return await _appApi.getDoctors();
  }

  @override
  Future<DoctorsResponse> searchDoctors(String query, String city) async {
    return await _appApi.searchDoctors(query, city);
  }

  @override
  Future<ApiResponse<String>> createAppointment(AppointmentRequest request) async {
    return await _appApi.createAppointment(request);
  }

  @override
  Future<ApiResponse<List<AppointmentResponse>>> getAppointments(String workScheduleId) async {
    return await _appApi.getAppointments(workScheduleId);
  }

  @override
  Future<ApiResponse<void>> confirmAppointment(String id) async {
    return await _appApi.confirmAppointment(id);
  }

  @override
  Future<ApiResponse<void>> cancelAppointment(String id) async {
    return await _appApi.cancelAppointment(id);
  }



  @override
  Future<PatientResponse> createPatient(PatientRequest request) async {
    return await _appApi.createPatient(request);
  }
}
