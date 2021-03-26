import 'dart:convert';
import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_restaurant_frontend_app/class/Ingredient.dart';
import 'package:my_restaurant_frontend_app/services/services.dart';
import 'package:my_restaurant_frontend_app/utils/convertDataJson.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/widgets/custom_dropdowm_form.dart';

class DialogAddIngredientInDish extends StatefulWidget {
  final String title, descriptions, dishId;

  const DialogAddIngredientInDish({
    Key key,
    this.title,
    this.descriptions,
    this.dishId,
  }) : super(key: key);

  @override
  _DialogAddIngredientInDishState createState() =>
      _DialogAddIngredientInDishState();
}

class _DialogAddIngredientInDishState extends State<DialogAddIngredientInDish> {
  List<Ingredient> _ingredients = [];
  String _ingredientId;
  bool _update = false;

  GlobalKey<FormState> _formKeyAddIngredientDish = GlobalKey();
  RestClientServices _restClientServices = RestClientServices();
  var _session = FlutterSession();

  @override
  void initState() {
    this._init();
    super.initState();
  }

  void _init() {
    this._getIngredients();
    super.initState();
  }

  void _getIngredients() async {
    dynamic token = await _session.get("token");
    await _restClientServices
        .getAuthorization("api_admin/ingredients/", token)
        .then(
      (response) {
        if (response.statusCode == 0) {
          setState(() {
            _ingredients = parseIngredients(response.data);
          });
        } else {
          Fluttertoast.showToast(
            msg: (jsonDecode(response.message).containsKey("detail")
                ? jsonDecode(response.message)["detail"]
                : jsonDecode(response.message)),
          );
        }
      },
    );
  }

  void _addIngredientInDish() async {
    var isOk = _formKeyAddIngredientDish.currentState.validate();
    if (isOk) {
      Map<String, dynamic> data = {
        'dish_id': widget.dishId,
        'ingredient_id': _ingredientId,
      };
      _formKeyAddIngredientDish.currentState.reset();
      print(data);
      dynamic token = await _session.get("token");
      await _restClientServices
          .postGenericToken("api_admin/dish/dish_ingredient", data, token)
          .then((value) {
        if (value.statusCode == 0) {
          setState(() {
            _update = true;
          });
          Fluttertoast.showToast(
            msg: "Ingrediente agregado exitosamente",
            toastLength: Toast.LENGTH_LONG,
          );
          Navigator.pop(context, _update);
        } else {
          Fluttertoast.showToast(
            msg: (jsonDecode(value.message).containsKey("detail")
                ? jsonDecode(value.message)["detail"]
                : jsonDecode(value.message)),
          );
        }
      });
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
                  key: _formKeyAddIngredientDish,
                  child: Column(
                    children: [
                      (_ingredients.length <= 0)
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : CustomDropdownForm(
                              width: responsive.width * 0.9,
                              onChanged: (text) {
                                _ingredientId = text;
                              },
                              hintText: "Select to Ingredient",
                              options: _ingredients,
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: AnimatedButton(
                              text: "Add Ingredient",
                              color: MyColors.accentColor,
                              icon: Icons.add,
                              width: responsive.width * 0.4,
                              buttonTextStyle: TextStyle(
                                color: Colors.white,
                                fontSize: responsive.dp(1.5),
                                fontWeight: FontWeight.bold,
                              ),
                              pressEvent: () {
                                this._addIngredientInDish();
                                // this._addIngredient();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: AnimatedButton(
                              text: "Close",
                              color: MyColors.darkPrimaryColor,
                              icon: Icons.close,
                              width: responsive.width * 0.25,
                              buttonTextStyle: TextStyle(
                                color: Colors.white,
                                fontSize: responsive.dp(1.5),
                                fontWeight: FontWeight.bold,
                              ),
                              pressEvent: () {
                                setState(() {
                                  _update = false;
                                });
                                Navigator.pop(context, _update);
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
              backgroundColor: MyColors.darkPrimaryColor,
              radius: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(45),
                ),
                child: SvgPicture.asset(
                  "assets/icons/ingredients.svg",
                  width: responsive.width * 0.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
