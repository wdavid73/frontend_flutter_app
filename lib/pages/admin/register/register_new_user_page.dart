import 'package:flutter/material.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/forms/sing_up_form.dart';
import 'package:my_restaurant_app/widgets/icon_container.dart';
import 'package:my_restaurant_app/widgets/screen/screen_session.dart';

class RegisterNewUserPage extends StatelessWidget {
  final String position;
  const RegisterNewUserPage({Key? key, required this.position})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return ScreenSession(
      title: "Register new user",
      heightBack: responsive.hp(70),
      heightFront: responsive.hp(65),
      iconContainer: IconContainer(
        shadow: false,
        size: responsive.dp(15),
        iconUrl: 'user.svg',
      ),
      child: SignUpForm(position: position),
    );
  }
}
