import 'package:flutter/material.dart';
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
        body: _screens[selectedIndex]);
  }
}
