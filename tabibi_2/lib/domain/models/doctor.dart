class Doctor {
  final String id;
  final String firstName;
  final String middelName;
  final String lastName;
  final int gender;
  final DateTime dateOfBirth;
  final String phoneNumber;
  final String emailAddress;
  final String? photoUrl;
  final String notes;
  final String clinicId;

  Doctor({
    required this.id,
    required this.firstName,
    required this.middelName,
    required this.lastName,
    required this.gender,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.emailAddress,
    this.photoUrl,
    required this.notes,
    required this.clinicId,
  });

  String get fullName => "$firstName $middelName $lastName".trim();

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      middelName: json['middelName'] as String,
      lastName: json['lastName'] as String,
      gender: json['gender'] as int,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      phoneNumber: json['phoneNumber'] as String,
      emailAddress: json['emailAddress'] as String,
      photoUrl: json['photoUrl'] as String?,
      notes: json['notes'] as String,
      clinicId: json['clinicId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'middelName': middelName,
      'lastName': lastName,
      'gender': gender,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'phoneNumber': phoneNumber,
      'emailAddress': emailAddress,
      'photoUrl': photoUrl,
      'notes': notes,
      'clinicId': clinicId,
    };
  }
}
