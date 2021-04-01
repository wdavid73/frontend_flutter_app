import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/widgets/forms/register_dish_form.dart';
import 'package:my_restaurant_frontend_app/widgets/screen_options_dashboard.dart';
import 'package:my_restaurant_frontend_app/widgets/screen_session.dart';

class RegisterDishPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ScreenOptionsDashboard(
        title: "register dish",
        child: ContentForm(
          // iconContainer: IconContainer(
          //   iconUrl: "assets/icon.svg",
          //   size: responsive.dp(20),
          // ),
          heightBack: responsive.height * 0.2,
          heightFront: responsive.height * 0.8,
          child: FormRegisterDish(),
        ),
      ),
    );
  }
}

/*
* IconContainer(
                size: responsive.dp(20),
                iconUrl: "assets/icon.svg",
              ),
              InputText(
                width: responsive.width * 0.5,
                formEnabled: true,
                label: "Name of Dish",
                borderEnabled: true,
              ),
              Text("Name of Dish"),
              Text("Price of Dish"),
              Text("Type of Dish"),
* */
