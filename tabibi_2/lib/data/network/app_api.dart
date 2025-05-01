import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:tabibi_2/data/response/response.dart';
import 'package:tabibi_2/data/response/appointment_response.dart';
import 'package:tabibi_2/data/response/api_response.dart';
import 'package:tabibi_2/data/network/requests.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: "http://localhost:5245")
abstract class AppApi {
  factory AppApi(Dio dio, {String baseUrl}) = _AppApi;

  @POST("/api/authenfication/signin")
  Future<LoginResponse> login(
    @Field("emailOrUserName") String email,
    @Field("password") String password,
  );

  @POST("/api/authenfication/signup")
  Future<LoginResponse> signup(
    @Field("fullName") String fullName,
    @Field("email") String email,
    @Field("password") String password,
    // @Field("phoneNumber") String phoneNumber,
  );

  @GET("/api/cities")
  Future<CitiesResponse> getCities();

  @GET("/api/cities/search")
  Future<CitiesResponse> searchCities(@Query("query") String query);

  @GET("/api/doctors")
  Future<DoctorsResponse> getDoctors();

  @GET("/api/doctors/search")
  Future<DoctorsResponse> searchDoctors(
      @Query("query") String query, @Query("city") String city);

  @POST("/api/appointment")
  Future<ApiResponse<AppointmentResponse>> createAppointment(
    @Body() AppointmentRequest request,
  );

  @GET("/api/appointment/{workScheduleId}")
  Future<ApiResponse<List<AppointmentResponse>>> getAppointments(
    @Path() String workScheduleId,
  );

  @PATCH("/api/appointment/confirm/{id}")
  Future<ApiResponse<void>> confirmAppointment(@Path() String id);

  @PATCH("/api/appointment/cancel/{id}")
  Future<ApiResponse<void>> cancelAppointment(@Path() String id);

  @GET("/api/work-schedule")
  Future<ApiResponse<List<WorkScheduleResponse>>> getWorkSchedules();

  @POST("/api/work-schedule")
  Future<ApiResponse<WorkScheduleResponse>> createWorkSchedule(
    @Body() WorkScheduleRequest request,
  );
}
