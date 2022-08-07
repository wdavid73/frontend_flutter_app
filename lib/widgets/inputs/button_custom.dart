import 'package:flutter/material.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/responsive.dart';

class Button extends StatelessWidget {
  final String text;
  final IconData icon;
  final Responsive responsive;
  final GestureTapCallback? onPressed;
  final bool isLoading, withShadow;
  const Button({
    Key? key,
    required this.text,
    required this.responsive,
    required this.icon,
    required this.onPressed,
    this.isLoading = false,
    this.withShadow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: withShadow
          ? const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(25.0),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 3.0),
                  blurRadius: 5.0,
                  spreadRadius: 2.0,
                  color: Colors.black26,
                )
              ],
            )
          : null,
      child: RawMaterialButton(
        key: key,
        elevation: 1,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        fillColor:
            !isLoading ? MyColors.accentColor : MyColors.accentColorDisable,
        splashColor: MyColors.lightPrimaryColor,
        highlightColor: MyColors.darkPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          width: responsive.wp(40),
          height: responsive.hp(5),
          child: !isLoading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: responsive.dp(3),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        text,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: responsive.dp(2),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Loading...",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: responsive.dp(2),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
        onPressed: !isLoading ? onPressed : null,
      ),
    );
  }
}
