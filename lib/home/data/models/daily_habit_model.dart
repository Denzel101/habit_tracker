import 'package:flutter/material.dart';

class DailyHabitModel {
  DailyHabitModel({
    required this.image,
    required this.habit,
    required this.goal,
    required this.color,
  });

  final String image;
  final String habit;
  final String goal;
  final Color color;
}
