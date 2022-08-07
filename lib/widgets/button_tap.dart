import 'package:flutter/material.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/responsive.dart';

class ButtonTap extends StatelessWidget {
  final String text;
  final IconData? icon;
  final GestureTapCallback? onPressed;
  final Color? iconColor, fillColor, textColor;
  final bool textBold, withShadow, isLoading;
  final double width;
  final double? height;

  const ButtonTap({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.width,
    this.height,
    this.icon,
    this.iconColor,
    this.textBold = false,
    this.withShadow = false,
    this.fillColor,
    this.textColor = Colors.white,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Container(
      width: width,
      height: height,
      decoration: withShadow
          ? const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(25.0),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(3.0, 3.0),
                  blurRadius: 5.0,
                  spreadRadius: 2.0,
                  color: Colors.black12,
                )
              ],
            )
          : null,
      child: RawMaterialButton(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
          child: !isLoading
              ? Stack(
                  alignment: Alignment.centerRight,
                  children: <Widget>[
                    Row(
                      //mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        icon != null
                            ? Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  icon,
                                  color: iconColor ?? Colors.white,
                                  size: responsive.dp(2.8),
                                ),
                              )
                            : Container(),
                        Text(
                          text,
                          maxLines: 1,
                          style: TextStyle(
                            color: textColor,
                            fontSize: responsive.dp(2),
                            fontWeight: textBold ? FontWeight.bold : null,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Container(
                  width: 24,
                  height: 24,
                  padding: const EdgeInsets.all(2.0),
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                ),
        ),
        fillColor: fillColor ?? MyColors.accentColor,
        splashColor: MyColors.defaultPrimaryColor,
        onPressed: onPressed,
        shape: const StadiumBorder(),
      ),
    );
  }
}
