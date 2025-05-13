class LoginRequest {
  final String emailOrUserName;
  final String password;

  LoginRequest(this.emailOrUserName, this.password);

  Map<String, dynamic> toJson() {
    return {
      'emailOrUserName': emailOrUserName,
      'password': password,
    };
  }
}

class AppointmentRequest {
  final int number;
  final String patientId;
  final String workScheduleId;

  AppointmentRequest({
    required this.number,
    required this.patientId,
    required this.workScheduleId,
  });

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'patientId': patientId,
      'workScheduleId': workScheduleId,
    };
  }
}

class UpdateAppointmentRequest {
  final String id;
  final int number;
  final String workScheduleId;

  UpdateAppointmentRequest({
    required this.id,
    required this.number,
    required this.workScheduleId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'workScheduleId': workScheduleId,
    };
  }
}

class WorkScheduleRequest {
  final String doctorId;
  final String date;
  final List<String> availableTimes;

  WorkScheduleRequest({
    required this.doctorId,
    required this.date,
    required this.availableTimes,
  });

  Map<String, dynamic> toJson() {
    return {
      'doctorId': doctorId,
      'date': date,
      'availableTimes': availableTimes,
    };
  }
}

class PatientRequest {
  final String fullName;
  final int gender;
  final String birthDate;
  final String phoneNumber;
  final String email;
  final String userId;

  PatientRequest({
    required this.fullName,
    required this.gender,
    required this.birthDate,
    required this.phoneNumber,
    required this.email,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'gender': gender,
      'birthDate': birthDate,
      'phoneNumber': phoneNumber,
      'email': email,
      'userId': userId,
    };
  }
}