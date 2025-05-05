import 'package:tabibi_2/data/network/requests.dart';
import 'package:tabibi_2/data/response/api_response.dart';
import 'package:tabibi_2/data/response/appointment_response.dart';
import 'package:tabibi_2/data/response/doctor_response.dart';
import 'package:tabibi_2/data/response/patient_response.dart';
import 'package:tabibi_2/data/response/response.dart';

abstract class Repository {
  // Patient
  Future<PatientResponse> createPatient(PatientRequest request);
  
  // Authentication
  Future<LoginResponse> login(String email, String password);
  Future<LoginResponse> signup(String fullName, String email, String password);
  

  Future<DoctorsResponse> getDoctors();
  Future<DoctorsResponse> searchDoctors(String query, String city);
  
  // Appointments
  Future<ApiResponse<String>> createAppointment(AppointmentRequest request);
  Future<ApiResponse<List<AppointmentResponse>>> getAppointments(String workScheduleId);
  Future<ApiResponse<void>> confirmAppointment(String id);
  Future<ApiResponse<void>> cancelAppointment(String id);
  
 
}
