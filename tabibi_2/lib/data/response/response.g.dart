// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      statusCode: (json['statusCode'] as num?)?.toInt(),
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      error: json['error'] as String?,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'error': instance.error,
      'data': instance.data,
    };

LoginData _$LoginDataFromJson(Map<String, dynamic> json) => LoginData(
      userId: json['userId'] as String?,
      token: json['token'] as String?,
      id: json['id'] as String?,
      email: json['email'] as String?,
      fullName: json['fullName'] as String?,
      isPatient: json['isPatient'] as bool?,
    );

Map<String, dynamic> _$LoginDataToJson(LoginData instance) => <String, dynamic>{
      'userId': instance.userId,
      'token': instance.token,
      'id': instance.id,
      'email': instance.email,
      'fullName': instance.fullName,
      'isPatient': instance.isPatient,
    };

DoctorResponse _$DoctorResponseFromJson(Map<String, dynamic> json) =>
    DoctorResponse(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      middelName: json['middelName'] as String?,
      lastName: json['lastName'] as String?,
      gender: (json['gender'] as num?)?.toInt(),
      dateOfBirth: json['dateOfBirth'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      emailAddress: json['emailAddress'] as String?,
      photoUrl: json['photoUrl'] as String?,
      notes: json['notes'] as String?,
      clinicId: json['clinicId'] as String?,
    );

Map<String, dynamic> _$DoctorResponseToJson(DoctorResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'middelName': instance.middelName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth,
      'phoneNumber': instance.phoneNumber,
      'emailAddress': instance.emailAddress,
      'photoUrl': instance.photoUrl,
      'notes': instance.notes,
      'clinicId': instance.clinicId,
    };

DoctorsResponse _$DoctorsResponseFromJson(Map<String, dynamic> json) =>
    DoctorsResponse(
      statusCode: (json['statusCode'] as num?)?.toInt(),
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      error: json['error'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DoctorResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DoctorsResponseToJson(DoctorsResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'error': instance.error,
      'data': instance.data,
    };
