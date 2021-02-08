import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/routes.dart';

import 'pages/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: MyColors.darkPrimaryColor,
          accentColor: MyColors.accentColor),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: routes,
    );
  }
}
