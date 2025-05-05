import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibi_2/app/core/app_colors.dart';
import 'package:tabibi_2/app/core/style_constants.dart';
import 'package:tabibi_2/app/core/styles.dart';
import 'package:tabibi_2/app/providers/patient_provider.dart';
import 'package:tabibi_2/domain/models/patient.dart';
import 'package:tabibi_2/widgets/custom_text_field.dart';

class PatientRegistrationScreen extends StatefulWidget {
  final String userId;
  final String email;
  final String fullName;

  const PatientRegistrationScreen({
    required this.userId,
    required this.email,
    required this.fullName,
    super.key,
  });

  @override
  State<PatientRegistrationScreen> createState() =>
      _PatientRegistrationScreenState();
}

class _PatientRegistrationScreenState extends State<PatientRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _birthDateController = TextEditingController();
  Gender _selectedGender = Gender.male;
  DateTime? _selectedDate;

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _birthDateController.text = picked.toString().split(' ')[0];
      });
    }
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final provider = context.read<PatientProvider>();

      await provider.createPatient(
        fullName: widget.fullName,
        gender: _selectedGender,
        birthDate: _selectedDate!,
        phoneNumber: _phoneNumberController.text,
        email: widget.email,
        userId: widget.userId,
      );

      if (!mounted) return;

      if (provider.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(provider.error!),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSize.s20),
                  Text(
                    "Patient Information",
                    style: getBoldStyle(
                      fontSize: FontSize.s26,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: AppSize.s16),
                  Text(
                    "Complete your profile",
                    style: getRegularStyle(
                      fontSize: FontSize.s18,
                      color: AppColors.textSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: AppSize.s24),
                  Text(
                    "Gender",
                    style: getSemiBoldStyle(
                      fontSize: FontSize.s16,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: AppSize.s8),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<Gender>(
                          title: const Text('Male'),
                          value: Gender.male,
                          groupValue: _selectedGender,
                          onChanged: (Gender? value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<Gender>(
                          title: const Text('Female'),
                          value: Gender.female,
                          groupValue: _selectedGender,
                          onChanged: (Gender? value) {
                            setState(() {
                              _selectedGender = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s16),
                  GestureDetector(
                    onTap: _selectDate,
                    child: AbsorbPointer(
                      child: CustomTextField(
                        text: "Birth Date",
                        controller: _birthDateController,
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select your birth date";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSize.s16),
                  CustomTextField(
                    text: "Phone Number",
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your phone number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSize.s24),
                  Consumer<PatientProvider>(
                    builder: (context, provider, child) {
                      return ElevatedButton(
                        onPressed: provider.isLoading ? null : _handleSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: const EdgeInsets.symmetric(
                            vertical: AppPadding.p12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: provider.isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "Complete Registration",
                                style: getBoldStyle(
                                  fontSize: FontSize.s16,
                                  color: Colors.white,
                                ),
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}