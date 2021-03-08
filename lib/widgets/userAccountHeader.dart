import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';

class UserAccountHeader extends StatelessWidget {
  final String name, username, email;

  UserAccountHeader({
    Key key,
    @required this.name,
    this.username,
    @required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: responsive.dp(3.5),
            backgroundImage: NetworkImage(
                "https://cdn4.iconfinder.com/data/icons/small-n-flat/24/user-alt-512.png"),
            backgroundColor: MyColors.dividerColor,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              this.name,
              maxLines: 1,
              style: TextStyle(
                fontSize: responsive.dp(1.6),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            this.email,
            textAlign: TextAlign.start,
            maxLines: 1,
            style: TextStyle(
              fontSize: responsive.dp(1.6),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
