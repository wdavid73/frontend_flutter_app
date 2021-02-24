import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/class/Positions.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/utils/string_extension.dart';

class SelectPosition extends StatelessWidget {
  final List<Position> position;
  final void Function(int value) onChanged;
  final String Function(int value) validator;

  const SelectPosition({
    Key key,
    this.position,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        width: responsive.width * 0.85,
        child: DropdownButtonFormField(
          hint: Text(
            "select a position".capitalizeEachWord(),
          ),
          isExpanded: true,
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
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
          style: TextStyle(
            color: Colors.black45,
            fontSize: responsive.dp(2),
          ),
          itemHeight: responsive.height * 0.08,
          items: this.position.map((item) {
            return DropdownMenuItem(
              value: item.id,
              child: Text(
                item.name.toUpperCase(),
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: MyColors.primaryTextColor,
                  fontSize: responsive.dp(2),
                ),
              ),
            );
          }).toList(),
          onChanged: this.onChanged,
          validator: this.validator,
        ),
      ),
    );
  }
}
