import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_restaurant_app/class/user.dart';
import 'package:my_restaurant_app/services/services.dart';
import 'package:my_restaurant_app/utils/error_manager.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/navigation/admin.dart';
import 'package:my_restaurant_app/utils/navigation/chef.dart';
import 'package:my_restaurant_app/utils/navigation/session.dart';
import 'package:my_restaurant_app/utils/navigation/waiter.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/utils/snack_bar_message.dart';
import 'package:my_restaurant_app/utils/utils.dart';
import 'package:my_restaurant_app/widgets/input_custom.dart';
import 'package:my_restaurant_app/widgets/inputs/button_custom.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String _username = '', _password = '';
  String _loadUsername = '', _loadPassword = '';
  bool obscureText = true;
  bool isLoading = false;
  final _session = SessionManager();
  final ApiProvider _api = ApiProvider();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final passwordField = TextEditingController();

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    final box = GetStorage();
    String username = box.read("username") ?? '';
    String password = box.read("password") ?? '';
    if (username != '' && password != '') {
      setState(() {
        _loadUsername = username;
        _loadPassword = password;
      });
    }
  }

  setLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  _login() async {
    final isOk = _formKey.currentState!.validate();
    if (isOk) {
      FocusScope.of(context).unfocus();
      Map<String, dynamic> data = {
        "username": _username != '' ? _username : _loadUsername,
        "password": _password != '' ? _password : _loadPassword,
      };
      setLoading();
      await _api.post("api_auth/login/", data).then(
        (response) async {
          if (response.status) {
            final box = GetStorage();
            box.write("username", _username);
            box.write("password", _password);

            dynamic json = jsonDecode(response.data);

            if (Utils.checkValidLogin(json['Token'])) {
              SimpleUser user = SimpleUser.fromJson(json["user"]);
              _session.set("username", user.username);
              _session.set("email", user.email);
              _session.set(
                "full_name",
                "${user.firstName} ${user.lastName}",
              );
              _session.set("position", user.position);
              _session.set("restaurant_code", user.restaurantCode);
              _session.set("token", json["Token"]);
              _formKey.currentState!.reset();
              user.position == "Admin"
                  ? NavigationAdmin.goToAdminPage(context)
                  : user.position == "Waiter"
                      ? NavigationWaiter.goToWaiterPage(context)
                      : user.position == "Chef"
                          ? NavigationChef.goToChefPage(context)
                          : snackBarMessage(context, "Error contact support");
            } else {
              snackBarMessage(context, 'Error logging in');
            }
          } else {
            //dynamic error = jsonDecode(response.message);
            //snackBarMessage(context, error["non_field_errors"][0]);
            String error = ErrorManager.manager(response);
            snackBarMessage(context, error);
          }
        },
      );
      setLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Container(
      constraints: BoxConstraints(maxWidth: responsive.width),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: InputCustom(
                initialValue: _loadUsername,
                responsive: responsive,
                hintText: "Input your username",
                labelText: "Username",
                withPrefixIcon: true,
                prefixIcon: const Icon(
                  Icons.account_circle,
                  color: MyColors.accentColor,
                ),
                onChange: (text) {
                  _username = text;
                },
                validator: (text) {
                  return validatorUsername(text);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: InputCustom(
                initialValue: _loadPassword,
                responsive: responsive,
                hintText: "Input your password",
                labelText: "Password",
                isPassword: obscureText,
                isPasswordField: true,
                prefixIcon: const Icon(
                  Icons.password,
                  color: MyColors.accentColor,
                ),
                showPassword: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                onChange: (text) {
                  _password = text;
                },
              ),
            ),
            GestureDetector(
              onTap: () => NavigationSession.goToForgotPassword(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot your password?",
                      style: TextStyle(
                        fontSize: responsive.dp(1.5),
                        color: MyColors.accentColor,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Button(
                text: "Log in",
                icon: Icons.login,
                withShadow: true,
                isLoading: isLoading,
                responsive: responsive,
                onPressed: () => _login(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String? validatorUsername(String? text) {
  if (text!.isEmpty) {
    return "Please input a username";
  }
  return null;
}
