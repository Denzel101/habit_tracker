import 'package:intl/intl.dart';

extension StringExtension on String {
  String stripBrackets() {
    final regex = RegExp(r'\[.*?\]\s*');
    return replaceAll(regex, '').trim();
  }
}

extension DateTimeFormatting on DateTime {
  String toCurrentDay() {
    return DateFormat('EEEE, d').format(this);
  }
}
