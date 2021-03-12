import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';

TextStyle textStyle(BuildContext context, bool bold, Color color) {
  final Responsive responsive = Responsive(context);
  return TextStyle(
    color: color,
    fontSize: responsive.dp(2.2),
    fontWeight: bold ? FontWeight.bold : null,
  );
}

TextStyle textStyleSecondary(BuildContext context) {
  final Responsive responsive = Responsive(context);
  return TextStyle(
    color: Colors.white.withOpacity(0.6),
    fontSize: responsive.dp(2),
  );
}
