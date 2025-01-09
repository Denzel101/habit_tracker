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
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }
}
