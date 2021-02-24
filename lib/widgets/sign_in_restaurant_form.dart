import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/utils/string_extension.dart';
import 'package:my_restaurant_frontend_app/widgets/input_text.dart';
import 'package:my_restaurant_frontend_app/widgets/message_dialog.dart';

class SignInRestaurantForm extends StatefulWidget {
  @override
  _SignInRestaurantFormState createState() => _SignInRestaurantFormState();
}

class _SignInRestaurantFormState extends State<SignInRestaurantForm> {
  GlobalKey<FormState> _formRestaurantKey = GlobalKey();

  _submitRestaurant() async {
    final isOk = _formRestaurantKey.currentState.validate();
    FocusScope.of(context).requestFocus(new FocusNode());
    if (isOk) {
      print("register Restaurant");
      var code = "123ABC2";
      MessageDialog.dialogMessageSuccessRestaurant(
        context,
        code,
        "success".capitalizeEachWord(),
        "the code of your restaurant is :".capitalizeEachWord(),
        "copy to clipboard".capitalizeEachWord(),
      );
      _formRestaurantKey.currentState.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    double inputWidth = responsive.width * 0.85;
    return Container(
      constraints: BoxConstraints(
        maxWidth: responsive.width,
      ),
      child: Form(
        key: _formRestaurantKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(2.5),
              child: InputText(
                width: inputWidth,
                type: TextInputType.text,
                label: 'name of restaurant',
                fontSize: responsive.dp(2),
                onChanged: (text) {},
                validator: (text) {
                  if (text.trim().length <= 0 || text.isEmpty) {
                    return "invalid restaurant name".capitalizeEachWord();
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.5),
              child: InputText(
                width: inputWidth,
                type: TextInputType.text,
                label: 'address of restaurant',
                fontSize: responsive.dp(2),
                onChanged: (text) {},
                validator: (text) {
                  if (text.trim().length <= 0 || text.isEmpty) {
                    return "invalid address restaurant".capitalizeEachWord();
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.5),
              child: InputText(
                width: inputWidth,
                type: TextInputType.phone,
                label: 'phone of restaurant',
                fontSize: responsive.dp(2),
                onChanged: (text) {},
                validator: (text) {
                  if (text.trim().length <= 0 || text.isEmpty) {
                    return "invalid phone".capitalizeEachWord();
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.5),
              child: InputText(
                width: inputWidth,
                type: TextInputType.phone,
                label: 'cellphone of restaurant',
                fontSize: responsive.dp(2),
                onChanged: (text) {},
                validator: (text) {
                  if (text.trim().length <= 0 || text.isEmpty) {
                    return "invalid cellphone".capitalizeEachWord();
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Container(
                height: responsive.height * 0.05,
                child: AnimatedButton(
                  text: "Register",
                  color: MyColors.accentColor,
                  icon: Icons.add_business_outlined,
                  width: responsive.width * 0.8,
                  buttonTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: responsive.dp(2),
                    fontWeight: FontWeight.bold,
                  ),
                  pressEvent: () {
                    this._submitRestaurant();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
