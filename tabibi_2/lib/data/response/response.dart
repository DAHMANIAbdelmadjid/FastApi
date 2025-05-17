import 'package:json_annotation/json_annotation.dart';
import 'package:tabibi_2/domain/models/doctor.dart';

part 'response.g.dart';

@JsonSerializable()
class LoginResponse {
  final int? statusCode;
  final bool? succeeded;
  final String? message;
  final String? error;
  final String? data;

  LoginResponse({
    this.statusCode,
    this.succeeded,
    this.message,
    this.error,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class LoginData {
  final String? userId;
  final String? token;
  final String? id;
  final String? email;
  final String? fullName;
  final bool? isPatient;

  LoginData({
    this.userId,
    this.token,
    this.id,
    this.email,
    this.fullName,
    this.isPatient,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => _$LoginDataFromJson(json);
  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}

@JsonSerializable()
class DoctorResponse {
  final String? id;
  final String? firstName;
  final String? middelName;
  final String? lastName;
  final int? gender;
  final String? dateOfBirth;
  final String? phoneNumber;
  final String? emailAddress;
  final String? photoUrl;
  final String? notes;
  final String? clinicId;

  DoctorResponse({
    this.id,
    this.firstName,
    this.middelName,
    this.lastName,
    this.gender,
    this.dateOfBirth,
    this.phoneNumber,
    this.emailAddress,
    this.photoUrl,
    this.notes,
    this.clinicId,
  });

  factory DoctorResponse.fromJson(Map<String, dynamic> json) => _$DoctorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorResponseToJson(this);

  Doctor toDomain() => Doctor(
        id: id ?? "",
        firstName: firstName ?? "",
        middelName: middelName ?? "",
        lastName: lastName ?? "",
        gender: gender ?? 1,
        dateOfBirth: dateOfBirth != null ? DateTime.parse(dateOfBirth!) : DateTime(1970),
        phoneNumber: phoneNumber ?? "",
        emailAddress: emailAddress ?? "",
        photoUrl: photoUrl,
        notes: notes ?? "",
        clinicId: clinicId ?? "",
      );
}

@JsonSerializable()
class DoctorsResponse {
  final int? statusCode;
  final bool? succeeded;
  final String? message;
  final String? error;
  final List<DoctorResponse>? data;

  DoctorsResponse({
    this.statusCode,
    this.succeeded,
    this.message,
    this.error,
    this.data,
  });

  factory DoctorsResponse.fromJson(Map<String, dynamic> json) => _$DoctorsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorsResponseToJson(this);

  List<Doctor> toDomain() => data?.map((d) => d.toDomain()).toList() ?? [];
}
