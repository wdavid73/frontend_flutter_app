import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/string_extension.dart';

class CustomDropdownForm extends StatelessWidget {
  final void Function(String value) onChanged;
  final String Function(String text) validator;
  final double width;
  final List<dynamic> options;
  final String hintText;

  const CustomDropdownForm({
    Key key,
    this.onChanged,
    this.width,
    @required this.options,
    @required this.hintText,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //List<String> options = ['gr', 'oz'];
    return Container(
      width: this.width,
      child: DropdownButtonFormField(
        validator: this.validator,
        style: TextStyle(
          color: MyColors.primaryTextColor,
        ),
        hint: Text(
          this.hintText.capitalizeEachWord(),
        ),
        onChanged: this.onChanged,
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
            contentPadding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            )),
        items: options.map<DropdownMenuItem<String>>(
          (dynamic value) {
            return value.runtimeType != String
                ? DropdownMenuItem<String>(
                    value: value.id,
                    child: Text(value.name),
                  )
                : DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
          },
        ).toList(),
      ),
    );
  }
}
