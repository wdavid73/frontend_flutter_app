import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:my_restaurant_frontend_app/class/Ingredient.dart';
import 'package:my_restaurant_frontend_app/services/services.dart';
import 'package:my_restaurant_frontend_app/utils/convertDataJson.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/utils/string_extension.dart';
import 'package:my_restaurant_frontend_app/widgets/dialog_add_ingredient.dart';
import 'package:my_restaurant_frontend_app/widgets/item_ingredient.dart';
import 'package:my_restaurant_frontend_app/widgets/message_dialog.dart';
import 'package:my_restaurant_frontend_app/widgets/screen_options_dashboard.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListIngredientsPage extends StatefulWidget {
  @override
  _ListIngredientsPageState createState() => _ListIngredientsPageState();
}

class _ListIngredientsPageState extends State<ListIngredientsPage> {
  var _session = FlutterSession();
  List<Ingredient> ingredients = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];

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

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    this._getIngredients();
    if (mounted) setState(() {});
    _refreshController.loadComplete();
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
    final Responsive responsive = Responsive(context);
    return ScreenOptionsDashboard(
      title: "Ingredients",
      child: ingredients.length > 0
          ? SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropHeader(
                waterDropColor: MyColors.darkPrimaryColor,
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.builder(
                itemCount: ingredients.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ItemIngredient(
                    length: ingredients.length,
                    ingredient: ingredients[index],
                    longPress: () => print("long press delete"),
                  );
                },
              ),
              /*
                * ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text('${items[index]}'),
    );
  },
);*/
              // children: List.generate(
              //   ingredients.length,
              //   (index) {
              //     return ItemIngredient(
              //       length: ingredients.length,
              //       ingredient: ingredients[index],
              //       longPress: () => print("long press delete"),
              //     );
              //   },
              // ),
            )
          : Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                semanticsLabel: "sin info",
              ),
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
