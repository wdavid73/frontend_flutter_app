import 'package:flutter/material.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/forms/register_dish_form.dart';
import 'package:my_restaurant_app/widgets/screen/screen_options_admin.dart';
import 'package:my_restaurant_app/widgets/screen/screen_session.dart';

class RegisterDishPage extends StatelessWidget {
  const RegisterDishPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return ScreenOptionsAdmin(
      title: "Register Dish",
      child: ContentForm(
        heightBack: responsive.hp(20),
        heightFront: responsive.hp(75),
        child: const RegisterDishForm(),
      ),
    );
  }
}
