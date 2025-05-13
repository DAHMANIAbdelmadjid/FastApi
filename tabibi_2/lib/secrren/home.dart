import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabibi_2/app/providers/auth_provider.dart';
import 'package:tabibi_2/app/providers/patient_provider.dart';
import 'package:tabibi_2/secrren/jone.dart';
import 'package:tabibi_2/secrren/pro_ne/notification.dart';
import 'package:tabibi_2/secrren/pro_ne/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  
  final List<Widget> _screens = [
    const JoneScreen(),
    // const SearchDoctor(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];
  
  @override
  void initState() {
    super.initState();
    // Initialize auth state after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final patientProvider = Provider.of<PatientProvider>(context, listen: false);
      authProvider.init(patientProvider);
    });
    _loadPatientData();
  }
  
  Future<void> _loadPatientData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token != null) {
      // Use Provider.of with listen: false since we're in initState
      Provider.of<PatientProvider>(context, listen: false).fetchPatient(token);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          // NavigationDestination(
          //   icon: Icon(Icons.access_time),
          //   label: 'Time',
          // ),
          NavigationDestination(
            icon: Icon(Icons.notification_add),
            label: 'Notification',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body: _screens[selectedIndex]
    );
  }
}