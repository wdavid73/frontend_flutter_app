import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/services/services.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/my_navigator.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/utils/string_extension.dart';
import 'package:my_restaurant_frontend_app/widgets/input_text.dart';

class LogInForm extends StatefulWidget {
  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  String _username, _password;
  bool obscureText = true;
  RestClientServices _restClientServices = RestClientServices();
  GlobalKey<FormState> _formKeyLogIn = GlobalKey();

  _login() async {
    final isOk = _formKeyLogIn.currentState.validate();
    if (isOk) {
      Map<String, dynamic> data = {
        "username": _username,
        "password": _password,
      };
      /*
      el request devuelve informacion como el tipo de usuario.
      dependiendo del tipo de usuario ira a admin_page , chef_page o waiter_page
      * */
      print(data);
      MyNavigator.goToAdminPage(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Container(
      constraints: BoxConstraints(maxWidth: responsive.width),
      child: Form(
        key: _formKeyLogIn,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InputText(
              obscureText: true,
              formEnabled: true,
              width: responsive.width * 0.85,
              type: TextInputType.text,
              label: 'username',
              fontSize: responsive.dp(2),
              onChanged: (text) {
                _username = text;
              },
              validator: (text) {
                if (text.trim().length <= 0 || text.isEmpty) {
                  return "invalid username".capitalizeEachWord();
                }
                return null;
              },
            ),
            InputText(
              formEnabled: true,
              width: responsive.width * 0.85,
              isPasswordField: true,
              type: TextInputType.text,
              label: "password",
              fontSize: responsive.dp(2),
              obscureText: !obscureText,
              showPassword: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              onChanged: (text) {
                _password = text;
              },
              validator: (text) {
                if (text.trim().length <= 0 || text.isEmpty) {
                  return "invalid password".capitalizeEachWord();
                }
                if (text.length <= 8) {
                  return "password size must be greater than 8"
                      .capitalizeEachWord();
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: AnimatedButton(
                text: "Log in",
                color: MyColors.accentColor,
                icon: Icons.login,
                width: responsive.width * 0.8,
                buttonTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: responsive.dp(2),
                    fontWeight: FontWeight.bold),
                pressEvent: () {
                  this._login();
                },
              ),
            ),
            Text(
              "you dont have a account?".capitalizeEachWord(),
              style: TextStyle(
                fontSize: responsive.dp(2),
                fontWeight: FontWeight.w500,
              ),
            ),
            GestureDetector(
              onTap: () {
                MyNavigator.goToSignIn(context);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "sign up here".capitalizeEachWord(),
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: responsive.dp(2),
                          fontWeight: FontWeight.w500,
                          color: MyColors.accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
