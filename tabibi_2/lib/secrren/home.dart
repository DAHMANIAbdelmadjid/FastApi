import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tabibi_2/app/core/app_colors.dart';
import 'package:tabibi_2/secrren/doctor_profile.dart';
import 'package:tabibi_2/secrren/jone.dart';
import 'package:tabibi_2/secrren/sarch_doctor.dart';
import 'package:tabibi_2/secrren/telegram_and_whatsapp.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final List<Widget> _screens = [
    const JoneScreen(),
    const SearchDoctor(),
    const TelegramAndWhatsapp(),
    const DoctorProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBar(
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.access_time),
              label: 'Time',
            ),
            NavigationDestination(
              icon: Icon(Icons.message_outlined),
              label: 'Message',
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
        body: _screens[selectedIndex]);
  }
}
