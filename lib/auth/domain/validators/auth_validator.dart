class AuthValidator {
  String? validateEmail(String? value) {
    const pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    final regExp = RegExp(pattern);

    if (value!.trim().isEmpty) {
      return 'Add Email Address';
    } else if (!regExp.hasMatch(value)) {
      return 'Invalid Email Address';
    }
    return null;
  }
}
