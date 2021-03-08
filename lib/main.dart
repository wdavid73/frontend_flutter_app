import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/routes.dart';
import 'package:ots/ots.dart';

import 'pages/home/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OTS(
      loader: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(MyColors.darkPrimaryColor),
      ),
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: MyColors.darkPrimaryColor,
            accentColor: MyColors.accentColor),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: routes,
      ),
    );
  }
}
