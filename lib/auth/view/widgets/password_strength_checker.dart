import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/constants.dart';

/// Widget that will check password strength and display validation messages
class PasswordStrengthChecker extends StatefulWidget {
  const PasswordStrengthChecker({
    required this.password,
    required this.onStrengthChanged,
    super.key,
  });

  /// Password value: obtained from a text field
  final String password;

  /// Callback that will be called when password strength changes
  final void Function({required bool isStrong}) onStrengthChanged;

  @override
  State<PasswordStrengthChecker> createState() =>
      _PasswordStrengthCheckerState();
}

class _PasswordStrengthCheckerState extends State<PasswordStrengthChecker> {
  /// Override didUpdateWidget to re-validate password strength when the value
  /// changes in the parent widget
  @override
  void didUpdateWidget(covariant PasswordStrengthChecker oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// Check if the password value has changed
    if (widget.password != oldWidget.password) {
      /// If changed, re-validate the password strength
      final isStrong = _validators.entries.every(
        (entry) => entry.key.hasMatch(widget.password),
      );

      /// Call callback with new value to notify parent widget
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => widget.onStrengthChanged(isStrong: isStrong),
      );
    }
  }

  /// Map of validators to be used to validate the password.
  ///
  /// Key: RegExp to check if the password contains a certain character type
  /// Value: Validation message to be displayed
  ///
  /// Note: You can add, remove, or change validators as per your requirements
  /// and if you are not good with RegExp, (most of us aren't), you can get help
  /// from Bard or ChatGPT to generate RegExp and validation messages.
  final Map<RegExp, String> _validators = {
    RegExp('[A-Z]'): 'Has at least one uppercase letter',
    RegExp(r'[!@#$%^&*(),.?":{}|<>]'): 'Contains a special character',
    RegExp(r'\d'): 'Contains a number',
    RegExp(r'^.{8,32}$'): 'Has 8 characters minimum',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppStyles.kAppPadding),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.activeColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _validators.entries.map(
          (entry) {
            /// Check if the password matches the current validator requirement
            final hasMatch = entry.key.hasMatch(widget.password);

            return Row(
              children: [
                Text(
                  '• ${entry.value}',
                  style: AppStyles.kTextLabelStyle3.copyWith(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                if (hasMatch)
                  const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 20,
                  ),
              ],
            );
          },
        ).toList(),
      ),
    );
  }
}
