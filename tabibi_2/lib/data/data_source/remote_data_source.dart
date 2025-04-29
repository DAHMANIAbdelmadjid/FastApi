import 'package:tabibi_2/data/network/app_api.dart';
import 'package:tabibi_2/data/network/requests.dart';
import 'package:tabibi_2/data/response/response.dart';
import 'package:tabibi_2/data/response/api_response.dart';
import 'package:tabibi_2/data/response/appointment_response.dart';

abstract class RemoteDataSource {
  Future<LoginResponse> login(LoginRequest loginRequest);
  Future<LoginResponse> signup(
      String fullName, String email, String password, String phoneNumber);
  Future<CitiesResponse> getCities();
  Future<CitiesResponse> searchCities(String query);
  Future<DoctorsResponse> getDoctors();
  Future<DoctorsResponse> searchDoctors(String query, String city);
  
  // Appointment related methods
  Future<ApiResponse<AppointmentResponse>> createAppointment(AppointmentRequest request);
  Future<ApiResponse<List<AppointmentResponse>>> getAppointments(String workScheduleId);
  Future<ApiResponse<void>> confirmAppointment(String id);
  Future<ApiResponse<void>> cancelAppointment(String id);
  
  // Work Schedule related methods
  Future<ApiResponse<List<WorkScheduleResponse>>> getWorkSchedules();
  Future<ApiResponse<WorkScheduleResponse>> createWorkSchedule(WorkScheduleRequest request);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppApi _appApi;
  RemoteDataSourceImpl(this._appApi);

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    return await _appApi.login(
        loginRequest.emailOrUserName, loginRequest.password);
  }

  @override
  Future<LoginResponse> signup(String fullName, String email, String password,
      String phoneNumber) async {
    return await _appApi.signup(fullName, email, password, phoneNumber);
  }

  @override
  Future<CitiesResponse> getCities() async {
    return await _appApi.getCities();
  }

  @override
  Future<CitiesResponse> searchCities(String query) async {
    return await _appApi.searchCities(query);
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
  Future<ApiResponse<AppointmentResponse>> createAppointment(AppointmentRequest request) async {
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
  Future<ApiResponse<List<WorkScheduleResponse>>> getWorkSchedules() async {
    return await _appApi.getWorkSchedules();
  }

  @override
  Future<ApiResponse<WorkScheduleResponse>> createWorkSchedule(WorkScheduleRequest request) async {
    return await _appApi.createWorkSchedule(request);
  }
}
