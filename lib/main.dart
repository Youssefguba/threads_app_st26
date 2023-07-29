import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:threads_app_st26/screens/intro_screen.dart';
import 'package:threads_app_st26/utils/ui/themes.dart';

import 'firebase_options.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const IntroScreen(),
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
