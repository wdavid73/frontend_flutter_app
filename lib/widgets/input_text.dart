import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/string_extension.dart';

class InputText extends StatelessWidget {
  final String label, hintText;
  final TextInputType type;
  final bool obscureText, borderEnabled;
  final double fontSize;
  final void Function(String text) onChanged;
  final String Function(String text) validator;

  const InputText({
    Key key,
    this.label = '',
    this.type = TextInputType.text,
    this.obscureText = false,
    this.borderEnabled = true,
    this.fontSize = 15,
    this.onChanged,
    this.validator,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, left: 20, right: 20, top: 15),
      child: TextFormField(
        keyboardType: this.type,
        obscureText: this.obscureText,
        style: TextStyle(
          fontSize: this.fontSize,
          color: MyColors.primaryTextColor,
        ),
        onChanged: this.onChanged,
        validator: this.validator,
        decoration: InputDecoration(
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
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          labelStyle: TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.w500,
            fontSize: this.fontSize,
          ),
          hintText: this.hintText,
        ),
      ),
    );
  }
}
