import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:tabibi_2/data/response/patient_response.dart';
import 'package:tabibi_2/data/response/response.dart';
import 'package:tabibi_2/data/response/appointment_response.dart';
import 'package:tabibi_2/data/response/api_response.dart';
import 'package:tabibi_2/data/network/requests.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: "http://localhost:5245")
abstract class AppApi {
  factory AppApi(Dio dio, {String baseUrl}) = _AppApi;

  @POST("/api/patients")
  Future<PatientResponse> createPatient(
    @Body() PatientRequest request,
  );
@GET("/api/patients")
Future<PatientResponse> getPatient(
  @Header("Authorization") String token,
);



  @POST("/api/authenfication/signin")
  Future<LoginResponse> login(
    @Field("emailOrUserName") String email,
    @Field("password") String password,
  );

  @POST("/api/authenfication/signup")
  Future<LoginResponse> signup(
    @Field("userName") String fullName,
    @Field("email") String email,
    @Field("password") String password,
  );

  @GET("/api/clinic/doctors")
  Future<DoctorsResponse> getDoctors();


  @POST("/api/appointment")
  Future<ApiResponse<String>> createAppointment(
    @Body() AppointmentRequest request,
  );

  @PUT("/api/appointment")
  Future<ApiResponse<String>> updateAppointment(
    @Body() UpdateAppointmentRequest request,
  );

  @GET("/api/appointment/{workScheduleId}")
  Future<ApiResponse<List<AppointmentResponse>>> getAppointments(
    @Path() String workScheduleId,
  );

  @PATCH("/api/appointment/confirm/{id}")
  Future<ApiResponse<String>> confirmAppointment(@Path() String id);

  @PATCH("/api/appointment/cancel/{id}")
  Future<ApiResponse<String>> cancelAppointment(@Path() String id);

  @GET("/api/work-schedule")
  Future<ApiResponse<String>> getWorkSchedule(
    @Body() WorkScheduleRequest request,
  );
}
