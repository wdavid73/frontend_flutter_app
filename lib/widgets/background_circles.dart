import 'package:flutter/material.dart';
import 'package:my_restaurant_app/utils/responsive.dart';

import 'dialogs/dialog_container.dart';

class BackgroundCircles extends StatelessWidget {
  final Widget child;
  final Responsive responsive;
  const BackgroundCircles(
      {Key? key, required this.child, required this.responsive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double pinkSize = responsive.wp(85);
    final double orangeSize = responsive.wp(55);

    return Stack(
      clipBehavior: Clip.antiAlias,
      children: [
        Positioned(
          top: -pinkSize * 0.2,
          right: -pinkSize * 0.2,
          child: Circle(
            size: pinkSize,
            colors: const [
              Colors.pink,
              Colors.pinkAccent,
            ],
          ),
        ),
        Positioned(
          top: -orangeSize * 0.55,
          left: -orangeSize * 0.15,
          child: Circle(
            size: orangeSize,
            colors: const [
              Colors.deepOrange,
              Colors.deepOrangeAccent,
            ],
          ),
        ),
        child,
      ],
    );
  }
}
