import 'package:flutter/material.dart';
import 'package:my_restaurant_app/utils/responsive.dart';

class ErrorList extends StatelessWidget {
  final String message;
  final Responsive responsive;
  final Color color;
  final void Function()? refresh;
  const ErrorList({
    Key? key,
    required this.message,
    required this.responsive,
    this.color = Colors.red,
    this.refresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.error_outline,
              color: color,
            ),
            Text(
              message,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: responsive.dp(2),
              ),
            ),
          ],
        ),
        TextButton.icon(
          onPressed: refresh,
          icon: const Icon(
            Icons.refresh,
            color: Colors.white,
          ),
          label: const Text(
            "Tap to reload",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
