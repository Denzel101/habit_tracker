import 'package:flutter/material.dart';
import 'package:habit_tracker/auth/auth.dart';
import 'package:habit_tracker/home/home.dart';
import 'package:habit_tracker/landing/landing.dart';

class AppRouter {
  static const String homeRoute = 'home-route';
  static const String chooseHabitRoute = 'choose-habit-route';
  static const String landingRoute = 'landing-route';
  static const String loginRoute = 'login-route';
  static const String registerRoute = 'register-route';
  static const String createHabitRoute = 'create-habit-route';

  static Route<String>? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );

      case chooseHabitRoute:
        return MaterialPageRoute(
          builder: (context) => const ChooseHabitScreen(),
        );

      case landingRoute:
        return MaterialPageRoute(
          builder: (context) => const LandingScreen(),
        );

      case loginRoute:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );

      case registerRoute:
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        );

      case createHabitRoute:
        final chosenHabit = args! as ChooseHabitModel;
        return MaterialPageRoute(
          builder: (context) => CreateHabitScreen(
            chosenHabit: chosenHabit,
          ),
        );
    }

    return null;
  }
}
