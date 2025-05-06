import 'package:flutter/material.dart';
import 'package:tabibi_2/app/core/app_colors.dart';
import 'package:tabibi_2/app/core/style_constants.dart';
import 'package:tabibi_2/app/core/styles.dart';
import 'package:tabibi_2/generated/l10n.dart';
import 'package:intl/intl.dart';

class CardProFileDoc extends StatefulWidget {
  const CardProFileDoc({super.key});

  @override
  State<CardProFileDoc> createState() => _CardProFileDocState();
}

class _CardProFileDocState extends State<CardProFileDoc> {
  DateTime selectedDate = DateTime.now();
  String selectedTime = '';
  final List<String> timeSlots = ['10:00 AM', '11:00 AM', '12:00 PM'];

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p8, vertical: AppPadding.p8),
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
                  icon: const Icon(Icons.verified_user,
                      color: AppColors.primaryColor, size: 20),
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
                  icon: const Icon(Icons.location_on,
                      color: AppColors.primaryColor, size: 20),
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
                  icon: const Icon(Icons.phone,
                      color: AppColors.primaryColor, size: 20),
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
                  icon: const Icon(Icons.chat,
                      color: AppColors.primaryColor, size: 20),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
