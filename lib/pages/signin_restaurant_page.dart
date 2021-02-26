import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/widgets/icon_container.dart';
import 'package:my_restaurant_frontend_app/widgets/screen_session.dart';
import 'package:my_restaurant_frontend_app/widgets/sign_in_restaurant_form.dart';

class SignInRestaurant extends StatefulWidget {
  @override
  _SignInRestaurantState createState() => _SignInRestaurantState();
}

class _SignInRestaurantState extends State<SignInRestaurant> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return ScreenSession(
      title: "Sign in",
      heightBack: responsive.height * 0.7,
      heightFront: responsive.height * 0.55,
      iconContainer: IconContainer(
        iconUrl: 'assets/icons/001-restaurant.svg',
        size: responsive.dp(15),
      ),
      child: SignInRestaurantForm(),
    );
  }
}
