import 'dart:async';
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:my_restaurant_frontend_app/class/Positions.dart';
import 'package:my_restaurant_frontend_app/services/services.dart';
import 'package:my_restaurant_frontend_app/utils/convertDataJson.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/utils/string_extension.dart';
import 'package:my_restaurant_frontend_app/widgets/input_text.dart';
import 'package:my_restaurant_frontend_app/widgets/message_dialog.dart';
import 'package:my_restaurant_frontend_app/widgets/my_snack_bar.dart';
import 'package:my_restaurant_frontend_app/widgets/select_position.dart';
import 'package:ots/ots.dart';

class RegisterUserForm extends StatefulWidget {
  final String existPosition;

  const RegisterUserForm({Key key, this.existPosition}) : super(key: key);

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
  String restaurantCode = "";
  Timer _timer;
  int _idPosition, _start = 10;
  bool isLoading = true, enableForm = false, obscureText = true;
  RestClientServices _restClientServices = RestClientServices();
  List<Position> positions = [];
  Position position;
  GlobalKey<FormState> _formKeySignIn = GlobalKey();
  var _session = FlutterSession();

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    widget.existPosition == null
        ? this._getPositions()
        : this._getPositionByName(widget.existPosition);
    super.initState();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
          isLoading = false;
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  Future<void> _getPositions() async {
    await _restClientServices
        .get("api_admin/api_auth/positions")
        .then((response) {
      setState(() {
        positions = parsePositionList(response.data);
        enableForm = true;
      });
    });
  }

  Future<void> _getPositionByName(String positionName) async {
    startTimer();
    dynamic code = await _session.get("restaurantCode");
    await _restClientServices
        .get("api_admin/api_auth/positions/by_name/$positionName")
        .then(
      (value) {
        if (value.statusCode == 0) {
          setState(() {
            position = parsePosition(value.data);
            restaurantCode = code;
            enableForm = true;
          });
        }
      },
    );
  }

  _register() async {
    final isOk = _formKeySignIn.currentState.validate();
    if (isOk) {
      showLoader(isModal: true);
      Map<String, dynamic> data = {
        "first_name": _firstName,
        "last_name": _lastName,
        "username": _username,
        "email": _email,
        "phone": _phone,
        "password": _password,
        "position_id": widget.existPosition == null ? _idPosition : position.id,
        "restaurant_code":
            restaurantCode.length <= 0 ? _codeRestaurant : restaurantCode,
      };
      //print(data);
      await _restClientServices
          .postGeneric("api_admin/api_auth/register/".endSlash(), data)
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
          });
        } else {
          hideLoader();
          try {
            var decodedJson = jsonDecode(value.message) as Map<String, dynamic>;
            //snackBarResponseAPI(context, decodedJson);
          } on FormatException {
            mySnackBar(context, value.message);
          }
        }
      });
      hideLoader();
    }
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
            widget.existPosition != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      widget.existPosition.capitalizeFirstWord(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: responsive.dp(2.5),
                      ),
                    ),
                  )
                : Container(),
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
            (restaurantCode == "")
                ? InputText(
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
                        return "invalid code of restaurant"
                            .capitalizeEachWord();
                      }
                      return null;
                    },
                  )
                : Text(
                    "Restaurant Code : $restaurantCode",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: responsive.dp(2),
                    ),
                  ),
            (widget.existPosition == null)
                ? (positions.length == 0)
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
                            return "please select a position"
                                .capitalizeEachWord();
                          }
                          return null;
                        },
                      )
                : Container(),
            Padding(
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
            ),
          ],
        ),
      ),
    );
  }
}
