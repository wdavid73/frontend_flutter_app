import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/widgets/forms/register_user_form.dart';
import 'package:my_restaurant_frontend_app/widgets/icon_container.dart';
import 'package:my_restaurant_frontend_app/widgets/screen_session.dart';

class RegisterNewUser extends StatelessWidget {
  final String position;
  // receive data from the FirstScreen as a parameter
  RegisterNewUser({Key key, @required this.position}) : super(key: key);

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
      child: RegisterUserForm(existPosition: position),
    );
  }
}
