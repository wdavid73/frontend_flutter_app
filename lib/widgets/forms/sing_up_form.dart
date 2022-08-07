import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:my_restaurant_app/class/position.dart';
import 'package:my_restaurant_app/services/services.dart';
import 'package:my_restaurant_app/utils/error_manager.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/parse_data.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/utils/snack_bar_message.dart';
import 'package:my_restaurant_app/widgets/alerts/message_dialog.dart';
import 'package:my_restaurant_app/widgets/dropdown/position_dropdown.dart';
import 'package:my_restaurant_app/widgets/input_custom.dart';
import 'package:my_restaurant_app/widgets/inputs/button_custom.dart';

class SignUpForm extends StatefulWidget {
  final String? position;
  const SignUpForm({Key? key, this.position}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String _firstName = '',
      _lastName = '',
      _username = '',
      _email = '',
      _phone = '',
      _password = '',
      _codeRestaurant = '';
  String restaurantCode = '';
  bool isLoading = false, enabledForm = false;
  bool obscureTextPassword = true, obscureTextPasswordConfirm = true;
  List<Position> positions = [];
  Position position = Position(id: 0, name: '');
  int _idPosition = 0;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final ApiProvider _api = ApiProvider();
  final _session = SessionManager();

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    widget.position != null ? _getPositionByName(widget.position) : null;
    super.initState();
  }

  Future<List<Position>> _getPositions() async {
    var response = await _api.get("positions/get");
    setState(() {
      enabledForm = true;
    });
    return parsePositions(response.data);
  }

  setLoading() {
    setState(() {
      isLoading = !isLoading;
      enabledForm = !enabledForm;
    });
  }

  Future<void> _getPositionByName(String? positionName) async {
    dynamic code = await _session.get("restaurant_code");
    dynamic token = await _session.get("token");
    await _api.get("positions/by_name/$positionName", token).then(
      (value) {
        if (value.status) {
          setState(() {
            position = Position.parsePosition(value.data);
            restaurantCode = code;
            enabledForm = true;
          });
        }
      },
    );
  }

  Future<void> _signup() async {
    final isOk = _formKey.currentState!.validate();
    if (isOk) {
      setLoading();
      Map<String, dynamic> data = {
        "first_name": _firstName,
        "last_name": _lastName,
        "username": _username,
        "password": _password,
        "email": _email,
        "phone": _phone,
        "restaurant_code":
            restaurantCode == "" ? _codeRestaurant : restaurantCode,
        "position_id": widget.position == null ? _idPosition : position.id,
      };

      await _api.post("api_auth/register/", data).then((response) async {
        if (response.status) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBox(
                context: context,
                description: "Register Successfully",
                type: "success",
              );
            },
          );
          _formKey.currentState!.reset();
          FocusScope.of(context).requestFocus(FocusNode());
        } else {
          String error = ErrorManager.manager(response);
          snackBarMessage(context, error);
        }
      });
      setLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Container(
      constraints: BoxConstraints(maxWidth: responsive.width),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.position != null
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      "${widget.position}",
                      style: TextStyle(
                        fontSize: responsive.dp(2.5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InputCustom(
                  responsive: responsive,
                  inputWidth: responsive.wp(45),
                  hintText: "Input your first name",
                  labelText: "First Name",
                  withPrefixIcon: true,
                  enabled: enabledForm,
                  onChange: (text) {
                    _firstName = text;
                  },
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Please input your first name";
                    }
                    return "";
                  },
                ),
                InputCustom(
                  responsive: responsive,
                  inputWidth: responsive.wp(45),
                  hintText: "Input your last name",
                  labelText: "Last Name",
                  withPrefixIcon: true,
                  enabled: enabledForm,
                  onChange: (text) {
                    _lastName = text;
                  },
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Please input your last name";
                    }
                    return "";
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: InputCustom(
                responsive: responsive,
                inputWidth: responsive.wp(95),
                hintText: "Input your username",
                labelText: "Username",
                keyboardType: TextInputType.emailAddress,
                withPrefixIcon: true,
                enabled: enabledForm,
                onChange: (text) {
                  _username = text;
                },
                validator: (text) {
                  if (text!.isEmpty) {
                    return "Please input your username";
                  }
                  return "";
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: InputCustom(
                responsive: responsive,
                inputWidth: responsive.wp(95),
                hintText: "Input your email",
                labelText: "Email",
                withPrefixIcon: true,
                enabled: enabledForm,
                onChange: (text) {
                  _email = text;
                },
                validator: (text) {
                  if (text!.isEmpty) {
                    return "Please input your email";
                  }
                  return "";
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: InputCustom(
                responsive: responsive,
                inputWidth: responsive.wp(95),
                hintText: "Input your phone",
                labelText: "Phone",
                keyboardType: TextInputType.phone,
                enabled: enabledForm,
                onChange: (text) {
                  _phone = text;
                },
                validator: (text) {
                  if (text!.isEmpty) {
                    return "Please input your phone";
                  }
                  return "";
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: restaurantCode == ''
                  ? InputCustom(
                      responsive: responsive,
                      inputWidth: responsive.wp(95),
                      hintText: "Input your Restaurant Code",
                      labelText: "Restaurant Code",
                      toUpperCase: true,
                      enabled: enabledForm,
                      onChange: (text) {
                        _codeRestaurant = text;
                      },
                      validator: (text) {
                        if (text!.isEmpty) {
                          return "Please input your restaurant code";
                        }
                        return "";
                      },
                    )
                  : Text(
                      "Restaurant Code : $restaurantCode",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: responsive.dp(2),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: widget.position == null
                  ? DropdownPosition(
                      getPositions: _getPositions(),
                      responsive: responsive,
                      enabled: enabledForm,
                      onChanged: (value) {
                        setState(() {
                          _idPosition = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Please select your Position";
                        }
                        return "";
                      },
                    )
                  : Container(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: InputCustom(
                responsive: responsive,
                inputWidth: responsive.wp(95),
                hintText: "Input your password",
                labelText: "Password",
                withPrefixIcon: true,
                isPassword: obscureTextPassword,
                isPasswordField: true,
                enabled: enabledForm,
                prefixIcon: const Icon(
                  Icons.password,
                  color: MyColors.accentColor,
                ),
                showPassword: () {
                  setState(() {
                    obscureTextPassword = !obscureTextPassword;
                  });
                },
                onChange: (text) {
                  _password = text;
                },
                validator: (text) {
                  if (text!.isEmpty) {
                    return "Please input your password";
                  }
                  return "";
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: InputCustom(
                responsive: responsive,
                inputWidth: responsive.wp(95),
                hintText: "Input your Confirm password",
                labelText: "Confirm Password",
                withPrefixIcon: true,
                isPassword: obscureTextPasswordConfirm,
                isPasswordField: true,
                enabled: enabledForm,
                prefixIcon: const Icon(
                  Icons.password,
                  color: MyColors.accentColor,
                ),
                showPassword: () {
                  setState(() {
                    obscureTextPasswordConfirm = !obscureTextPasswordConfirm;
                  });
                },
                onChange: (text) {},
                validator: (text) {
                  if (text!.isEmpty) {
                    return "Please input your password";
                  }
                  if (text != _password) {
                    return "your confirmation password does not match";
                  }
                  return "";
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Button(
                text: "Sign up",
                icon: Icons.person_add_alt,
                withShadow: true,
                isLoading: isLoading,
                responsive: responsive,
                onPressed: () => _signup(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
