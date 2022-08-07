import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/navigation/home.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/icon_container.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => NavigationHome.goToHome(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: MyColors.darkPrimaryColor,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconContainer(
                      iconUrl: "assets/icon.svg",
                      size: responsive.dp(15),
                      shadow: false,
                      fullPath: true,
                    ),
                    Text(
                      "My Restaurant App",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: responsive.dp(2.6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                flex: 2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
