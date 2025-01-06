import 'package:flutter/material.dart';
import 'package:habit_tracker/home/home.dart';

class AppRouter {
  static const String homeRoute = 'home-route';
  static const String chooseHabitRoute = 'choose-habit-route';

  static Route<String>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );

      case chooseHabitRoute:
        return MaterialPageRoute(
          builder: (context) => const ChooseHabitScreen(),
        );
    }

    return null;
  }
}
