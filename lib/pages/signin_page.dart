import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/widgets/icon_container.dart';
import 'package:my_restaurant_frontend_app/widgets/screen_session.dart';
import 'package:my_restaurant_frontend_app/widgets/sign_in_form.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return ScreenSession(
      title: "Sign in",
      heightBack: responsive.height * 0.7,
      heightFront: responsive.height * 0.7,
      iconContainer: IconContainer(
        iconUrl: 'assets/icons/014-customer_service.svg',
        size: responsive.dp(15),
      ),
      child: SigInForm(),
    );
  }
}
