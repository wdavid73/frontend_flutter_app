import 'package:flutter/material.dart';
import 'package:my_restaurant_app/class/table.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/responsive.dart';

class CustomDropdown extends StatelessWidget {
  final Responsive responsive;
  final List<dynamic> options;
  final String hintText;
  final String labelText;
  final double? inputWidth;
  final void Function(dynamic value)? onChange;
  final String? Function(dynamic text)? validator;

  const CustomDropdown({
    Key? key,
    required this.options,
    required this.hintText,
    required this.labelText,
    this.validator,
    this.inputWidth,
    required this.responsive,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: inputWidth ?? responsive.wp(39),
      height: responsive.hp(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(
              fontSize: responsive.dp(1.6),
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
            ),
          ),
          DropdownButtonFormField(
            validator: validator,
            style: const TextStyle(
              color: MyColors.primaryTextColor,
            ),
            hint: Text(hintText),
            onChanged: onChange,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: MyColors.dividerColor),
              ),
              filled: true,
              fillColor: Colors.white54,
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
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
            ),
            items: options.map<DropdownMenuItem<dynamic>>((dynamic value) {
              return DropdownMenuItem<dynamic>(
                value: value is String ? value : value.id,
                child: Text(
                  value is TableApp
                      ? value.ref
                      : value is String
                          ? value.toString()
                          : value.name,
                  style: TextStyle(
                    fontSize: responsive.dp(1.8),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
