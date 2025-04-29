import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:tabibi_2/app/core/app_theme.dart';
import 'package:tabibi_2/app/providers/appointment_provider.dart';
import 'package:tabibi_2/data/data_source/remote_data_source.dart';
import 'package:tabibi_2/data/network/app_api.dart';
import 'package:tabibi_2/generated/l10n.dart';
import 'package:tabibi_2/secrren/appointment.dart';
import 'package:tabibi_2/secrren/auth/singup.dart';
import 'package:tabibi_2/secrren/dar/detailes.dart';
import 'package:tabibi_2/secrren/dar/payment%20.dart';
import 'package:tabibi_2/secrren/dar/select_date_and_time.dart';
import 'package:tabibi_2/secrren/doctor_profile.dart';
import 'package:tabibi_2/secrren/home.dart';
import 'package:tabibi_2/secrren/all_doctors.dart';
import 'package:tabibi_2/secrren/pro_ne/notification.dart';
import 'package:tabibi_2/secrren/pro_ne/profile.dart';
import 'package:tabibi_2/secrren/telegram_and_whatsapp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize Dio with base URL
    final dio = Dio()..options = BaseOptions(
      baseUrl: "http://localhost:5245",
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
      contentType: 'application/json',
    );

    // Initialize API and data source
    final appApi = AppApi(dio);
    final remoteDataSource = RemoteDataSourceImpl(appApi);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppointmentProvider(remoteDataSource),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: const Locale('en'),
        title: 'Tabibi 2',
        theme: getApplicationTheme(),
        home: const AllDoctors(),
        routes: {
          '/signUp': (context) => const SignUpScreen(),
          '/home': (context) => const HomeScreen(),
          '/select-date': (context) =>  SelectDateAndTime(),
          '/doctor-profile': (context) => const DoctorProfile(),
          '/notification': (context) => const NotificationScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/appointment': (context) => const AppointmentScreen(),
          '/telegram-and-whatsapp': (context) => const TelegramAndWhatsapp(),
          '/all-doctors': (context) => const AllDoctors(),
          '/home-screen': (context) => const HomeScreen(),
          '/doctor-profile': (context) => const DoctorProfile(),
          '/select-date-and-time': 
          (context) =>  SelectDateAndTime(),
          "/detailes": (context) => const Detailes(),
          
          },
      ),
    );
  }
}
