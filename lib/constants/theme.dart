import 'package:flutter/material.dart';

import './colors.dart';

ThemeData themeData() {
  return ThemeData(
      fontFamily: 'Montserrat',
      primarySwatch: myColor,
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(
          displaySmall: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              fontSize: 35),
          bodyMedium: TextStyle(color: AppColors.primary, fontSize: 20),
          headlineSmall: TextStyle(color: Colors.white)));
}

class AppConstants {
  static EdgeInsets padding =
      const EdgeInsets.symmetric(horizontal: 20, vertical: 7);
}

// ignore: prefer_const_constructors
MaterialColor myColor = MaterialColor(0xFF2D7EF6, const {
  50: Color(0xFFE6EEF6),
  100: Color(0xFFBFD2E9),
  200: Color(0xFF94AED5),
  300: Color(0xFF6888C1),
  400: Color(0xFF4D6FAF),
  500: Color(0xFF33569D),
  600: Color(0xFF2F4E91),
  700: Color(0xFF294486),
  800: Color(0xFF243C7B),
  900: Color(0xFF1B2D68),
});
