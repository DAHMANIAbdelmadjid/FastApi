// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:tabibi_2/widgets/card_profile_doc.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:intl/intl.dart';
// import 'package:tabibi_2/app/core/app_colors.dart';
// import 'package:tabibi_2/app/core/style_constants.dart';
// import 'package:tabibi_2/app/core/styles.dart';
// import 'package:tabibi_2/app/providers/appointment_provider.dart';
// import 'package:tabibi_2/app/providers/work_schedule_provider.dart';
// import 'package:tabibi_2/secrren/dar/payment .dart';

// class CombinedAppointmentScreen extends StatefulWidget {
//   final String doctorId; // Add this to receive doctor information

//   const CombinedAppointmentScreen({
//     Key? key,
//     required this.doctorId,
//   }) : super(key: key);

//   @override
//   State<CombinedAppointmentScreen> createState() =>
//       _CombinedAppointmentScreenState();
// }

// class _CombinedAppointmentScreenState extends State<CombinedAppointmentScreen> {
//   DateTime? selectedDate;
//   String? selectedTimeSlot;
//   List<String> availableTimeSlots = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Book Appointment',
//           style: getBoldStyle(
//             fontSize: FontSize.s20,
//             color: AppColors.textPrimaryColor,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios,
//               color: AppColors.textPrimaryColor),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(AppPadding.p16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildDoctorInfo(),
//               const SizedBox(height: AppSize.s20),
//               _buildPaymentSection(),
//               const SizedBox(height: AppSize.s20),
//               _buildDetailsSection(),
//               const SizedBox(height: AppSize.s20),
//               _buildCalendarSection(),
//               const SizedBox(height: AppSize.s20),
//               _buildTimeSlotSection(),
//               const SizedBox(height: AppSize.s30),
//               _buildBookAppointmentButton(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDoctorInfo() {
//     return CardProFileDoc();
//   }

//   Widget _buildPaymentSection() {
//     return Container(
//       padding: const EdgeInsets.all(AppPadding.p16),
//       decoration: BoxDecoration(
//         color: AppColors.secondaryColor.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Consultation Fee',
//                 style: getBoldStyle(
//                   fontSize: FontSize.s16,
//                   color: AppColors.textPrimaryColor,
//                 ),
//               ),
//               const SizedBox(height: AppSize.s4),
//               Text(
//                 'Includes one follow-up session',
//                 style: getRegularStyle(
//                   fontSize: FontSize.s12,
//                   color: AppColors.textSecondaryColor,
//                 ),
//               ),
//             ],
//           ),
//           Text(
//             '\$50',
//             style: getBoldStyle(
//               fontSize: FontSize.s20,
//               color: AppColors.primaryColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDetailsSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Details',
//           style: getBoldStyle(
//             fontSize: FontSize.s18,
//             color: AppColors.textPrimaryColor,
//           ),
//         ),
//         const SizedBox(height: AppSize.s8),
//         Text(
//           'Please select your preferred date and time for the appointment.',
//           style: getRegularStyle(
//             fontSize: FontSize.s14,
//             color: AppColors.textSecondaryColor,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildCalendarSection() {
//     return Container(
//       padding: const EdgeInsets.all(AppPadding.p16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               const Icon(
//                 Icons.calendar_today_rounded,
//                 color: AppColors.primaryColor,
//                 size: 24,
//               ),
//               const SizedBox(width: AppSize.s8),
//               Text(
//                 'Select Date',
//                 style: getBoldStyle(
//                   fontSize: FontSize.s18,
//                   color: AppColors.textPrimaryColor,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: AppSize.s16),
//           TableCalendar(
//             firstDay: DateTime.now(),
//             lastDay: DateTime.now().add(const Duration(days: 90)),
//             focusedDay: selectedDate ?? DateTime.now(),
//             calendarFormat: CalendarFormat.month,
//             selectedDayPredicate: (day) =>
//                 selectedDate != null && isSameDay(selectedDate!, day),
//             headerStyle: const HeaderStyle(formatButtonVisible: false),
//             onDaySelected: (selectedDay, focusedDay) async {
//               setState(() {
//                 selectedDate = selectedDay;
//                 selectedTimeSlot = null;
//               });
              
//               // Load available time slots for selected date
//               final workScheduleProvider = context.read<WorkScheduleProvider>();
//               await workScheduleProvider.getAvailableTimeSlots(widget.doctorId);
//             },
//             enabledDayPredicate: (day) {
//               // Disable past dates and weekends
//               return day.isAfter(
//                       DateTime.now().subtract(const Duration(days: 1))) &&
//                   day.weekday != DateTime.saturday &&
//                   day.weekday != DateTime.sunday;
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTimeSlotSection() {
//     return Container(
//       padding: const EdgeInsets.all(AppPadding.p16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               const Icon(
//                 Icons.access_time_rounded,
//                 color: AppColors.primaryColor,
//                 size: 24,
//               ),
//               const SizedBox(width: AppSize.s8),
//               Text(
//                 'Available Time Slots',
//                 style: getBoldStyle(
//                   fontSize: FontSize.s18,
//                   color: AppColors.textPrimaryColor,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: AppSize.s16),
//           Consumer<WorkScheduleProvider>(
//             builder: (context, provider, child) {
//               if (provider?.isLoading ?? false) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               if (provider?.error != null) {
//                 return Center(
//                   child: Text(
//                     provider!.error!,
//                     style: getRegularStyle(
//                       fontSize: FontSize.s14,
//                       color: Colors.red,
//                     ),
//                   ),
//                 );
//               }

//               final slots = provider?.availableTimeSlots ?? [];
//               if (slots.isEmpty) {
//                 return Center(
//                   child: Text(
//                     'No available time slots for selected date',
//                     style: getRegularStyle(
//                       fontSize: FontSize.s14,
//                       color: AppColors.textSecondaryColor,
//                     ),
//                   ),
//                 );
//               }

//               return SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: slots.map((time) {
//                     final isSelected = selectedTimeSlot == time;
//                     return Padding(
//                       padding: const EdgeInsets.only(right: AppPadding.p8),
//                       child: InkWell(
//                         onTap: () => setState(() => selectedTimeSlot = time),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: AppPadding.p16,
//                             vertical: AppPadding.p12,
//                           ),
//                           decoration: BoxDecoration(
//                             color:
//                                 isSelected ? AppColors.primaryColor : Colors.white,
//                             border: Border.all(
//                               color: isSelected
//                                   ? AppColors.primaryColor
//                                   : AppColors.dividerColor,
//                             ),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Text(
//                             time,
//                             style: getRegularStyle(
//                               fontSize: FontSize.s14,
//                               color: isSelected
//                                   ? Colors.white
//                                   : AppColors.textPrimaryColor,
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBookAppointmentButton() {
//     return Consumer<AppointmentProvider>(
//       builder: (context, provider, child) {
//         if (provider.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         return SizedBox(
//           width: double.infinity,
//           child: ElevatedButton(
//             onPressed: (selectedDate != null && selectedTimeSlot != null)
//                 ? () => _createAppointment(provider)
//                 : null,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.primaryColor,
//               padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             child: Text(
//               'Book Appointment',
//               style: getBoldStyle(
//                 fontSize: FontSize.s16,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _createAppointment(AppointmentProvider provider) async {
//     if (selectedDate == null || selectedTimeSlot == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please select both date and time')),
//       );
//       return;
//     }

//     // Parse the selected time to get appointment number
//     final timeComponents = selectedTimeSlot!.split(':');
//     int hour = int.parse(timeComponents[0]);
//     if (selectedTimeSlot!.endsWith('PM') && hour != 12) {
//       hour += 12;
//     }

//     // Calculate appointment number based on time slot (e.g., 10 AM = 1, 11 AM = 2, etc.)
//     final workScheduleProvider = context.read<WorkScheduleProvider>();
//     final slots = workScheduleProvider.availableTimeSlots ?? [];
//     final appointmentNumber = slots.indexOf(selectedTimeSlot!) + 1;
//     if (appointmentNumber < 1) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Invalid time slot selected')),
//       );
//       return;
//     }

//     final success = await provider.createAppointment(
//       workScheduleId: widget.doctorId,
//       patientId: "test-patient-id", // TODO: Use actual patient ID from auth
//       number: appointmentNumber,
//     );

//     if (success && mounted) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const Payment()),
//       );
//     } else if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(provider.error ?? 'Failed to book appointment')),
//       );
//     }
//   }
// }
