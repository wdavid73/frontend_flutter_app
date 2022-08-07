import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_restaurant_app/services/services.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/utils/snack_bar_message.dart';
import 'package:my_restaurant_app/widgets/alerts/message_dialog.dart';
import 'package:my_restaurant_app/widgets/input_custom.dart';
import 'package:my_restaurant_app/widgets/inputs/button_custom.dart';

class SignUpRestaurantForm extends StatefulWidget {
  const SignUpRestaurantForm({Key? key}) : super(key: key);

  @override
  _SignUpRestaurantFormState createState() => _SignUpRestaurantFormState();
}

class _SignUpRestaurantFormState extends State<SignUpRestaurantForm> {
  String _name = '', _address = '', _phone = '', _cellphone = '';
  bool isLoading = false, enabledForm = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final ApiProvider _api = ApiProvider();

  setLoading() {
    setState(() {
      isLoading = !isLoading;
      enabledForm = !enabledForm;
    });
  }

  Future<void> _signup() async {
    final isOk = _formKey.currentState!.validate();
    if (isOk) {
      setLoading();
      Map<String, dynamic> data = {
        "name": _name,
        "address": _address,
        "cellphone": _cellphone,
      };
      _phone != '' ? data["phone"] = _phone : null;

      await _api.post("restaurant/", data).then((response) {
        if (response.status) {
          dynamic restaurantCode = jsonDecode(response.data)["code"];
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBox(
                description:
                    "Restaurant successfully registered, your code is $restaurantCode",
                type: "success",
                context: context,
                buttonCopy: true,
                copyCode: () {
                  Clipboard.setData(ClipboardData(text: restaurantCode));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Code Copied")),
                  );
                  Navigator.pop(context);
                },
              );
            },
          );
          _formKey.currentState!.reset();
          FocusScope.of(context).requestFocus(FocusNode());
        } else {
          if (response.httpCode > 400) {
            snackBarMessage(
              context,
              "An error occurred during registration with the service.",
            );
          } else {
            snackBarMessage(
              context,
              "An error occurred during registration.",
            );
          }
        }
      });
      setLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Container(
      constraints: BoxConstraints(
        maxWidth: responsive.width,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: InputCustom(
                responsive: responsive,
                labelText: "Name",
                hintText: "Name of Restaurant",
                onChange: (text) {
                  _name = text;
                },
                validator: (text) {
                  if (text!.isEmpty) {
                    return "Invalid restaurant name";
                  }
                  return "";
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: InputCustom(
                responsive: responsive,
                labelText: "Address",
                hintText: "Address of Restaurant",
                onChange: (text) {
                  _address = text;
                },
                validator: (text) {
                  if (text!.isEmpty) {
                    return "Invalid restaurant address";
                  }
                  return "";
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: InputCustom(
                responsive: responsive,
                labelText: "Phone",
                hintText: "Phone of Restaurant",
                keyboardType: TextInputType.phone,
                onChange: (text) {
                  _phone = text;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: InputCustom(
                responsive: responsive,
                labelText: "Cellphone",
                hintText: "Cellphone of Restaurant",
                onChange: (text) {
                  _cellphone = text;
                },
                validator: (text) {
                  if (text!.isEmpty) {
                    return "Invalid restaurant cellphone";
                  }
                  return "";
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Button(
                text: "Register",
                icon: Icons.add_business_outlined,
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
