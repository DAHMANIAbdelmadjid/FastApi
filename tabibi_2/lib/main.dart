import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabibi_2/app/providers/auth_provider.dart';
import 'package:tabibi_2/app/providers/patient_provider.dart';
import 'package:tabibi_2/data/network/auth_interceptor.dart';
import 'package:tabibi_2/app/core/app_theme.dart';
import 'package:tabibi_2/app/providers/appointment_provider.dart';
import 'package:tabibi_2/data/data_source/remote_data_source.dart';
import 'package:tabibi_2/data/network/app_api.dart';
import 'package:tabibi_2/data/repository/repository_impl.dart';
import 'package:tabibi_2/generated/l10n.dart';
import 'package:tabibi_2/secrren/combined_appointment.dart';
import 'package:tabibi_2/secrren/auth/login.dart';
import 'package:tabibi_2/secrren/auth/patient_registration.dart';
import 'package:tabibi_2/secrren/auth/singup.dart';
import 'package:tabibi_2/secrren/dar/payment%20.dart';
import 'package:tabibi_2/secrren/home.dart';
import 'package:tabibi_2/secrren/all_doctors.dart';
import 'package:tabibi_2/secrren/pro_ne/notification.dart';
import 'package:tabibi_2/secrren/pro_ne/profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  
  const MyApp({super.key, required this.prefs});
  
  get args => null;

  @override
  Widget build(BuildContext context) {
    // Initialize secure storage
    final storage = const FlutterSecureStorage();

    // Initialize Dio with base URL and auth interceptor
    final dio = Dio()
      ..options = BaseOptions(
        baseUrl: "http://localhost:5245",
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
        contentType: 'application/json',
      )
      ..interceptors.add(AuthInterceptor(storage));

    // Initialize API and data source
    final appApi = AppApi(dio);
    final remoteDataSource = RemoteDataSourceImpl(appApi);
    final repository = RepositoryImpl(remoteDataSource);

    // Initialize providers
    final authProvider = AuthProvider(remoteDataSource, prefs);

    // Initialize auth state
    authProvider.init();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => authProvider,
        ),
        ChangeNotifierProvider(
          create: (_) => AppointmentProvider(remoteDataSource),
        ),
        ChangeNotifierProvider(
          create: (_) => PatientProvider(repository),
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
        home: Consumer<AuthProvider>(
          builder: (context, auth, _) {
            if (auth.loading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            return auth.isAuthenticated ? const HomeScreen() : const AllDoctors();
          },
        ),
        routes: {
          '/signUp': (context) => const SignUpScreen(),
          '/patient-registration': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
            return PatientRegistrationScreen(
              userId: args['userId']!,
              email: args['email']!,
              fullName: args['fullName']!,
            );
          },
          '/home': (context) => const HomeScreen(),
          // '/doctor-profile': (context) {
          //   final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>?;
          //   return DoctorProfile(doctorId: args?['doctorId'] ?? 'test-doctor-id');
          // },
          '/notification': (context) => const NotificationScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/appointment': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>?;
            return CombinedAppointmentScreen(doctorId: args?['doctorId'] ?? 'test-doctor-id');
          },
          '/all-doctors': (context) => const AllDoctors(),
          "/payment": (context) => const Payment(),
          
        },
      ),
    );
  }
}
