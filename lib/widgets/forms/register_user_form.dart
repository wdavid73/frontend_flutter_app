import 'dart:async';
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
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

class RegisterUserForm extends StatefulWidget {
  @override
  _RegisterUserFormState createState() => _RegisterUserFormState();
}

class _RegisterUserFormState extends State<RegisterUserForm> {
  String _firstName,
      _lastName,
      _username,
      _email,
      _phone,
      _password,
      _codeRestaurant;
  Timer _timer;
  int _idPosition, _start = 10;
  bool isLoading = false, enableForm = false;
  bool obscureText = true;
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

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
        MessageDialog.dialogMessageWarning(
          context,
          "Warning",
          "Please check your internet connection or contact support.",
          "Continue",
        );
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  Future<void> _getPositions() async {
    await _restClientServices
        .getPositions("api_admin/api_auth/positions")
        .then((value) {
      print(value.position);
      setState(() {
        positions = value.position != null ? value.position : [];
        enableForm = true;
      });
      // ignore: unnecessary_statements
      positions.length <= 0 ? startTimer() : null;
    });
  }

  _register() async {
    final isOk = _formKeySignIn.currentState.validate();
    setState(() {
      isLoading = true;
    });
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
          .postUser("api_admin/api_auth/register/", data)
          .then((value) {
        if (value.statusCode == 0) {
          MessageDialog.dialogMessageSuccess(
            context,
            "register user".capitalizeEachWord(),
            "the registration is successfully".capitalizeEachWord(),
            "continue".capitalizeEachWord(),
          ).then((value) {
            _formKeySignIn.currentState.reset();
            FocusScope.of(context).requestFocus(new FocusNode());
            setState(() {
              isLoading = false;
            });
          });
        } else {
          try {
            var decodedJson = jsonDecode(value.message) as Map<String, dynamic>;
            snackBarResponseAPI(context, decodedJson);
          } on FormatException catch (e) {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(
            //       "${value.message} - $e",
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 16,
            //       ),
            //     ),
            //     backgroundColor: MyColors.darkPrimaryColor,
            //     duration: Duration(seconds: 3),
            //     behavior: SnackBarBehavior.floating,
            //   ),
            // );
          }
        }
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    double inputWidth = responsive.width * 0.85;

    return Container(
      constraints: BoxConstraints(maxWidth: responsive.width),
      child: Form(
        key: _formKeySignIn,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InputText(
                  obscureText: true,
                  formEnabled: enableForm,
                  width: inputWidth / 2,
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
                  obscureText: true,
                  formEnabled: enableForm,
                  width: inputWidth / 2,
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
              ],
            ),
            InputText(
              obscureText: true,
              formEnabled: enableForm,
              width: inputWidth,
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
              obscureText: true,
              formEnabled: enableForm,
              width: inputWidth,
              type: TextInputType.emailAddress,
              label: 'your email address',
              fontSize: responsive.dp(2),
              onChanged: (text) {
                _email = text;
              },
              validator: (text) {
                if (text.trim().length <= 0 && text.isEmpty ||
                    !text.isValidEmail()) {
                  return "invalid email".capitalizeEachWord();
                }
                return null;
              },
            ),
            InputText(
              formEnabled: enableForm,
              isPasswordField: true,
              width: inputWidth,
              type: TextInputType.text,
              label: 'your password',
              fontSize: responsive.dp(2),
              obscureText: !obscureText,
              showPassword: () {
                print("show or hide password");
                setState(() {
                  obscureText = !obscureText;
                });
              },
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
              obscureText: true,
              formEnabled: enableForm,
              width: inputWidth,
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
              obscureText: true,
              formEnabled: enableForm,
              width: inputWidth,
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
            (positions.length == 0 || positions.length == null)
                ? Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Column(
                        children: [
                          RefreshProgressIndicator(
                            backgroundColor: MyColors.lightPrimaryColor,
                            //minHeight: responsive.height * 0.015,
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
                      FocusScope.of(context).requestFocus(new FocusNode());
                      _idPosition = value;
                    },
                    validator: (value) {
                      if (value == null) {
                        return "please select a position".capitalizeEachWord();
                      }
                      return null;
                    },
                  ),
            !isLoading
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: AnimatedButton(
                      text: "Register",
                      color: MyColors.accentColor,
                      icon: Icons.person_add,
                      width: responsive.width * 0.8,
                      buttonTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: responsive.dp(2),
                        fontWeight: FontWeight.bold,
                      ),
                      pressEvent: () {
                        this._register();
                      },
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  )
          ],
        ),
      ),
    );
  }
}
