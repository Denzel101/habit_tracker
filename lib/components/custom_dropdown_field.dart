import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/constants.dart';

class CustomDropDownField<T> extends StatelessWidget {
  const CustomDropDownField({
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    super.key,
    this.suffixIcon,
    this.label,
    this.onTap,
    this.contentPadding = EdgeInsets.zero,
    this.enabledBorder,
    this.focusedBorder,
    this.enabled = true,
    this.validator,
  });
  final String hint;
  final String? label;
  final T? value;
  final List<DropdownMenuItem<T?>> items;
  final ValueChanged<T?> onChanged;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final EdgeInsetsGeometry? contentPadding;
  final bool? enabled;
  final FormFieldValidator<T>? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: DropdownButtonFormField<T?>(
        onTap: onTap,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.greyColor,
          enabled: enabled!,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          prefixIcon: suffixIcon,
          contentPadding: contentPadding,
          labelText: label,
          labelStyle: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          hintStyle: AppStyles.kTextLabelStyle2.copyWith(
            fontWeight: FontWeight.w400,
            color: AppColors.textGrey,
          ),
          errorStyle:
              AppStyles.kTextLabelStyle2.copyWith(color: Colors.redAccent),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.activeColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.redAccent,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.activeColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        hint: Text(
          hint,
          style: AppStyles.kTextLabelStyle2.copyWith(
            fontWeight: FontWeight.w400,
            color: AppColors.textGrey,
          ),
        ),
        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Colors.black,
          size: 20,
        ),
        iconSize: 30,
        items: items,
        value: value,
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
