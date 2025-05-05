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



