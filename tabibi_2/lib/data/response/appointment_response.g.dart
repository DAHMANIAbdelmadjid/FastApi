// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentResponse _$AppointmentResponseFromJson(Map<String, dynamic> json) =>
    AppointmentResponse(
      id: json['id'] as String?,
      workScheduleId: json['workScheduleId'] as String?,
      patientId: json['patientId'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      status: json['status'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$AppointmentResponseToJson(
        AppointmentResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'workScheduleId': instance.workScheduleId,
      'patientId': instance.patientId,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'status': instance.status,
      'notes': instance.notes,
    };
