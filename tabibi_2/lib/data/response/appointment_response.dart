import 'package:json_annotation/json_annotation.dart';

part 'appointment_response.g.dart';

@JsonSerializable()
class AppointmentResponse {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'workScheduleId')
  String? workScheduleId;

  @JsonKey(name: 'patientId')
  String? patientId;

  @JsonKey(name: 'startTime')
  String? startTime;

  @JsonKey(name: 'endTime')
  String? endTime;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'notes')
  String? notes;

  AppointmentResponse({
    this.id,
    this.workScheduleId,
    this.patientId,
    this.startTime,
    this.endTime,
    this.status,
    this.notes,
  });

  factory AppointmentResponse.fromJson(Map<String, dynamic> json) =>
      _$AppointmentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentResponseToJson(this);
}

@JsonSerializable()
class WorkScheduleResponse {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'doctorId')
  String? doctorId;

  @JsonKey(name: 'availableTimes')
  List<String>? availableTimes;

  @JsonKey(name: 'date')
  String? date;

  WorkScheduleResponse({
    this.id,
    this.doctorId,
    this.availableTimes,
    this.date,
  });

  factory WorkScheduleResponse.fromJson(Map<String, dynamic> json) =>
      _$WorkScheduleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WorkScheduleResponseToJson(this);
}

@JsonSerializable()
class AppointmentListResponse {
  @JsonKey(name: 'statusCode')
  int? statusCode;

  @JsonKey(name: 'succeeded')
  bool? succeeded;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'error')
  String? error;

  @JsonKey(name: 'data')
  List<AppointmentResponse>? data;

  AppointmentListResponse({
    this.statusCode,
    this.succeeded,
    this.message,
    this.error,
    this.data,
  });

  factory AppointmentListResponse.fromJson(Map<String, dynamic> json) =>
      _$AppointmentListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentListResponseToJson(this);
}