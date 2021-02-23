import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/class/Positions.dart';
import 'package:my_restaurant_frontend_app/services/services.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/utils/string_extension.dart';
import 'package:my_restaurant_frontend_app/widgets/input_text.dart';
import 'package:my_restaurant_frontend_app/widgets/message_dialog.dart';
import 'package:my_restaurant_frontend_app/widgets/select_position.dart';
import 'package:my_restaurant_frontend_app/widgets/snack_bar_response_api.dart';

class SigInForm extends StatefulWidget {
  @override
  _SigInFormState createState() => _SigInFormState();
}

class _SigInFormState extends State<SigInForm> {
  String _firstName,
      _lastName,
      _username,
      _email,
      _phone,
      _password,
      _codeRestaurant;
  int _idPosition;
  RestClientServices _restClientServices = RestClientServices();
  List<Position> positions = [];
  GlobalKey<FormState> _formKeySignIn = GlobalKey();

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
    final isOk = _formKeySignIn.currentState.validate();
    if (isOk) {
      Map<String, dynamic> data = {
        "first_name": _firstName,
        "last_name": _lastName,
        "username": _username,
        "email": _email,
        "phone": _phone,
        "password": _password,
        "position_id": _idPosition,
        "restaurant_code": _codeRestaurant
      };

      //print(data);
      await _restClientServices
          .postUser2("api_admin/api_auth/register/", data)
          .then((value) {
        if (value.statusCode == 0) {
          print("good");
          MessageDialog.dialogMessageSuccess(
            context,
            "register user".capitalizeEachWord(),
            "the registration is successfully".capitalizeEachWord(),
            "continue".capitalizeEachWord(),
          );
          _formKeySignIn.currentState.reset();
        } else {
          try {
            var decodedJson = jsonDecode(value.message) as Map<String, dynamic>;
            snackBarResponseAPI(context, decodedJson);
          } on FormatException catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "${value.message} - $e",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                backgroundColor: MyColors.darkPrimaryColor,
                duration: Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Container(
      constraints: BoxConstraints(maxWidth: responsive.width),
      child: Form(
        key: _formKeySignIn,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InputText(
              type: TextInputType.text,
              label: 'you first name',
              fontSize: responsive.dp(2),
              onChanged: (text) {
                _firstName = text;
              },
              validator: (text) {
                if (text.trim().length <= 0 || text.isEmpty) {
                  return "invalid first name".capitalizeEachWord();
                }
                return null;
              },
            ),
            InputText(
              type: TextInputType.text,
              label: 'you last name',
              fontSize: responsive.dp(2),
              onChanged: (text) {
                _lastName = text;
              },
              validator: (text) {
                if (text.trim().length <= 0 || text.isEmpty) {
                  return "invalid last name".capitalizeEachWord();
                }
                return null;
              },
            ),
            InputText(
              type: TextInputType.text,
              label: 'your username',
              fontSize: responsive.dp(2),
              onChanged: (text) {
                _username = text;
              },
              validator: (text) {
                if (text.trim().length <= 0 || text.isEmpty) {
                  return "invalid username".capitalizeEachWord();
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
                  return "invalid password".capitalizeEachWord();
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
                  return "invalid code of restaurant".capitalizeEachWord();
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
                            backgroundColor: MyColors.lightPrimaryColor,
                            minHeight: responsive.height * 0.015,
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
                        return "please select a position".capitalizeEachWord();
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
    );
  }
}
