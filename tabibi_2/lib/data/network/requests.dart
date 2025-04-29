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
  final String workScheduleId;
  final String patientId;
  final String startTime;
  final String endTime;
  final String? notes;

  AppointmentRequest({
    required this.workScheduleId,
    required this.patientId,
    required this.startTime,
    required this.endTime,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'workScheduleId': workScheduleId,
      'patientId': patientId,
      'startTime': startTime,
      'endTime': endTime,
      if (notes != null) 'notes': notes,
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