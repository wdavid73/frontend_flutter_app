import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:my_restaurant_frontend_app/class/Positions.dart';
import 'package:my_restaurant_frontend_app/class/User.dart';
import 'package:my_restaurant_frontend_app/services/services.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/my_navigator.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/utils/string_extension.dart';
import 'package:my_restaurant_frontend_app/utils/unFocusForm.dart';
import 'package:my_restaurant_frontend_app/widgets/input_text.dart';
import 'package:my_restaurant_frontend_app/widgets/my_snack_bar.dart';
import 'package:ots/ots.dart';

class LogInForm extends StatefulWidget {
  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  var _session = FlutterSession();
  String _username, _password;
  bool obscureText = true;
  RestClientServices _restClientServices = RestClientServices();
  GlobalKey<FormState> _formKeyLogIn = GlobalKey();

  _getUserId(dynamic token) async {
    String userId;
    await _restClientServices
        .getAuthorization("dj-rest-auth/user/".endSlash(), token)
        .then((response) {
      if (response.statusCode == 0) {
        dynamic json = jsonDecode(response.data);
        User user = User.fromJson(json);
        _session.set("name", user.firstName + " " + user.lastName);
        _session.set("username", user.username);
        _session.set("email", user.email);
        userId = user.pk.toString();
      }
    });
    return userId;
  }

  _getRestaurantCodeByUser(String userId) async {
    dynamic token = await FlutterSession().get("token");
    await _restClientServices
        .getAuthorization("api_admin/api_auth/restaurants/code/$userId/", token)
        .then((response) {
      if (response.statusCode == 0) {
        String restaurantCode = jsonDecode(response.data)["code"];
        _session.set("restaurantCode", restaurantCode);
      } else {
        print("error message");
        print(response.statusCode);
        print(response.data);
        print(response.message);
      }
    });
  }

  _getPositionByUser(String userId) async {
    dynamic token = await FlutterSession().get("token");
    String positionName;
    await _restClientServices
        .getAuthorization(
            "api_admin/api_auth/positions/by_user/$userId/".endSlash(), token)
        .then((response) {
      if (response.statusCode == 0) {
        dynamic json = jsonDecode(response.data);
        Position position = Position.fromJson(json);
        positionName = position.name;
        _session.set("position_user", positionName);
      }
    });
    return positionName;
  }

  _login() async {
    final isOk = _formKeyLogIn.currentState.validate();
    if (isOk) {
      _formKeyLogIn.currentState.reset();
      unFocusForm(context);
      showLoader(isModal: true);
      Map<String, dynamic> myData = {
        "username": _username,
        "password": _password,
      };
      // print(data);
      await _restClientServices
          .postGeneric("dj-rest-auth/login/".endSlash(), myData)
          .then((response) async {
        if (response.statusCode == 0) {
          dynamic token = jsonDecode(response.data)["key"];

          _session.set("token", token);
          String userId = await this._getUserId(token);
          String positionName = await this._getPositionByUser(userId);
          await this._getRestaurantCodeByUser(userId);
          positionName == "Admin"
              ? MyNavigator.goToAdminPage(context)
              : positionName == "Chef"
                  ? MyNavigator.goToChefPage(context)
                  : positionName == "Waiter"
                      ? MyNavigator.goToWaiterPage(context)
                      : mySnackBar(
                          context,
                          "Porfavor registre su usuario correctamente o contacte con soporte",
                        );
        } else {
          hideLoader();
          mySnackBar(
            context,
            response.message.toString(),
          );
          print(jsonDecode(response.message.toString())["non_field_errors"]);
          print("!!error");
        }
      });
      hideLoader();
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
                // if (text.length <= 8) {
                //   return "password size must be greater than 8"
                //       .capitalizeEachWord();
                // }
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
                color: Colors.black,
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
