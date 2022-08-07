import 'package:flutter/material.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/forms/sign_up_restaurant_form.dart';
import 'package:my_restaurant_app/widgets/icon_container.dart';
import 'package:my_restaurant_app/widgets/screen/screen_session.dart';

class SignUpRestaurantPage extends StatefulWidget {
  const SignUpRestaurantPage({Key? key}) : super(key: key);

  @override
  _SignUpRestaurantPageState createState() => _SignUpRestaurantPageState();
}

class _SignUpRestaurantPageState extends State<SignUpRestaurantPage> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return ScreenSession(
      title: "Sign up Restaurant",
      heightBack: responsive.hp(70),
      heightFront: responsive.hp(55),
      iconContainer: IconContainer(
        iconUrl: "restaurant.svg",
        size: responsive.dp(15),
        shadow: true,
      ),
      child: const SignUpRestaurantForm(),
    );
  }
}
