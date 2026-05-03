import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/crud_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const PerfumeriaApp());
}

class PerfumeriaApp extends StatelessWidget {
  const PerfumeriaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nuestras Fragancias',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF000000),
          primary: const Color(0xFF000000),
          secondary: const Color(0xFFD4AF37),
          surface: const Color(0xFFFFFFFF),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/crud': (context) => const CrudPage(),
      },
    );
  }
}
