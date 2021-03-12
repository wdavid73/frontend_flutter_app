import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/utils/string_extension.dart';

class AlertDialogCustom extends StatelessWidget {
  final String page;

  const AlertDialogCustom({
    Key key,
    @required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return AlertDialog(
      elevation: 1,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/touch.svg",
            width: responsive.width * 0.05,
            height: responsive.height * 0.05,
          ),
          Text(
            "Message Info",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: responsive.dp(2.5),
            ),
          ),
        ],
      ),
      backgroundColor: MyColors.darkPrimaryColor,
      content: Text(
        "Touch here to go to the list of $page".capitalizeEachWord(),
        style: TextStyle(
          color: Colors.white,
          fontSize: responsive.dp(1.5),
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
