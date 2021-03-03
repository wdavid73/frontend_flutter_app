import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminPageHome extends StatefulWidget {
  @override
  _AdminPageHomeState createState() => _AdminPageHomeState();
}

class _AdminPageHomeState extends State<AdminPageHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("admin page home"),
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
