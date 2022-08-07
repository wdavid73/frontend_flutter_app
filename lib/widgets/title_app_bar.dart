import 'package:flutter/material.dart';
import 'package:my_restaurant_app/utils/responsive.dart';

class TitleAppBar extends StatelessWidget {
  final String text;
  const TitleAppBar({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: responsive.dp(2),
      ),
    );
  }
}
