import 'package:flutter/material.dart';

ButtonStyle buttonStyles(
  Color color, [
  double padding = 5,
  double borderRadius = 20,
  double elevation = 2,
]) {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      color,
    ),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),
    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
      EdgeInsets.all(padding),
    ),
    elevation: MaterialStateProperty.all<double>(elevation),
  );
}
