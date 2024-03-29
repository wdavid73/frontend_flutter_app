import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/responsive.dart';

class InputCustom extends StatelessWidget {
  final Responsive responsive;
  final double? inputWidth;
  final TextAlign textAlign;
  final TextInputType keyboardType;
  final String labelText;
  final String hintText;
  final String? initialValue;
  final String? prefixText;
  final bool isPassword;
  final bool isPasswordField;
  final bool withPrefixIcon;
  final bool toUpperCase;
  final bool enabled;
  final Icon? prefixIcon;
  final TextEditingController? controller;
  final void Function()? showPassword;
  final void Function(String text) onChange;
  final String? Function(String? text)? validator;

  const InputCustom({
    Key? key,
    required this.responsive,
    required this.labelText,
    required this.hintText,
    required this.onChange,
    this.validator,
    this.prefixIcon,
    this.textAlign = TextAlign.start,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.withPrefixIcon = false,
    this.showPassword,
    this.isPasswordField = false,
    this.controller,
    this.inputWidth,
    this.toUpperCase = false,
    this.enabled = true,
    this.initialValue,
    this.prefixText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: inputWidth ?? responsive.wp(80),
      child: TextFormField(
        initialValue: initialValue,
        textAlign: textAlign,
        maxLines: 1,
        enabled: enabled,
        keyboardType: keyboardType,
        obscureText: isPassword,
        style: TextStyle(
          fontSize: responsive.dp(1.6),
          color: MyColors.primaryTextColor,
        ),
        onChanged: onChange,
        validator: validator,
        decoration: InputDecoration(
          prefixText: prefixText,
          prefixIcon: prefixIcon,
          suffixIcon: isPasswordField
              ? IconButton(
                  onPressed: () => showPassword!(),
                  icon: Icon(
                    isPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: MyColors.accentColor,
                  ),
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: MyColors.dividerColor,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          focusColor: Colors.white70,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: MyColors.dividerColor,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: MyColors.dividerColor,
            ),
          ),
          labelText: labelText,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          labelStyle: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: responsive.dp(1.6),
          ),
          hintText: hintText,
        ),
        controller: controller,
        inputFormatters: toUpperCase ? [UpperCaseTextFormatter()] : [],
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
