import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_restaurant_app/utils/responsive.dart';

class AdminMenuItem extends StatelessWidget {
  final String iconUrl, text;
  final Color? textColor;
  final double sizeIcon;

  const AdminMenuItem({
    Key? key,
    required this.iconUrl,
    required this.text,
    this.textColor,
    required this.sizeIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Center(
          child: SvgPicture.asset(
            iconUrl,
            width: sizeIcon * 0.8,
            height: sizeIcon * 0.8,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            text,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: TextStyle(
              color: textColor,
              fontSize: responsive.dp(1.6),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
