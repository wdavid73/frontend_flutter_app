import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/class/Positions.dart';
import 'package:my_restaurant_frontend_app/services/services.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/utils/string_extension.dart';
import 'package:my_restaurant_frontend_app/widgets/icon_container.dart';
import 'package:my_restaurant_frontend_app/widgets/input_text.dart';
import 'package:my_restaurant_frontend_app/widgets/select_position.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _username, _email, _phone, _password, _codeRestaurant;
  int _idPosition;
  GlobalKey<FormState> _formKey = GlobalKey();
  RestClientServices _restClientServices = RestClientServices();
  List<Position> positions = [];

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    this._getPositions();
    super.initState();
  }

  Future<void> _getPositions() async {
    await _restClientServices
        .getPositions("api_admin/api_auth/positions")
        .then((value) {
      setState(() {
        positions = value.position;
      });
    });
  }

  _register() async {
    final isOk = _formKey.currentState.validate();
    if (isOk) {
      Map<String, dynamic> data = {
        "username": _username,
        "email": _email,
        "phone": _phone,
        "password": _password,
        "position_id": _idPosition,
        "restaurant_code": _codeRestaurant
      };
      print(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign in",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: responsive.dp(2),
          ),
        ),
        backgroundColor: MyColors.darkPrimaryColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: responsive.height * 0.7,
              width: responsive.width,
              color: MyColors.darkPrimaryColor,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 3),
                        child: IconContainer(
                          size: responsive.dp(12),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: responsive.height * 0.7,
              width: responsive.width,
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(30),
                  topRight: const Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InputText(
                              type: TextInputType.text,
                              label: 'your username',
                              fontSize: responsive.dp(2),
                              onChanged: (text) {
                                _username = text;
                              },
                              validator: (text) {
                                if (text.trim().length <= 0 || text.isEmpty) {
                                  return "invalid username"
                                      .capitalizeEachWord();
                                }
                                return null;
                              },
                            ),
                            InputText(
                              type: TextInputType.emailAddress,
                              label: 'your email address',
                              fontSize: responsive.dp(2),
                              onChanged: (text) {
                                _email = text;
                              },
                              validator: (text) {
                                if (text.trim().length <= 0 || text.isEmpty) {
                                  return "invalid email".capitalizeEachWord();
                                }
                                return null;
                              },
                            ),
                            InputText(
                              type: TextInputType.text,
                              label: 'your password',
                              fontSize: responsive.dp(2),
                              obscureText: true,
                              onChanged: (text) {
                                _password = text;
                              },
                              validator: (text) {
                                if (text.trim().length <= 0 || text.isEmpty) {
                                  return "invalid password"
                                      .capitalizeEachWord();
                                }
                                if (text.length <= 8) {
                                  return "password size must be greater than 8"
                                      .capitalizeEachWord();
                                }
                                return null;
                              },
                            ),
                            InputText(
                              type: TextInputType.phone,
                              label: 'your phone',
                              fontSize: responsive.dp(2),
                              onChanged: (text) {
                                _phone = text;
                              },
                              validator: (text) {
                                if (text.trim().length <= 0 || text.isEmpty) {
                                  return "invalid phone".capitalizeEachWord();
                                }
                                return null;
                              },
                            ),
                            InputText(
                              type: TextInputType.text,
                              label: 'code of your restaurant',
                              fontSize: responsive.dp(2),
                              onChanged: (text) {
                                _codeRestaurant = text;
                              },
                              validator: (text) {
                                if (text.trim().length <= 0 || text.isEmpty) {
                                  return "invalid code of restaurant"
                                      .capitalizeEachWord();
                                }
                                return null;
                              },
                            ),
                            (positions.length == 0)
                                ? Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          LinearProgressIndicator(
                                            backgroundColor:
                                                MyColors.lightPrimaryColor,
                                            minHeight:
                                                responsive.height * 0.015,
                                          ),
                                          Text(
                                            "Loading Positions...",
                                            style: TextStyle(
                                              color: MyColors.primaryTextColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: responsive.dp(1.8),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : SelectPosition(
                                    position: positions,
                                    onChanged: (value) {
                                      _idPosition = value;
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return "please select a position"
                                            .capitalizeEachWord();
                                      }
                                      return null;
                                    },
                                  ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: FlatButton(
                                onPressed: () {
                                  this._register();
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                color: MyColors.accentColor,
                                child: SizedBox(
                                  height: responsive.height * 0.06,
                                  width: responsive.width * 0.7,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Center(
                                      child: Text(
                                        "Register",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: responsive.dp(2),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
