import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/constants.dart';
import 'package:toastification/toastification.dart';

abstract class NotificationHelper {
  static void showToast({
    required BuildContext context,
    required String title,
    bool isError = true,
  }) {
    toastification.show(
      context: context,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 5),
      type: isError ? ToastificationType.error : ToastificationType.success,
      backgroundColor: Colors.white,
      alignment: Alignment.bottomRight,
      closeButtonShowType: CloseButtonShowType.always,
      title: Text(
        title,
        style: AppStyles.kTextLabelStyle3.copyWith(
          color: Colors.black,
        ),
      ),
    );
  }
}
