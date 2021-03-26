import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/utils/styles.dart';

class CardItem extends StatelessWidget {
  final String text, title;
  final Responsive responsive;
  final Color color;

  const CardItem({
    Key key,
    @required this.text,
    @required this.responsive,
    @required this.color,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: responsive.width * 0.95,
      height: responsive.height * 0.12,
      child: Card(
        color: this.color,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: new InkWell(
          onLongPress: () {
            Clipboard.setData(
              new ClipboardData(text: text),
            );
            Fluttertoast.showToast(
              msg: "${this.title} Copied!",
              fontSize: responsive.dp(2),
              backgroundColor: MyColors.darkPrimaryColor,
              toastLength: Toast.LENGTH_LONG,
            );
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      this.title,
                      style: textStyle(context, true, Colors.white),
                    ),
                    subtitle: Text(
                      this.text,
                      style: textStyleSecondary(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
