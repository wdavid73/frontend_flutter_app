import 'package:flutter/material.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';

class InputText extends StatelessWidget {
  final String? label, hintText;
  final bool obscureText,
      formEnabled,
      isPasswordField,
      withPrefix,
      bolderEnabled;
  final double fontSize, width;
  final TextInputType type;
  final TextAlign textAlign;
  final Icon? prefix;
  final void Function(String text) onChange;
  final String Function(String? text) validator;
  final void Function()? showPassword;
  final TextEditingController? controller;

  const InputText({
    Key? key,
    this.label,
    this.hintText,
    this.obscureText = false,
    this.formEnabled = false,
    this.isPasswordField = false,
    this.withPrefix = false,
    this.bolderEnabled = true,
    this.type = TextInputType.text,
    this.textAlign = TextAlign.start,
    this.prefix,
    required this.onChange,
    required this.validator,
    this.showPassword,
    this.controller,
    required this.fontSize,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: SizedBox(
        width: width,
        child: TextFormField(
          textAlign: textAlign,
          maxLines: 1,
          enabled: formEnabled,
          keyboardType: type,
          obscureText: obscureText,
          style: TextStyle(
            fontSize: fontSize,
            color: MyColors.primaryTextColor,
          ),
          onChanged: onChange,
          validator: validator,
          decoration: InputDecoration(
            prefixIcon: withPrefix ? prefix : null,
            prefixIconConstraints: withPrefix
                ? const BoxConstraints(
                    minWidth: 0,
                    minHeight: 0,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
