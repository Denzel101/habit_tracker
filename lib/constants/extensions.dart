extension StringExtension on String {
  String stripBrackets() {
    final regex = RegExp(r'\[.*?\]\s*');
    return replaceAll(regex, '').trim();
  }
}
