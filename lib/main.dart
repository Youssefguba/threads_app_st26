import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_app_st26/screens/intro_screen.dart';
import 'package:threads_app_st26/utils/ui/themes.dart';

import 'cubits/post_cubit/post_cubit.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final GlobalKey<ScaffoldMessengerState> globalMessenger = GlobalKey<ScaffoldMessengerState>();

final navigatorKey =  GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
   const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PostCubit(context)),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: globalMessenger,
        home: const IntroScreen(),
        theme: lightTheme,
        darkTheme: darkTheme,
      ),
    );
  }
}
