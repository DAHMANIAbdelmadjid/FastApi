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
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'specialty')
  final String? specialty;
  @JsonKey(name: 'city')
  final String? city;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;
  @JsonKey(name: 'rating')
  final num? rating;
  @JsonKey(name: 'reviewCount')
  final int? reviewCount;

  DoctorResponse({
    this.id,
    this.name,
    this.specialty,
    this.city,
    this.address,
    this.description,
    this.imageUrl,
    this.rating,
    this.reviewCount,
  });

  factory DoctorResponse.fromJson(Map<String, dynamic> json) => _$DoctorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorResponseToJson(this);

  Doctor toDomain() => Doctor(
        id: id ?? '',
        name: name ?? '',
        specialty: specialty ?? '',
        city: city ?? '',
        address: address ?? '',
        description: description ?? '',
        imageUrl: imageUrl ?? '',
        rating: (rating ?? 0.0).toDouble(),
        reviewCount: reviewCount ?? 0,
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
