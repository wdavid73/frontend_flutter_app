import 'package:flutter/material.dart';
import 'package:my_restaurant_app/pages/home/home.dart';

class NavigationHome {
  static void goToHome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return const MyHomePage();
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> anotherAnimation, Widget child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
      (_) => false,
    );
  }
}
