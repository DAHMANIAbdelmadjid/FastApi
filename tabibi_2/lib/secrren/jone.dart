import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tabibi_2/app/core/app_colors.dart';
import 'package:tabibi_2/app/core/style_constants.dart';
import 'package:tabibi_2/app/core/styles.dart';
import 'package:tabibi_2/app/providers/patient_provider.dart';
import 'package:tabibi_2/generated/l10n.dart';
import 'package:tabibi_2/widgets/card_f.dart';
import 'package:tabibi_2/widgets/card_introdaction.dart';

class AlgeriaCityData {
  final int id;
  final String communeNameAscii;
  final String communeName;
  final String wilayaCode;
  final String wilayaNameAscii;
  final String wilayaName;

  AlgeriaCityData({
    required this.id,
    required this.communeNameAscii,
    required this.communeName,
    required this.wilayaCode,
    required this.wilayaNameAscii,
    required this.wilayaName,
  });

  factory AlgeriaCityData.fromJson(Map<String, dynamic> json) {
    return AlgeriaCityData(
      id: json['id'],
      communeNameAscii: json['commune_name_ascii'],
      communeName: json['commune_name'],
      wilayaCode: json['wilaya_code'],
      wilayaNameAscii: json['wilaya_name_ascii'],
      wilayaName: json['wilaya_name'],
    );
  }
}

class JoneScreen extends StatefulWidget {
  const JoneScreen({super.key});

  @override
  State<JoneScreen> createState() => _JoneScreenState();
}

class _JoneScreenState extends State<JoneScreen> {
  final PageController _pageController = PageController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  List<AlgeriaCityData> allCities = [];
  String? selectedState;
  String? selectedMunicipality;
  List<String> states = [];
  List<String> municipalities = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    loadCitiesData();
  }

  Future<void> loadCitiesData() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      final String jsonString = await rootBundle.loadString('assets/wilaya/algeria_cities.json');
      final List<dynamic> jsonData = json.decode(jsonString);
      
      setState(() {
        allCities = jsonData.map((json) => AlgeriaCityData.fromJson(json)).toList();
        states = allCities.map((city) => city.wilayaNameAscii).toSet().toList()..sort();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error loading cities data: $e';
      });
    }
  }

  void updateMunicipalities(String state) {
    setState(() {
      selectedState = state;
      selectedMunicipality = null;
      municipalities = allCities
          .where((city) => city.wilayaNameAscii == state)
          .map((city) => city.communeNameAscii)
          .toSet()
          .toList()
        ..sort();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Consumer<PatientProvider>(
                  builder: (context, patientProvider, _) {
                    final patient = patientProvider.patient;
                    print('Patient: $patient');
                    if (patient == null) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return CardImageAndProFile(patient: patient);
                  },
                ),
                const SizedBox(height: AppSize.s16),
                if (isLoading)
                  const Center(child: CircularProgressIndicator())
                else if (errorMessage.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      errorMessage,
                      style: getRegularStyle(
                        fontSize: FontSize.s14,
                        color: Colors.red,
                      ),
                    ),
                  )
                else
                  Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: selectedState,
                        decoration: InputDecoration(
                          hintText: S.of(context).searchCity,
                          hintStyle: getRegularStyle(
                            fontSize: FontSize.s16,
                            color: AppColors.textSecondaryColor,
                          ),
                        ),
                        items: states.map((String state) {
                          return DropdownMenuItem<String>(
                            value: state,
                            child: Text(state),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          if (value != null) {
                            updateMunicipalities(value);
                          }
                        },
                      ),
                      const SizedBox(height: AppSize.s16),
                      DropdownButtonFormField<String>(
                        value: selectedMunicipality,
                        decoration: InputDecoration(
                          hintText: S.of(context).searchDoctor,
                          hintStyle: getRegularStyle(
                            fontSize: FontSize.s16,
                            color: AppColors.textSecondaryColor,
                          ),
                        ),
                        items: municipalities.map((String municipality) {
                          return DropdownMenuItem<String>(
                            value: municipality,
                            child: Text(municipality),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            selectedMunicipality = value;
                          });
                        },
                      ),
                    ],
                  ),
                const SizedBox(height: AppSize.s16),
                ElevatedButton(
                  onPressed: (selectedState != null && selectedMunicipality != null)
                      ? () => Navigator.pushNamed(context, '/search-doctor')
                      : null,
                  child: Text(S.of(context).searchDoctor),
                ),
                const SizedBox(height: AppSize.s16),
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: PageView(
                    controller: _pageController,
                    children: const [
                      CardIntrodaction(),
                      CardIntrodaction(),
                      CardIntrodaction(),
                    ],
                  ),
                ),
                const SizedBox(height: AppSize.s10),
                Center(
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                    effect: const WormEffect(
                      activeDotColor: AppColors.primaryColor,
                      dotHeight: 10,
                      dotWidth: 10,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).categories,
                      style: getSemiBoldStyle(
                        fontSize: FontSize.s16,
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                    Text(
                      S.of(context).seeAll,
                      style: getRegularStyle(
                        fontSize: FontSize.s12,
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
