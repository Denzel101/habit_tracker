import 'package:flutter/material.dart';

class FunctionHelper {
  static Future<DateTime> selectStartDate(BuildContext context) async {
    var currentDateTime = DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: currentDateTime,
      firstDate: currentDateTime,
      lastDate: DateTime(currentDateTime.year + 2),
    );
    if (picked != null && picked != currentDateTime) {
      currentDateTime = picked;
    }

    return currentDateTime;
  }

  static List<DateTime> getCurrentWeek() {
    final now = DateTime.now();

    final startDate = DateTime(now.year, now.month, now.day);
    final startOfWeek = startDate.subtract(
      Duration(days: startDate.weekday - 1),
    );
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }
}
