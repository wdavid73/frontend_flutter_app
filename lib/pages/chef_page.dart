import 'package:flutter/material.dart';

class ChefPageHome extends StatefulWidget {
  @override
  _ChefPageHomeState createState() => _ChefPageHomeState();
}

class _ChefPageHomeState extends State<ChefPageHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("chef page home"),
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text("back"),
            )
          ],
        ),
      ),
    );
  }
}
