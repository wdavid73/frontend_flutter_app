import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/navigation/session.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/button_tap.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DateTime currentBackPressTime;

  _logIn() {
    NavigationSession.goToLogin(context);
  }

  _signIn() {
    NavigationSession.goToSignIn(context);
  }

  _signInRestaurant() {
    NavigationSession.goToSignInRestaurant(context);
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Press Again for Exit");
      return Future.value(false);
    }
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Stack(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/background-1.jpg"),
                    fit: BoxFit.cover,
                  ),
                  color: MyColors.defaultPrimaryColor,
                ),
              ),
            ),
            Center(
                child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                            style: GoogleFonts.mukta(
                              color: Colors.white,
                              fontSize: responsive.dp(6),
                              fontWeight: FontWeight.bold,
                            )

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
                              _logIn();
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
                                  _signIn();
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
                                  _signInRestaurant();
                                },
                                iconColor: MyColors.textPrimaryColor,
                                withShadow: false,
                                fillColor: MyColors.darkPrimaryColor,
                              ),
                              /*ElevatedButton(
                                onPressed: () =>
                                    MyNavigator.goToTesting(context),
                                child: Text("Go to testing page"),
                              )*/
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
