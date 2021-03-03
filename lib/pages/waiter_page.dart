import 'package:flutter/material.dart';

class WaiterPageHome extends StatefulWidget {
  @override
  _WaiterPageHomeState createState() => _WaiterPageHomeState();
}

class _WaiterPageHomeState extends State<WaiterPageHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("waiter page home"),
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
