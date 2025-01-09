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
