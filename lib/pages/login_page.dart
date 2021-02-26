import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/widgets/icon_container.dart';
import 'package:my_restaurant_frontend_app/widgets/log_in_form.dart';
import 'package:my_restaurant_frontend_app/widgets/screen_session.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return ScreenSession(
      title: "Log in",
      heightBack: responsive.height * 0.7,
      heightFront: responsive.height * 0.55,
      iconContainer: IconContainer(
        iconUrl: 'assets/icon.svg',
        size: responsive.dp(22),
      ),
      child: LogInForm(),
    );
  }
}
