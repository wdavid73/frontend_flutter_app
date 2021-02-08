import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';

class ButtonTap extends StatefulWidget {
  final String text;
  final IconData icon;
  final GestureTapCallback onPressed;
  final Color iconColor;
  final bool textBold, withShadow;

  ButtonTap(
      {Key key,
      @required this.text,
      @required this.icon,
      @required this.onPressed,
      this.iconColor,
      this.textBold = false,
      this.withShadow = false})
      : assert(text != null),
        assert(icon != null),
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
        width: responsive.width * 0.7,
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
            fillColor: MyColors.accentColor,
            splashColor: MyColors.defaultPrimaryColor,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    widget.icon,
                    color: widget.iconColor != null
                        ? widget.iconColor
                        : Colors.white,
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                  Text(
                    '${widget.text}',
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: responsive.dp(2),
                      fontWeight: widget.textBold ? FontWeight.bold : null,
                    ),
                  )
                ],
              ),
            ),
            onPressed: widget.onPressed,
            shape: const StadiumBorder()),
      ),
    );
  }
}
