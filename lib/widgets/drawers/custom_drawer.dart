import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';

class CustomDrawer extends StatefulWidget {
  final Widget content;
  final Widget menuDrawer;

  const CustomDrawer({
    Key? key,
    required this.content,
    required this.menuDrawer,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  double value = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.redAccent,
                MyColors.defaultPrimaryColor,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        SafeArea(
          child: Container(
            width: 200,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: widget.menuDrawer,
          ),
        ),
        TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: value),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
          builder: (_, double val, __) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..setEntry(0, 3, 200 * val)
                ..rotateY((pi / 6) * val),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: value == 1
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          )
                        : null,
                  ),
                  child: Center(
                    child: AbsorbPointer(
                      absorbing: value == 1,
                      child: widget.content,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        GestureDetector(
          onHorizontalDragUpdate: (e) {
            if (e.delta.dx > 0) {
              setState(() {
                value = 1;
              });
            } else {
              setState(() {
                value = 0;
              });
            }
          },
        ),
      ],
    );
  }
}
