import 'package:flutter/material.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/icon_container.dart';

class Empty extends StatelessWidget {
  final Responsive responsive;
  final String text;
  const Empty({Key? key, required this.responsive, this.text = 'Empty'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          IconContainer(
            size: responsive.dp(15),
            iconUrl: "information.svg",
            shadow: true,
          ),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: responsive.dp(3),
            ),
          )
        ],
      ),
    );
  }
}
