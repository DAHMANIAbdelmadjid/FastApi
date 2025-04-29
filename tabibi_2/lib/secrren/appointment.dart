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
        IconButton(
          icon: const Icon(Icons.verified_user, color: AppColors.primaryColor),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildPaymentSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Payment',
          style: getSemiBoldStyle(
            fontSize: FontSize.s16,
            color: AppColors.textPrimaryColor,
          ),
        ),
        Text(
          '\$120.00',
          style: getBoldStyle(
            fontSize: FontSize.s16,
            color: AppColors.primaryColor,
          ),
        ),
      ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Working Hours',
              style: getBoldStyle(
                fontSize: FontSize.s18,
                color: AppColors.textPrimaryColor,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'See All',
                style: getRegularStyle(
                  fontSize: FontSize.s14,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSize.s8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTimeChip('10:00 AM'),
            _buildTimeChip('11:00 AM'),
            _buildTimeChip('12:00 PM'),
          ],
        ),
      ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date',
              style: getBoldStyle(
                fontSize: FontSize.s18,
                color: AppColors.textPrimaryColor,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'See All',
                style: getRegularStyle(
                  fontSize: FontSize.s14,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSize.s8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildDateChip('Sun 4', true),
            _buildDateChip('Mon 5', false),
            _buildDateChip('Tue 6', false),
          ],
        ),
      ],
    );
  }

  Widget _buildDateChip(String date, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p16,
        vertical: AppPadding.p8,
      ),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryColor : Colors.transparent,
        border: Border.all(
          color: isSelected ? AppColors.primaryColor : AppColors.dividerColor,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        date,
        style: getRegularStyle(
          fontSize: FontSize.s14,
          color: isSelected ? Colors.white : AppColors.textPrimaryColor,
        ),
      ),
    );
  }

  Widget _buildTimeSlotSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Available Time Slot',
              style: getBoldStyle(
                fontSize: FontSize.s18,
                color: AppColors.textPrimaryColor,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'See All',
                style: getRegularStyle(
                  fontSize: FontSize.s14,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSize.s8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTimeSlotChip('10:00 AM', false),
            _buildTimeSlotChip('11:00 AM', true),
            _buildTimeSlotChip('12:00 PM', false),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeSlotChip(String time, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p16,
        vertical: AppPadding.p8,
      ),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryColor : Colors.transparent,
        border: Border.all(
          color: isSelected ? AppColors.primaryColor : AppColors.dividerColor,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        time,
        style: getRegularStyle(
          fontSize: FontSize.s14,
          color: isSelected ? Colors.white : AppColors.textPrimaryColor,
        ),
      ),
    );
  }

  Widget _buildBookAppointmentButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'Book an Appointment',
          style: getBoldStyle(
            fontSize: FontSize.s16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
