import 'package:json_annotation/json_annotation.dart';
import 'package:tabibi_2/domain/models/doctor.dart';

part 'response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'error')
  String? error;
  @JsonKey(name: 'data')
  String? data;

  LoginResponse({
    this.statusCode,
    this.succeeded,
    this.message,
    this.error,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  String? get token => data;
}

@JsonSerializable()
class LoginData {
  @JsonKey(name: 'token')
  String? token;
  @JsonKey(name: 'userId')
  String? userId;

  LoginData({
    this.token,
    this.userId,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);
  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}




class DoctorsResponse {
  int? statusCode;
  bool? succeeded;
  String? message;
  String? error;
  List<DoctorResponse>? data;

  DoctorsResponse({
    this.statusCode,
    this.succeeded,
    this.message,
    this.error,
    this.data,
  });

  factory DoctorsResponse.fromJson(Map<String, dynamic> json) => DoctorsResponse(
        statusCode: json["statusCode"],
        succeeded: json["succeeded"],
        message: json["message"],
        error: json["error"],
        data: json["data"] == null
            ? []
            : List<DoctorResponse>.from(
                json["data"].map((x) => DoctorResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "succeeded": succeeded,
        "message": message,
        "error": error,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DoctorResponse {
  int? id;
  String? name;
  String? specialty;
  String? imageUrl;
  String? city;
  double? rating;

  DoctorResponse({
    this.id,
    this.name,
    this.specialty,
    this.imageUrl,
    this.city,
    this.rating,
  });

  factory DoctorResponse.fromJson(Map<String, dynamic> json) => DoctorResponse(
        id: json["id"],
        name: json["name"],
        specialty: json["specialty"],
        imageUrl: json["imageUrl"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "specialty": specialty,
        "imageUrl": imageUrl,
        "city": city,
        "rating": rating,
      };

  toDomain() => Doctor(
        id: id ?? 0,
        name: name ?? '',
        specialty: specialty ?? '',
        imageUrl: imageUrl ?? '',
        city: city ?? '',
        rating: rating ?? 0.0,
        address: '', // Provide a default or appropriate value for 'address'
      );
}
