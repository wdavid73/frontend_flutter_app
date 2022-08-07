import 'package:flutter/material.dart';
import 'package:my_restaurant_app/class/position.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/responsive.dart';

class DropdownPosition extends StatelessWidget {
  final Responsive responsive;
  final bool enabled;
  final Future<List<Position>> getPositions;
  final void Function(int? text) onChanged;
  final String? Function(int? value)? validator;

  const DropdownPosition({
    Key? key,
    required this.getPositions,
    required this.onChanged,
    required this.responsive,
    required this.validator,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPositions,
      builder: (context, AsyncSnapshot<List<Position>> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator(
            color: MyColors.accentColor,
          );
        }
        if (snapshot.hasError) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
              ),
              Text(
                "Error obtaining the list of positions",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: responsive.dp(2),
                ),
              ),
            ],
          );
        }
        return SizedBox(
          width: responsive.wp(95),
          child: DropdownButtonFormField(
            hint: Text(
              "Select Position",
              style: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.bold,
                  fontSize: responsive.dp(1.6)),
            ),
            validator: validator,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(
                  color: MyColors.dividerColor,
                ),
              ),
              filled: true,
              fillColor: Colors.white54,
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
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            ),
            style: TextStyle(
              color: Colors.black45,
              fontSize: responsive.dp(2),
            ),
            items: snapshot.data!
                .map(
                  (position) => DropdownMenuItem<int>(
                    child: Text(position.name),
                    value: position.id,
                  ),
                )
                .toList(),
            onChanged: enabled ? onChanged : null,
          ),
        );
      },
    );
  }
}
