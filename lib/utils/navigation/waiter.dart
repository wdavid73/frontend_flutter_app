import 'package:flutter/material.dart';
import 'package:my_restaurant_app/pages/waiter/find_order/find_order_page.dart';
import 'package:my_restaurant_app/pages/waiter/list_orders_page.dart';
import 'package:my_restaurant_app/pages/waiter/create_order/make_order_page.dart';
import 'package:my_restaurant_app/pages/waiter/waiter_page.dart';

class NavigationWaiter {
  static void goToWaiterPage(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return const WaiterPage();
        },
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> anotherAnimation, Widget child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
      (_) => false,
    );
  }

  static void goToListOrders(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return const ListOrdersPage();
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> anotherAnimation, Widget child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  static void goToMakeOrder(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return const MakeOrderPage();
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> anotherAnimation, Widget child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  static void goToFindOrder(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return const FindOrderPage();
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> anotherAnimation, Widget child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }
}
