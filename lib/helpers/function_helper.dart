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
}
