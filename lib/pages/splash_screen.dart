import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/my_navigator.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/widgets/icon_container.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => MyNavigator.goToHome(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: MyColors.darkPrimaryColor,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconContainer(
                        iconUrl: 'assets/icon.svg',
                        size: responsive.dp(15),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Text(
                        "My Restaurant App",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                flex: 2,
              ),
              // Expanded(
              //   flex: 1,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       // CircularProgressIndicator(
              //       //   backgroundColor: Colors.white,
              //       // ),
              //       // Padding(
              //       //   padding: EdgeInsets.only(top: 20),
              //       // ),
              //       // Text(
              //       //   "Loading...",
              //       //   style: TextStyle(
              //       //       color: Colors.white,
              //       //       fontSize: 18,
              //       //       fontWeight: FontWeight.bold),
              //       // ),
              //       // ButtonTap(
              //       //   text: '!Tap this',
              //       //   icon: Icons.arrow_forward_outlined,
              //       //   onPressed: () => MyNavigator.goToHome(context),
              //       // )
              //     ],
              //   ),
              // )
            ],
          )
        ],
      ),
    );
  }
}
