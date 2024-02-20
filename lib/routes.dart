import 'package:diseases/presentations/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:diseases/presentations/views/auth/login_screen.dart';
import 'package:diseases/presentations/views/auth/otp.dart';
import 'package:diseases/presentations/views/auth/sign_up_screen.dart';
import 'package:diseases/presentations/views/home_screen.dart';
import 'package:diseases/presentations/views/landing_screen.dart';
import 'package:diseases/presentations/views/settings_screen.dart';
import 'package:diseases/presentations/views/suggestion_screen.dart';

typedef RouteBuilder = Widget Function(BuildContext context);

const String landingScreen = 'landingScreen';
const String homeScreen = 'homeScreen';
const String suggestionsScreen = 'suggestionsScreen';
const String settingsScreen = 'settingsScreen';
const String loginScreen = 'loginScreen';
const String registerScreen = 'registerScreen';
const String otpScreen = 'otpScreen';
const String profileScreen = 'profileScreen';

Route<dynamic> onGeneratedRoute(RouteSettings settings) {
  final Map<String, RouteBuilder> routes = {
    landingScreen: (context) => const LandingScreen(),
    homeScreen: (context) => HomeScreen(),
    otpScreen: (context) {
      final arguments = settings.arguments as Map<String, dynamic>? ?? {};
      return Otp(email: arguments['email'], password: arguments['password']);
    },
    suggestionsScreen: (context) => const SuggestionsScreen(),
    settingsScreen: (context) => const SettingsScreen(),
    loginScreen: (context) => LoginScreen(),
    registerScreen: (context) => SignUpScreen(),
    profileScreen: (context) => const ProfilePage(),
  };

  final RouteBuilder? builder = routes[settings.name];
  if (builder != null) {
    return MaterialPageRoute(builder: builder);
  } else {
    throw ('This route name does not exist yet');
  }
}
