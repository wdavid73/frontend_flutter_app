import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/pages/home_page.dart';
import 'package:my_restaurant_frontend_app/pages/login_page.dart';
import 'package:my_restaurant_frontend_app/pages/signin_page.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => MyHomePage(title: "My Home Page"),
  "/login_page": (BuildContext context) => LoginPage(),
  "/sign_up_page": (BuildContext context) => SignInPage(),
  // "/home": (BuildContext context) => HomePage(),
  // "/list_clients": (BuildContext context) => ListClients(),
  // //"/details_clients": (BuildContext context) => ClientDetails(),
  // "/buttons_grid": (BuildContext context) => ButtonsCrid(),
  // "/signup": (BuildContext context) => SignUp(),
};
