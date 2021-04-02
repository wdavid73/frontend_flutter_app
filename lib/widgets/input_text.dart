import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/string_extension.dart';

class InputText extends StatelessWidget {
  final String label, hintText;
  final TextInputType type;
  final bool obscureText,
      borderEnabled,
      formEnabled,
      isPasswordField,
      withPrefix;
  final double fontSize;
  final double width;
  final void Function(String text) onChanged;
  final String Function(String text) validator;
  final void Function() showPassword;

  const InputText({
    Key key,
    this.label = '',
    this.type = TextInputType.text,
    this.obscureText = false,
    this.borderEnabled = true,
    this.formEnabled = false,
    this.isPasswordField = false,
    this.withPrefix = false,
    this.fontSize = 15,
    this.onChanged,
    this.validator,
    this.hintText,
    @required this.width,
    this.showPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
      child: Container(
        width: this.width,
        child: TextFormField(
          textAlign: TextAlign.center,
          maxLines: 1,
          enabled: this.formEnabled,
          keyboardType: this.type,
          obscureText: !this.obscureText,
          style: TextStyle(
            fontSize: this.fontSize,
            color: MyColors.primaryTextColor,
          ),
          onChanged: this.onChanged,
          validator: this.validator,
          decoration: InputDecoration(
            prefixIcon: this.withPrefix ? Icon(Icons.attach_money) : null,
            prefixIconConstraints: this.withPrefix
                ? BoxConstraints(minWidth: 0, minHeight: 0)
                : null,
            suffixIcon: this.isPasswordField
                ? IconButton(
                    icon: Icon(
                      !this.obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: this.showPassword,
                  )
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: MyColors.dividerColor,
              ),
            ),
            filled: true,
            fillColor: Colors.white54,
            focusColor: Colors.white70,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: MyColors.dividerColor,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: MyColors.dividerColor,
              ),
            ),
            labelText: this.label.capitalizeEachWord(),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            labelStyle: TextStyle(
              color: Colors.black45,
//fontWeight: FontWeight.w500,
              fontSize: this.fontSize,
            ),
            hintText: this.hintText,
          ),
        ),
      ),
    );
  }
}
