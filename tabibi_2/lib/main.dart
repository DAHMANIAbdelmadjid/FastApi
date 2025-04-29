import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tabibi_2/app/core/app_theme.dart';
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
    return MaterialApp(
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
        // '/login': (context) => const LoginScreen(),
        '/signUp': (context) => const SignUpScreen(),
        '/home': (context) =>
            const TelegramAndWhatsapp(), // Using Detailes as home for now
      },
    );
  }
}
