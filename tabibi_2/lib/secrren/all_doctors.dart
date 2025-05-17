import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibi_2/app/core/app_colors.dart';
import 'package:tabibi_2/app/core/style_constants.dart';
import 'package:tabibi_2/app/core/styles.dart';
import 'package:tabibi_2/app/providers/doctor_provider.dart';
import 'package:tabibi_2/generated/l10n.dart';
import 'package:tabibi_2/widgets/doctor_card.dart';

class AllDoctors extends StatefulWidget {
  const AllDoctors({super.key});

  @override
  State<AllDoctors> createState() => _AllDoctorsState();
}

class _AllDoctorsState extends State<AllDoctors> {
  String? _selectedCity;

  final List<String> _cities = [
    'Adrar',
    'Alger',
    'Annaba',
    'Batna',
    'Béjaïa',
    'Constantine',
    'Oran',
    'Sétif',
    // Add more cities as needed
  ];

  @override
  void initState() {
    super.initState();
    // Initialize doctors list when widget is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DoctorProvider>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).doctors,
          style: getBoldStyle(
            fontSize: FontSize.s20,
            color: AppColors.textPrimaryColor,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          children: [
            // Search Field
            TextFormField(
              decoration: InputDecoration(
                hintText: "Search for doctors...",
                hintStyle: getRegularStyle(
                  fontSize: FontSize.s16,
                  color: AppColors.textSecondaryColor,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.primaryColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                    width: 2,
                  ),
                ),
              ),
              onChanged: (value) {
              },
            ),
            const SizedBox(height: AppSize.s16),
            
            // City Dropdown
            DropdownButtonFormField<String>(
              value: _selectedCity,
              decoration: InputDecoration(
                hintText: "Select city",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              items: [
                DropdownMenuItem(
                  value: null,
                  child: Text("All cities"),
                ),
                ..._cities.map((city) => DropdownMenuItem(
                      value: city,
                      child: Text(city),
                    )),
              ],
              onChanged: (String? city) {
                setState(() {
                  _selectedCity = city;
                });
              },
            ),
            const SizedBox(height: AppSize.s16),

            // Doctor List
            Expanded(
              child: Consumer<DoctorProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  }

                  if (provider.error != null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            provider.error!,
                            style: getSemiBoldStyle(
                              fontSize: FontSize.s16,
                              color: AppColors.errorColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppSize.s16),
                          ElevatedButton(
                            onPressed: () {
                              context.read<DoctorProvider>().fetchDoctors();
                            },
                            child: Text("Try again"),
                          ),
                        ],
                      ),
                    );
                  }

                  final doctors = provider.doctors;
                  if (doctors.isEmpty) {
                    return Center(
                      child: Text(
                        "No doctors found",
                        style: getSemiBoldStyle(
                          fontSize: FontSize.s16,
                          color: AppColors.textSecondaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: doctors.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: AppPadding.p8),
                      child: DoctorCard(
                        name: doctors[index].fullName,
                        description: doctors[index].notes,
                        imageUrl: doctors[index].photoUrl ?? "",
                        rating: 0.0, // Default rating since it's not in our API response
                        onFavoritePressed: () {
                          // TODO: Implement favorite functionality
                        },
                        onBookPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/appointment',
                            arguments: {'doctorId': doctors[index].id},
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
