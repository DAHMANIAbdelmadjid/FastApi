// import 'package:flutter/foundation.dart';
// import 'package:tabibi_2/data/data_source/remote_data_source.dart';
// import 'package:tabibi_2/data/network/requests.dart';
// import 'package:tabibi_2/data/response/api_response.dart';

// class WorkScheduleProvider extends ChangeNotifier {
//   final RemoteDataSource _remoteDataSource;
//   bool _isLoading = false;
//   String? _error;
//   List<String>? _availableTimeSlots;

//   WorkScheduleProvider(this._remoteDataSource);

//   bool get isLoading => _isLoading;
//   String? get error => _error;
//   List<String>? get availableTimeSlots => _availableTimeSlots;

//   Future<bool> createWorkSchedule({
//     required String doctorId,
//     required DateTime date,
//     required int maxAppointmentsCount,
//   }) async {
//     try {
//       _isLoading = true;
//       _error = null;
//       notifyListeners();

//       final request = WorkScheduleRequest(
//         doctorId: doctorId,
//         date: date.toIso8601String(),
//         availableTimes: generateTimeSlots(maxAppointmentsCount),
//       );

//       final response = await _remoteDataSource.createWorkSchedule(request);
      
//       _isLoading = false;
//       if (response.succeeded == true) {
//         notifyListeners();
//         return true;
//       } else {
//         _error = response.error ?? 'Failed to create work schedule';
//         notifyListeners();
//         return false;
//       }
//     } catch (e) {
//       _isLoading = false;
//       _error = e.toString();
//       notifyListeners();
//       return false;
//     }
//   }

//   Future<List<String>?> getAvailableTimeSlots(String workScheduleId) async {
//     try {
//       _isLoading = true;
//       _error = null;
//       _availableTimeSlots = null;
//       notifyListeners();

//       final response = await _remoteDataSource.getAppointments(workScheduleId);
      
//       _isLoading = false;
//       if (response.succeeded == true && response.data != null) {
//         // Process time slots from appointments
//         // Filter out taken slots
//         final takenSlots = response.data!.map((apt) => apt.number).toSet();
//         _availableTimeSlots = timeSlots
//             .asMap()
//             .entries
//             .where((entry) => !takenSlots.contains(entry.key + 1))
//             .map((entry) => entry.value)
//             .toList();
            
//         notifyListeners();
//         return _availableTimeSlots;
//       } else {
//         _error = response.error ?? 'Failed to get available time slots';
//         notifyListeners();
//         return null;
//       }
//     } catch (e) {
//       _isLoading = false;
//       _error = e.toString();
//       notifyListeners();
//       return null;
//     }
//   }

//   // Default time slots (can be customized based on clinic hours)
//   static const List<String> timeSlots = [
//     '10:00 AM',
//     '11:00 AM',
//     '12:00 PM',
//     '2:00 PM',
//     '3:00 PM'
//   ];

//   List<String> generateTimeSlots(int count) {
//     return timeSlots.take(count).toList();
//   }
// }