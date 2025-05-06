import 'package:flutter/material.dart';
import 'package:tabibi_2/app/core/app_colors.dart';
import 'package:tabibi_2/app/core/style_constants.dart';
import 'package:tabibi_2/app/core/styles.dart';
import 'package:tabibi_2/generated/l10n.dart';
import 'package:intl/intl.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime selectedDate = DateTime.now();
  String selectedTime = '';
  final List<String> timeSlots = ['10:00 AM', '11:00 AM', '12:00 PM'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appointment',
          style: getBoldStyle(
            fontSize: FontSize.s20,
            color: AppColors.textPrimaryColor,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: AppColors.textPrimaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDoctorInfo(),
              const SizedBox(height: AppSize.s20),
              _buildPaymentSection(),
              const SizedBox(height: AppSize.s20),
              _buildDetailsSection(),
              const SizedBox(height: AppSize.s20),
              _buildWorkingHoursSection(),
              const SizedBox(height: AppSize.s20),
              _buildDateSection(),
              const SizedBox(height: AppSize.s20),
              _buildTimeSlotSection(),
              const SizedBox(height: AppSize.s30),
              _buildBookAppointmentButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorInfo() {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.secondaryColor,
          child: Text(
            'D',
            style: getBoldStyle(
              fontSize: FontSize.s20,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        const SizedBox(width: AppSize.s16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dr.Upul',
              style: getBoldStyle(
                fontSize: FontSize.s18,
                color: AppColors.textPrimaryColor,
              ),
            ),
            Text(
              'Dermatologist',
              style: getRegularStyle(
                fontSize: FontSize.s14,
                color: AppColors.textSecondaryColor,
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p8),
          decoration: BoxDecoration(
            color: AppColors.secondaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(right: AppSize.s8),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  tooltip: 'Verified Doctor',
                  icon: const Icon(Icons.verified_user, color: AppColors.primaryColor, size: 20),
                  onPressed: () {},
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: AppSize.s8),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  tooltip: 'Location',
                  icon: const Icon(Icons.location_on, color: AppColors.primaryColor, size: 20),
                  onPressed: () {},
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: AppSize.s8),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  tooltip: 'Call',
                  icon: const Icon(Icons.phone, color: AppColors.primaryColor, size: 20),
                  onPressed: () {},
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  tooltip: 'Message',
                  icon: const Icon(Icons.chat, color: AppColors.primaryColor, size: 20),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentSection() {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Consultation Fee',
                style: getBoldStyle(
                  fontSize: FontSize.s16,
                  color: AppColors.textPrimaryColor,
                ),
              ),
              const SizedBox(height: AppSize.s4),
              Text(
                'Includes one follow-up session',
                style: getRegularStyle(
                  fontSize: FontSize.s12,
                  color: AppColors.textSecondaryColor,
                ),
              ),
            ],
          ),
          Text(
            '\$50',
            style: getBoldStyle(
              fontSize: FontSize.s20,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Details',
          style: getBoldStyle(
            fontSize: FontSize.s18,
            color: AppColors.textPrimaryColor,
          ),
        ),
        const SizedBox(height: AppSize.s8),
        Text(
          'Patient details about an illness or symptoms, any previous medical conditions, and the purpose of the appointment. Doctor notes may be added here to summarize the patient\'s condition or to note any specific preparations needed for the appointment.',
          style: getRegularStyle(
            fontSize: FontSize.s14,
            color: AppColors.textSecondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildWorkingHoursSection() {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.access_time_rounded,
                    color: AppColors.primaryColor,
                    size: 24,
                  ),
                  const SizedBox(width: AppSize.s8),
                  Text(
                    'Working Hours',
                    style: getBoldStyle(
                      fontSize: FontSize.s18,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.calendar_month,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSize.s16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildTimeChip('09:00 AM'),
                const SizedBox(width: AppSize.s8),
                _buildTimeChip('10:00 AM'),
                const SizedBox(width: AppSize.s8),
                _buildTimeChip('11:00 AM'),
                const SizedBox(width: AppSize.s8),
                _buildTimeChip('12:00 PM'),
                const SizedBox(width: AppSize.s8),
                _buildTimeChip('02:00 PM'),
                const SizedBox(width: AppSize.s8),
                _buildTimeChip('03:00 PM'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeChip(String time) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p16,
        vertical: AppPadding.p8,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        time,
        style: getRegularStyle(
          fontSize: FontSize.s14,
          color: AppColors.textPrimaryColor,
        ),
      ),
    );
  }

  Widget _buildDateSection() {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_rounded,
                    color: AppColors.primaryColor,
                    size: 24,
                  ),
                  const SizedBox(width: AppSize.s8),
                  Text(
                    'Select Date',
                    style: getBoldStyle(
                      fontSize: FontSize.s18,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                ],
              ),
              Text(
                DateFormat('MMMM yyyy').format(selectedDate),
                style: getRegularStyle(
                  fontSize: FontSize.s14,
                  color: AppColors.textSecondaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSize.s16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < 7; i++)
                  Padding(
                    padding: const EdgeInsets.only(right: AppPadding.p8),
                    child: _buildDateChip(
                      DateFormat('EEE\nd').format(
                        DateTime.now().add(Duration(days: i)),
                      ),
                      i == 0,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateChip(String date, bool isSelected) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedDate = DateTime.now().add(
            Duration(days: int.parse(date.split('\n')[1]) - DateTime.now().day),
          );
        });
      },
      child: Container(
        width: 65,
        padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p12,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.white,
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : AppColors.dividerColor,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected ? [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ] : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              date.split('\n')[0],
              style: getRegularStyle(
                fontSize: FontSize.s12,
                color: isSelected ? Colors.white : AppColors.textSecondaryColor,
              ),
            ),
            const SizedBox(height: AppSize.s4),
            Text(
              date.split('\n')[1],
              style: getBoldStyle(
                fontSize: FontSize.s16,
                color: isSelected ? Colors.white : AppColors.textPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSlotSection() {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.access_time_rounded,
                    color: AppColors.primaryColor,
                    size: 24,
                  ),
                  const SizedBox(width: AppSize.s8),
                  Text(
                    'Available Time Slots',
                    style: getBoldStyle(
                      fontSize: FontSize.s18,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                ],
              ),
              Text(
                '${timeSlots.length} slots',
                style: getRegularStyle(
                  fontSize: FontSize.s14,
                  color: AppColors.textSecondaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSize.s16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: timeSlots.map((time) {
                bool isSelected = selectedTime == time;
                return Padding(
                  padding: const EdgeInsets.only(right: AppPadding.p8),
                  child: _buildTimeSlotChip(time, isSelected),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlotChip(String time, bool isSelected) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedTime = time;
        });
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p12,
          horizontal: AppPadding.p8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.white,
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : AppColors.dividerColor,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected ? [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ] : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.access_time_rounded,
              size: 16,
              color: isSelected ? Colors.white : AppColors.textSecondaryColor,
            ),
            const SizedBox(width: AppSize.s4),
            Text(
              time,
              style: getRegularStyle(
                fontSize: FontSize.s14,
                color: isSelected ? Colors.white : AppColors.textPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookAppointmentButton() {
    bool isValid = selectedTime.isNotEmpty;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isValid
            ? () {
                // Handle appointment booking
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Appointment booked for ${DateFormat('MMMM d').format(selectedDate)} at $selectedTime',
                      style: getRegularStyle(
                        fontSize: FontSize.s14,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: AppColors.primaryColor,
                    duration: const Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          disabledBackgroundColor: Colors.grey[300],
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isValid ? Icons.calendar_month_outlined : Icons.calendar_today_rounded,
              color: isValid ? Colors.white : const Color(0xFF757575),
            ),
            const SizedBox(width: AppSize.s8),
            Text(
              isValid ? 'Book Appointment' : 'Select a time slot',
              style: getBoldStyle(
                fontSize: FontSize.s16,
                color: isValid ? Colors.white : const Color(0xFF757575),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
