import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';

class ContentDialogMessage extends StatelessWidget {
  final String code;
  final String content;

  ContentDialogMessage({Key key, this.code, @required this.content})
      : assert(content.trim().length != 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "Restaurant Code",
            style: TextStyle(
              fontSize: responsive.dp(2.3),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              content + code.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: responsive.dp(2),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FlatButton(
              onPressed: () {
                Clipboard.setData(
                  new ClipboardData(text: code),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Code Copied!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: responsive.dp(2),
                      ),
                    ),
                    backgroundColor: MyColors.darkPrimaryColor,
                    duration: Duration(seconds: 3),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                Navigator.of(context).pop();
              },
              child: Text(
                "Copy to Clipboard",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: responsive.dp(1.6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
