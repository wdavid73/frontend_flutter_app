import 'package:flutter/material.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/forms/sing_up_form.dart';
import 'package:my_restaurant_app/widgets/icon_container.dart';
import 'package:my_restaurant_app/widgets/screen/screen_session.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return ScreenSession(
      title: "Sign Up",
      heightBack: responsive.hp(70),
      heightFront: responsive.hp(65),
      iconContainer: IconContainer(
        iconUrl: "user.svg",
        size: responsive.dp(15),
        shadow: false,
      ),
      child: const SignUpForm(),
    );
  }
}
