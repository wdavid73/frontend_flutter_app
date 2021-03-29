import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';

class ButtonTap extends StatefulWidget {
  final String text;
  final IconData icon;
  final GestureTapCallback onPressed;
  final Color iconColor, fillColor, textColor;
  final bool textBold, withShadow;
  final double width;

  ButtonTap({
    Key key,
    @required this.text,
    @required this.onPressed,
    @required this.width,
    this.icon,
    this.iconColor,
    this.textBold = false,
    this.withShadow = false,
    this.fillColor,
    this.textColor = Colors.white,
  })  : assert(text != null),
        // assert(icon != null),
        super(key: key);

  @override
  _ButtonTapState createState() => _ButtonTapState();
}

class _ButtonTapState extends State<ButtonTap> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        width: widget.width,
        decoration: widget.withShadow
            ? BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(25.0),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(3.0, 3.0),
                    blurRadius: 5.0,
                    spreadRadius: 2.0,
                    color: Colors.pinkAccent,
                  )
                ],
              )
            : null,
        child: RawMaterialButton(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
            child: Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                Row(
                  //mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${widget.text}',
                      maxLines: 1,
                      style: TextStyle(
                        color: widget.textColor,
                        fontSize: responsive.dp(2),
                        fontWeight: widget.textBold ? FontWeight.bold : null,
                      ),
                    )
                  ],
                ),
                widget.icon != null
                    ? Icon(
                        widget.icon,
                        color: widget.iconColor != null
                            ? widget.iconColor
                            : Colors.white,
                        size: responsive.dp(2.8),
                      )
                    : Container(),
              ],
            ),
          ),
          fillColor: widget.fillColor != null
              ? widget.fillColor
              : MyColors.accentColor,
          splashColor: MyColors.defaultPrimaryColor,
          onPressed: widget.onPressed,
          shape: const StadiumBorder(),
        ),
      ),
    );
  }
}
