import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';

Future mySnackBar(context, String message) async {
  final Responsive responsive = Responsive(context);
  await Future.delayed(
    Duration(seconds: 1),
  );
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      content: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: Icon(
              Icons.info,
              color: Colors.white,
              size: responsive.dp(3),
            ),
          ),
          Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: responsive.dp(1.6),
            ),
          )
        ],
      ),
      backgroundColor: MyColors.darkPrimaryColor,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
