import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/widgets/button_tap.dart';

class BasicAlertDialog extends StatelessWidget {
  final String title, desc;
  final bool okButton;

  const BasicAlertDialog({
    Key key,
    this.title,
    this.desc,
    this.okButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return AlertDialog(
      backgroundColor: MyColors.darkPrimaryColor,
      contentPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Center(
        child: Text(
          this.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: responsive.dp(3),
            color: Colors.white,
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              this.desc,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonTap(
                  width: responsive.width * 0.3,
                  text: "OK",
                  textBold: false,
                  onPressed: () => print("delete"),
                  iconColor: MyColors.textPrimaryColor,
                  withShadow: false,
                  fillColor: MyColors.defaultPrimaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonTap(
                  width: responsive.width * 0.3,
                  text: "Cancel",
                  textBold: false,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  iconColor: MyColors.textPrimaryColor,
                  withShadow: false,
                  fillColor: MyColors.accentColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
