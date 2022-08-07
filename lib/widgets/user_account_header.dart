import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/responsive.dart';

class UserAccountHeader extends StatelessWidget {
  final String name, username, email;

  const UserAccountHeader({
    Key? key,
    required this.name,
    required this.username,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: responsive.dp(6),
          backgroundColor: MyColors.dividerColor,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: SvgPicture.asset(
                "assets/icons/user_profile.svg",
                semanticsLabel: "User Profile Picture",
                placeholderBuilder: (BuildContext context) => Container(
                  padding: const EdgeInsets.all(30.0),
                  child: const CircularProgressIndicator(
                    color: MyColors.accentColor,
                  ),
                ),
              ),
            ),
          ),
        ),
              Text(
                name.toString(),
                maxLines: 1,
                overflow: TextOverflow.fade,
                softWrap: true,
                style: TextStyle(
                  fontSize: responsive.dp(1.6),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
            ),
            Text(
              email.toString(),
              textAlign: TextAlign.start,
              maxLines: 1,
              style: TextStyle(
                fontSize: responsive.dp(1.6),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
      ],
    );
  }
}
