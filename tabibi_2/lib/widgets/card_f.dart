import 'package:flutter/material.dart';
import 'package:tabibi_2/app/core/app_colors.dart';
import 'package:tabibi_2/app/core/style_constants.dart';
import 'package:tabibi_2/app/core/styles.dart';
import 'package:tabibi_2/generated/l10n.dart';
import 'package:tabibi_2/domain/models/patient.dart';

class CardImageAndProFile extends StatelessWidget {
  final String? imageUrl;
  final Patient patient;

  const CardImageAndProFile({
    super.key,
    this.imageUrl,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    int i = 0;
    if (patient.gender == Gender.female) {
      i = 1;
    }
    return Card(
      elevation: 4.0,
      color: AppColors.secondaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: (imageUrl != null && imageUrl!.isNotEmpty)
                        ? NetworkImage(imageUrl!)
                        : AssetImage('assets/icon/profile$i.png')
                            as ImageProvider,
                  ),
                  const SizedBox(width: AppSize.s16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).welcome,
                        style: getRegularStyle(
                          color: AppColors.textSecondaryColor,
                          fontSize: FontSize.s14,
                        ),
                      ),
                      Text(
                        patient.fullName,
                        style: getSemiBoldStyle(
                          color: AppColors.textPrimaryColor,
                          fontSize: FontSize.s16,
                        ),
                      ),
                      const SizedBox(height: AppSize.s8),
                      Row(
                        children: [
                          Icon(
                            patient.gender == Gender.male
                                ? Icons.male
                                : Icons.female,
                            size: 16,
                            color: AppColors.textSecondaryColor,
                          ),
                          const SizedBox(width: AppSize.s4),
                          Text(
                            patient.phoneNumber,
                            style: getRegularStyle(
                              color: AppColors.textSecondaryColor,
                              fontSize: FontSize.s12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
