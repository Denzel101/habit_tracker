import 'package:flutter/material.dart';
import 'package:habit_tracker/home/home.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  String stripBrackets() {
    final regex = RegExp(r'\[.*?\]\s*');
    return replaceAll(regex, '').trim();
  }
}

extension DateTimeFormatting on DateTime {
  String toCurrMonthDay() {
    return DateFormat('EEEE, d').format(this);
  }

  String toShortDay() {
    return DateFormat('EEE').format(this);
  }

  String toNumDay() {
    return DateFormat('dd').format(this);
  }

  String toFullDay() {
    return DateFormat('EEEE').format(this);
  }
}

extension HabitFiltering on List<CreateHabitModel> {
  List<CreateHabitModel> filterHabits(DateTime selectedDay) {
    return where((habit) {
      if (habit.frequency == 'Daily') {
        return habit.startDate.isBefore(selectedDay) ||
            habit.startDate.isAtSameMomentAs(selectedDay);
      } else if (habit.frequency == 'Weekly') {
        final daysDifference = selectedDay.difference(habit.startDate).inDays;
        return daysDifference >= 0 && daysDifference % 7 == 0;
      }
      return false;
    }).toList();
  }
}

extension DarkMode on BuildContext {
  bool get isDarkMode {
    final brightness = Theme.of(this).brightness;
    return brightness == Brightness.dark;
  }
}
