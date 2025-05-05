import 'package:json_annotation/json_annotation.dart';

part 'patient_response.g.dart';

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
  @JsonKey(name: 'data')
  String? data;


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