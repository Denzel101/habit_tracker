import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habit_tracker/constants/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.textEditingController,
    required this.keyBoard,
    required this.validator,
    super.key,
    this.label,
    this.obscure = false,
    this.focusNode,
    this.textCapitalization,
    this.onSaved,
    this.suffixIcon,
    this.textInputAction,
    this.readOnly = false,
    this.autofocus = false,
    this.onTap,
    this.onChanged,
    this.prefixIcon,
    this.hintText,
    this.inputFormatters,
    this.labelStyle,
    this.autovalidateMode,
    this.isEnabled,
    this.initialValue,
    this.prefixText,
  });
  final String? label;
  final bool obscure;
  final TextInputType keyBoard;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final TextEditingController textEditingController;
  final TextCapitalization? textCapitalization;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? labelStyle;
  final bool autofocus;
  final AutovalidateMode? autovalidateMode;
  final bool? isEnabled;
  final String? initialValue;
  final String? prefixText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextFormField(
        style: const TextStyle(
          height: 1,
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        readOnly: readOnly,
        enabled: isEnabled,
        onTap: onTap,
        autofocus: autofocus,
        focusNode: focusNode,
        inputFormatters: inputFormatters,
        controller: textEditingController,
        obscureText: obscure,
        obscuringCharacter: '*',
        textInputAction: textInputAction,
        keyboardType: keyBoard,
        cursorColor: Colors.grey,
        initialValue: initialValue,
        autovalidateMode: autovalidateMode,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.greyColor,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: label,
          prefixText: prefixText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          prefixStyle: const TextStyle(
            height: 1,
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
          prefixIconColor: AppColors.textGrey,
          suffixIconColor: AppColors.textGrey,
          hintText: hintText,
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
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.activeColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
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
        validator: validator,
        onSaved: onSaved,
        onChanged: onChanged,
      ),
    );
  }
}
