enum Gender {
  male(0),
  female(1);

  final int value;
  const Gender(this.value);

  static Gender fromInt(int value) {
    return Gender.values.firstWhere(
      (gender) => gender.value == value,
      orElse: () => throw ArgumentError('Invalid gender value: $value'),
    );
  }
}

class Patient {
  final String id;
  final String fullName;
  final Gender gender;
  final DateTime birthDate;
  final String phoneNumber;
  final String email;
  final String userId;

  Patient({
    required this.id,
    required this.fullName,
    required this.gender,
    required this.birthDate,
    required this.phoneNumber,
    required this.email,
    required this.userId,
  });

  factory Patient.fromResponse(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      gender: Gender.fromInt(json['gender'] as int),
      birthDate: DateTime.parse(json['birthDate'] as String),
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      userId: json['userId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'gender': gender.value,
      'birthDate': birthDate.toIso8601String(),
      'phoneNumber': phoneNumber,
      'email': email,
      'userId': userId,
    };
  }
}