import 'package:flutter/material.dart';
import 'package:threads_app_st26/utils/ui/fonts.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: FontsHelper.sfPro,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.white,
    background: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: Colors.black,
      fontFamily: FontsHelper.sfPro,
    ),
    bodyMedium: TextStyle(
      color: Colors.black,
      fontFamily: FontsHelper.sfPro,
    ),
    bodySmall: TextStyle(
      color: Colors.black,
      fontFamily: FontsHelper.sfPro,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  fontFamily: FontsHelper.sfPro,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.black,
    background: Colors.black,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: Colors.white,
      fontFamily: FontsHelper.sfPro,
    ),
    bodyMedium: TextStyle(
      color: Colors.white,
      fontFamily: FontsHelper.sfPro,
    ),
    bodySmall: TextStyle(
      color: Colors.white,
      fontFamily: FontsHelper.sfPro,
    ),
  ),
);
