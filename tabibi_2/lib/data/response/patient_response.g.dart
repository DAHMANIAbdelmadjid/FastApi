// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientData _$PatientDataFromJson(Map<String, dynamic> json) => PatientData(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      gender: (json['gender'] as num?)?.toInt(),
      birthDate: json['birthDate'] as String?,
      state: json['state'] as String?,
      city: json['city'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$PatientDataToJson(PatientData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'gender': instance.gender,
      'birthDate': instance.birthDate,
      'state': instance.state,
      'city': instance.city,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
    };

PatientResponse _$PatientResponseFromJson(Map<String, dynamic> json) =>
    PatientResponse(
      statusCode: (json['statusCode'] as num?)?.toInt(),
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      error: json['error'] as String?,
      data: _parseData(json['data']),
    );

Map<String, dynamic> _$PatientResponseToJson(PatientResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'error': instance.error,
      'data': _writeData(instance.data),
    };
