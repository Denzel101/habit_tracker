import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/constants.dart';

class BlockButtonWidget extends StatelessWidget {
  const BlockButtonWidget({
    required this.child,
    this.onPressed,
    this.color,
    super.key,
    this.borderColor = Colors.transparent,
  });

  final Color? color;

  final Color? borderColor;
  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      color: color ?? (context.isDarkMode ? Colors.white : Colors.black),
      height: 49,
      disabledElevation: 0,
      disabledColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: borderColor!),
      ),
      elevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      hoverElevation: 0,
      child: child,
    );
  }
}
