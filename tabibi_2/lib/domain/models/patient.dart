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
    try {
      return Patient(
        id: json['id']?.toString() ?? '',
        fullName: json['fullName']?.toString() ?? '',
        gender: Gender.fromInt(json['gender'] as int? ?? 0),
        birthDate: json['birthDate'] != null
          ? DateTime.tryParse(json['birthDate'].toString()) ?? DateTime.now()
          : DateTime.now(),
        phoneNumber: json['phoneNumber']?.toString() ?? '',
        email: json['email']?.toString() ?? '',
        userId: json['userId']?.toString() ?? json['id']?.toString() ?? '', // Fallback to id if userId is not present
      );
    } catch (e) {
      print('Error parsing patient data: $e');
      throw FormatException('Failed to parse patient data: $e');
    }
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