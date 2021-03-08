import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_restaurant_frontend_app/services/services.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/utils/string_extension.dart';
import 'package:my_restaurant_frontend_app/widgets/input_text.dart';
import 'package:my_restaurant_frontend_app/widgets/message_dialog.dart';
import 'package:my_restaurant_frontend_app/widgets/my_snack_bar.dart';
import 'package:my_restaurant_frontend_app/widgets/snack_bar_response_api.dart';

class RegisterRestaurantForm extends StatefulWidget {
  @override
  _RegisterRestaurantFormState createState() => _RegisterRestaurantFormState();
}

class _RegisterRestaurantFormState extends State<RegisterRestaurantForm> {
  GlobalKey<FormState> _formRestaurantKey = GlobalKey();
  RestClientServices _restClientServices = RestClientServices();
  String _name, _address, _phone, _cellphone;
  bool isLoading = false;
  final focusNode = FocusNode();

  _submitRestaurant() async {
    final isOk = _formRestaurantKey.currentState.validate();
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      isLoading = true;
    });
    if (isOk) {
      Map<String, dynamic> data = {
        "name": _name,
        "address": _address,
        "phone": _phone,
        "cellphone": _cellphone,
      };
      print(data);
      await _restClientServices
          .postWithoutSlash("api_admin/api_auth/restaurants", data)
          .then((value) {
        if (value.statusCode == 0) {
          MessageDialog.dialogMessageSuccessRestaurant(
            context,
            jsonDecode(value.data)["code"].toString(),
            "success".capitalizeEachWord(),
            "the code of your restaurant is :".capitalizeEachWord(),
            "copy to clipboard".capitalizeEachWord(),
          );
          _formRestaurantKey.currentState.reset();
        } else {
          try {
            var decodedJson = jsonDecode(value.message) as Map<String, dynamic>;
            snackBarResponseAPI(context, decodedJson);
          } on FormatException catch (e) {
            mySnackBar(context, value.message);
          }
        }
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    double inputWidth = responsive.width * 0.85;
    return Container(
      constraints: BoxConstraints(
        maxWidth: responsive.width,
      ),
      child: Form(
        key: _formRestaurantKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(2.5),
              child: InputText(
                formEnabled: true,
                obscureText: true,
                width: inputWidth,
                type: TextInputType.text,
                label: 'name of restaurant',
                fontSize: responsive.dp(2),
                onChanged: (text) {
                  _name = text;
                },
                validator: (text) {
                  if (text.trim().length <= 0 || text.isEmpty) {
                    return "invalid restaurant name".capitalizeEachWord();
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.5),
              child: InputText(
                formEnabled: true,
                obscureText: true,
                width: inputWidth,
                type: TextInputType.text,
                label: 'address of restaurant',
                fontSize: responsive.dp(2),
                onChanged: (text) {
                  _address = text;
                },
                validator: (text) {
                  if (text.trim().length <= 0 || text.isEmpty) {
                    return "invalid address restaurant".capitalizeEachWord();
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.5),
              child: InputText(
                formEnabled: true,
                obscureText: true,
                width: inputWidth,
                type: TextInputType.phone,
                label: 'phone of restaurant',
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
            ),
            Padding(
              padding: const EdgeInsets.all(2.5),
              child: InputText(
                formEnabled: true,
                obscureText: true,
                width: inputWidth,
                type: TextInputType.phone,
                label: 'cellphone of restaurant',
                fontSize: responsive.dp(2),
                onChanged: (text) {
                  _cellphone = text;
                },
                validator: (text) {
                  if (text.trim().length <= 0 || text.isEmpty) {
                    return "invalid cellphone".capitalizeEachWord();
                  }
                  return null;
                },
              ),
            ),
            !isLoading
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Container(
                      height: responsive.height * 0.05,
                      child: AnimatedButton(
                        text: "Register",
                        color: MyColors.accentColor,
                        icon: Icons.add_business_outlined,
                        width: responsive.width * 0.8,
                        buttonTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: responsive.dp(2),
                          fontWeight: FontWeight.bold,
                        ),
                        pressEvent: () {
                          this._submitRestaurant();
                        },
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ],
        ),
      ),
    );
  }
}
