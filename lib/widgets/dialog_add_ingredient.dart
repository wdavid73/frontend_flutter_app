import 'dart:convert';
import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_restaurant_frontend_app/class/Ingredient.dart';
import 'package:my_restaurant_frontend_app/services/services.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/utils/string_extension.dart';
import 'package:my_restaurant_frontend_app/widgets/custom_dropdowm_form.dart';
import 'package:my_restaurant_frontend_app/widgets/input_text.dart';
import 'package:my_restaurant_frontend_app/widgets/numeric_step_button.dart';

class DialogAddIngredient extends StatefulWidget {
  final String title, descriptions;

  const DialogAddIngredient({
    Key key,
    this.title,
    this.descriptions,
  }) : super(key: key);

  @override
  _DialogAddIngredientState createState() => _DialogAddIngredientState();
}

class _DialogAddIngredientState extends State<DialogAddIngredient> {
  String _unit, _name;
  int _quantity;
  GlobalKey<FormState> _formKeyAddIngredient = GlobalKey();
  RestClientServices _restClientServices = RestClientServices();
  var _session = FlutterSession();

  void _addIngredient() async {
    var isOk = _formKeyAddIngredient.currentState.validate();
    if (isOk) {
      dynamic data = Ingredient(
        name: _name,
        quantity: _quantity.toString(),
        unit: _unit,
      ).toJson();
      dynamic token = await _session.get("token");
      await _restClientServices
          .postGenericToken("api_admin/ingredients/", data, token)
          .then((response) {
        if (response.statusCode == 0) {
          Fluttertoast.showToast(
            msg: "you ingredient was added successfully",
          );
        } else {
          Fluttertoast.showToast(
            msg: (jsonDecode(response.message).containsKey("detail")
                ? jsonDecode(response.message)["detail"]
                : jsonDecode(response.message)),
          );
        }
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20, top: 65, right: 20, bottom: 20),
            margin: EdgeInsets.only(top: 45),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(0, 10),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: responsive.dp(2.5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: responsive.height * 0.020,
                ),
                Text(
                  widget.descriptions,
                  style: TextStyle(fontSize: responsive.dp(1.6)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: responsive.height * 0.020,
                ),
                Form(
                  key: _formKeyAddIngredient,
                  child: Column(
                    children: [
                      InputText(
                        obscureText: true,
                        width: responsive.width * 0.8,
                        label: "name of ingredient".capitalizeFirstWord(),
                        onChanged: (text) => {_name = text},
                        formEnabled: true,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          NumericStepButton(
                            minValue: 1,
                            maxValue: 500,
                            onChanged: (value) => {_quantity = value},
                          ),
                          CustomDropdownForm(
                            width: responsive.width * 0.3,
                            onChanged: (text) {
                              _unit = text;
                            },
                            options: ['gr', 'oz'],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: AnimatedButton(
                          text: "Add Ingredient",
                          color: MyColors.accentColor,
                          icon: Icons.add,
                          width: responsive.width * 0.8,
                          buttonTextStyle: TextStyle(
                            color: Colors.white,
                            fontSize: responsive.dp(1.5),
                            fontWeight: FontWeight.bold,
                          ),
                          pressEvent: () {
                            this._addIngredient();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: responsive.height * 0.01,
                ),
              ],
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 45,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(45)),
                child: SvgPicture.asset("assets/icons/ingredients.svg"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
