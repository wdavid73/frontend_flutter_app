import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:my_restaurant_frontend_app/class/Ingredient.dart';
import 'package:my_restaurant_frontend_app/services/services.dart';
import 'package:my_restaurant_frontend_app/utils/convertDataJson.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/string_extension.dart';
import 'package:my_restaurant_frontend_app/widgets/dialog_add_ingredient.dart';
import 'package:my_restaurant_frontend_app/widgets/item_ingredient.dart';
import 'package:my_restaurant_frontend_app/widgets/message_dialog.dart';
import 'package:my_restaurant_frontend_app/widgets/screen_options_dashboard.dart';

class ListIngredientsPage extends StatefulWidget {
  @override
  _ListIngredientsPageState createState() => _ListIngredientsPageState();
}

class _ListIngredientsPageState extends State<ListIngredientsPage> {
  var _session = FlutterSession();
  List<Ingredient> ingredients = [];
  RestClientServices _restClientServices = RestClientServices();

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    this._getIngredients();
    super.initState();
  }

  Future<void> _getIngredients() async {
    dynamic token = await _session.get("token");
    _restClientServices
        .getAuthorization("api_admin/ingredients/", token)
        .then((response) {
      if (response.statusCode == 0) {
        setState(() {
          ingredients = parseIngredients(response.data);
        });
      } else {
        MessageDialog.dialogMessageWarning(
            context, "Warning", jsonDecode(response.message), "Ok");
      }
    });
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    final result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: DialogAddIngredient(
            title: "add ingredient to this Dish".capitalizeFirstWord(),
            descriptions: "you want to add a new ingredient to this dish"
                .capitalizeFirstWord(),
          ),
        );
      },
    );
    if (result) {
      this._getIngredients();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenOptionsDashboard(
      title: "Ingredients",
      child: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ingredients.length > 0
                    ? Column(
                        children: List.generate(ingredients.length, (index) {
                          return ItemIngredient(
                            ingredient: ingredients[index],
                            longPress: () => print("long press"),
                          );
                        }),
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          semanticsLabel: "sin info",
                        ),
                      ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          this._displayTextInputDialog(context);
          //print("add ingredient to dish ${dish.id}");
        },
        child: const Icon(Icons.add),
        backgroundColor: MyColors.accentColor,
      ),
    );
  }
}
