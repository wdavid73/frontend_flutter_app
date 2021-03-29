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
import 'package:ots/ots.dart';

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
  bool _update = false;

  void _addIngredient() async {
    var isOk = _formKeyAddIngredient.currentState.validate();
    if (_quantity == null) {
      Fluttertoast.showToast(
          msg: "porfavor ingrese una cantidad de ingredientes mayor a cero");
    } else {
      if (isOk) {
        dynamic data = Ingredient(
          name: _name,
          quantity: _quantity.toString(),
          unit: _unit,
        ).toJson();
        showLoader(isModal: true);
        dynamic token = await _session.get("token");
        await _restClientServices
            .postGenericToken("api_admin/ingredients/", data, token)
            .then((response) {
          if (response.statusCode == 0) {
            Fluttertoast.showToast(
              msg: "you ingredient was added successfully",
            );
            Navigator.pop(context, true);
          } else {
            Fluttertoast.showToast(
              msg: (jsonDecode(response.message).containsKey("detail")
                  ? jsonDecode(response.message)["detail"]
                  : jsonDecode(response.message)),
            );
          }
        });
        hideLoader();
      }
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
                        validator: (text) {
                          if (text.length < 0 || text.isEmpty) {
                            return "enter name of ingredient"
                                .capitalizeFirstWord();
                          }
                          return null;
                        },
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
                            width: responsive.width * 0.4,
                            onChanged: (text) {
                              _unit = text;
                            },
                            hintText: "select a unit",
                            options: ['gr', 'oz'],
                            validator: (text) {
                              if (text == null) {
                                return "enter a unit of ingredient"
                                    .capitalizeFirstWord();
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: AnimatedButton(
                              text: "Add",
                              color: MyColors.accentColor,
                              icon: Icons.add,
                              width: responsive.width * 0.3,
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
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: AnimatedButton(
                              text: "Close",
                              color: MyColors.darkPrimaryColor,
                              icon: Icons.close,
                              width: responsive.width * 0.3,
                              buttonTextStyle: TextStyle(
                                color: Colors.white,
                                fontSize: responsive.dp(1.5),
                                fontWeight: FontWeight.bold,
                              ),
                              pressEvent: () {
                                Navigator.pop(context, false);
                              },
                            ),
                          ),
                        ],
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
