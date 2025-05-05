// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientResponse _$PatientResponseFromJson(Map<String, dynamic> json) =>
    PatientResponse(
      statusCode: (json['statusCode'] as num?)?.toInt(),
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      error: json['error'] as String?,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$PatientResponseToJson(PatientResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'error': instance.error,
      'data': instance.data,
    };
