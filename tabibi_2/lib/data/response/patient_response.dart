import 'package:json_annotation/json_annotation.dart';

part 'patient_response.g.dart';

@JsonSerializable()
class PatientData {
  String? id;
  String? fullName;
  int? gender;
  String? birthDate;
  String? state;
  String? city;
  String? phoneNumber;
  String? email;

  PatientData({
    this.id,
    this.fullName,
    this.gender,
    this.birthDate,
    this.state,
    this.city,
    this.phoneNumber,
    this.email,
  });

  factory PatientData.fromJson(Map<String, dynamic> json) =>
      _$PatientDataFromJson(json);

  Map<String, dynamic> toJson() => _$PatientDataToJson(this);
}

@JsonSerializable()
class PatientResponse {
  @JsonKey(name: 'statusCode')
  int? statusCode;

  @JsonKey(name: 'succeeded')
  bool? succeeded;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'error')
  String? error;

  @JsonKey(
    name: 'data',
    fromJson: _parseData,
    toJson: _writeData,
  )
  dynamic data;

  PatientResponse({
    this.statusCode,
    this.succeeded,
    this.message,
    this.error,
    this.data,
  });

  factory PatientResponse.fromJson(Map<String, dynamic> json) =>
      _$PatientResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PatientResponseToJson(this);
}

// ✅ لتحويل قيمة data بناءً على نوعها في JSON
dynamic _parseData(dynamic json) {
  if (json == null) {
    return null;
  }
  if (json is Map<String, dynamic>) {
    return PatientData.fromJson(json);
  } else if (json is String) {
    return json;
  } else if (json is List) {
    // Handle list type if the API returns an array
    return json.map((item) =>
      item is Map<String, dynamic> ? PatientData.fromJson(item) : item
    ).toList();
  }
  return json.toString(); // Convert other types to string rather than returning null
}

// ✅ لعكس العملية عند تحويل الكائن إلى JSON
dynamic _writeData(dynamic value) {
  if (value == null) {
    return null;
  }
  if (value is PatientData) {
    return value.toJson();
  } else if (value is List) {
    return value.map((item) =>
      item is PatientData ? item.toJson() : item
    ).toList();
  } else if (value is String) {
    return value;
  }
  return value.toString(); // Convert any other type to string
}
