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

WorkScheduleResponse _$WorkScheduleResponseFromJson(
        Map<String, dynamic> json) =>
    WorkScheduleResponse(
      id: json['id'] as String?,
      doctorId: json['doctorId'] as String?,
      availableTimes: (json['availableTimes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      date: json['date'] as String?,
    );

Map<String, dynamic> _$WorkScheduleResponseToJson(
        WorkScheduleResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctorId': instance.doctorId,
      'availableTimes': instance.availableTimes,
      'date': instance.date,
    };

AppointmentListResponse _$AppointmentListResponseFromJson(
        Map<String, dynamic> json) =>
    AppointmentListResponse(
      statusCode: (json['statusCode'] as num?)?.toInt(),
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      error: json['error'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AppointmentResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AppointmentListResponseToJson(
        AppointmentListResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'error': instance.error,
      'data': instance.data,
    };
