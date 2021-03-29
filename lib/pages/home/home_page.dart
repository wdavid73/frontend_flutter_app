import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/my_navigator.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/widgets/button_tap.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime currentBackPressTime;
  _logIn() {
    MyNavigator.goToLogin(context);
  }

  _signIn() {
    MyNavigator.goToSignIn(context);
  }

  _signInRestaurant() {
    MyNavigator.goToSignInRestaurant(context);
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Stack(children: <Widget>[
          new ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Center(
            child: ClipRect(
              child: BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: responsive.height * 0.15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Welcome !",
                            style: TextStyle(
                              fontSize: responsive.dp(6),
                              fontWeight: FontWeight.bold,
                              color: MyColors.lightPrimaryColor,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "My Restaurant App",
                            style: TextStyle(
                              fontSize: responsive.dp(2),
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: responsive.height * 0.4,
                        ),
                        Center(
                          child: ButtonTap(
                            width: responsive.width * 0.7,
                            text: "Log in",
                            textBold: true,
                            icon: Icons.login_outlined,
                            onPressed: () {
                              this._logIn();
                            },
                            iconColor: MyColors.textPrimaryColor,
                            withShadow: false,
                          ),
                        ),
                        Center(
                          child: Column(
                            children: [
                              ButtonTap(
                                width: responsive.width * 0.7,
                                text: "Sign In a User",
                                textBold: true,
                                icon: Icons.arrow_forward_ios_outlined,
                                onPressed: () {
                                  this._signIn();
                                },
                                iconColor: MyColors.textPrimaryColor,
                                withShadow: false,
                              ),
                              ButtonTap(
                                width: responsive.width * 0.7,
                                text: "Sign In a Restaurant",
                                textBold: true,
                                icon: Icons.arrow_forward_ios_outlined,
                                onPressed: () {
                                  this._signInRestaurant();
                                },
                                iconColor: MyColors.textPrimaryColor,
                                withShadow: false,
                                fillColor: MyColors.darkPrimaryColor,
                              ),
                            ],
                          ),
                        ),

                        // Center(
                        //   child: ButtonTap(
                        //     text: "Sign In",
                        //     textBold: true,
                        //     icon: Icons.arrow_forward_ios_outlined,
                        //     onPressed: () {
                        //       this._signIn();
                        //     },
                        //     iconColor: MyColors.textPrimaryColor,
                        //     withShadow: false,
                        //   ),
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text(
                        //       "You dont have an account?",
                        //       style: TextStyle(
                        //         fontSize: responsive.dp(1.7),
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //     FlatButton(
                        //       onPressed: () {
                        //         this._signup();
                        //       },
                        //       child: Text(
                        //         "Sign Up",
                        //         style: TextStyle(
                        //           color: MyColors.accentColor,
                        //           fontSize: responsive.dp(1.7),
                        //         ),
                        //       ),
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Press Again for Exit");
      return Future.value(false);
    }
    exit(0);
  }
}
