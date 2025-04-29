# Appointment Integration Plan

## 1. API Client Updates (app_api.dart)

Add the following endpoints to the AppApi class:

```dart
@POST("/api/appointment")
Future<ApiResponse<AppointmentResponse>> createAppointment(@Body() Map<String, dynamic> request);

@GET("/api/appointment/{workScheduleId}")
Future<ApiResponse<List<AppointmentResponse>>> getAppointments(@Path() String workScheduleId);

@PATCH("/api/appointment/confirm/{id}")
Future<ApiResponse<void>> confirmAppointment(@Path() String id);

@PATCH("/api/appointment/cancel/{id}")
Future<ApiResponse<void>> cancelAppointment(@Path() String id);
```

## 2. Response Models (appointment_response.dart)

Create new response models:

```dart
class AppointmentResponse {
  String? id;
  String? workScheduleId;
  String? patientId;
  String? startTime;
  String? endTime;
  String? status;
  String? notes;
  
  AppointmentResponse.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}

class WorkScheduleResponse {
  String? id;
  String? doctorId;
  List<String>? availableTimes;
  String? date;
  
  WorkScheduleResponse.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
```

## 3. Request Models (appointment_request.dart)

Create request models:

```dart
class AppointmentRequest {
  final String workScheduleId;
  final String patientId;
  final String startTime;
  final String endTime;
  final String? notes;
  
  Map<String, dynamic> toJson();
}
```

## 4. Repository Implementation

Update RepositoryImpl with new methods:

```dart
@override
Future<Either<Error, Appointment>> createAppointment(AppointmentRequest request) async {
  try {
    final response = await _remoteDataSource.createAppointment(request);
    if (response.succeeded == true) {
      return Right(response.data!.toDomain());
    } else {
      return Left(Error(response.statusCode ?? 0, response.error ?? 'Unknown error'));
    }
  } catch (e) {
    return Left(Error(-1, e.toString()));
  }
}

// Similar implementations for other appointment methods
```

## Next Steps:

1. Switch to Code mode
2. Implement these components in order:
   - Response models
   - Request models
   - API client updates
   - Repository implementation
3. Add unit tests for new components
4. Update the UI to use the new appointment functionality

## Notes:
- Ensure proper error handling throughout the implementation
- Add appropriate documentation
- Follow existing patterns in the codebase
- Consider adding retry logic for failed requests