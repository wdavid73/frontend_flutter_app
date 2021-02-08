import 'package:flutter/material.dart';

class MyNavigator {
  static void goToHome(BuildContext context) {
    Navigator.pushNamed(context, "/home");
  }

  static void goToListClients(BuildContext context) {
    Navigator.pushNamed(context, "/list_clients");
  }

  static void goToLogin(BuildContext context) {
    Navigator.pushNamed(context, "/login_page");
  }

  static void goToSignUp(BuildContext context) {
    Navigator.pushNamed(context, "/sign_up_page");
  }
}
