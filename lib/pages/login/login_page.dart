import 'package:flutter/material.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/forms/login_form.dart';
import 'package:my_restaurant_app/widgets/icon_container.dart';
import 'package:my_restaurant_app/widgets/screen/screen_session.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return ScreenSession(
      title: "Log in",
      heightBack: responsive.hp(70),
      heightFront: responsive.hp(40),
      iconContainer: IconContainer(
        iconUrl: "assets/icon.svg",
        size: responsive.dp(22),
        shadow: false,
        fullPath: true,
      ),
      child: const LoginForm(),
    );
  }
}
