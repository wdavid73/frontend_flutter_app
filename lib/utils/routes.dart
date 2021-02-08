import 'package:flutter/cupertino.dart';
import 'package:my_restaurant_frontend_app/pages/home_page.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => MyHomePage(
        title: "My Home Page",
      )
};
