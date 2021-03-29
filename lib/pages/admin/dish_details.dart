import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:my_restaurant_frontend_app/class/Dish.dart';
import 'package:my_restaurant_frontend_app/services/services.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/utils/string_extension.dart';
import 'package:my_restaurant_frontend_app/widgets/basic_alert_dialog.dart';
import 'package:my_restaurant_frontend_app/widgets/dialog_add_ingredient_dish.dart';
import 'package:my_restaurant_frontend_app/widgets/item_ingredient.dart';
import 'package:my_restaurant_frontend_app/widgets/message_dialog.dart';

class DishDetails extends StatefulWidget {
  final Dish dish;
  const DishDetails({Key key, this.dish}) : super(key: key);
  @override
  _DishDetailsState createState() => _DishDetailsState();
}

class _DishDetailsState extends State<DishDetails> {
  RestClientServices _restClientServices = RestClientServices();
  var _session = FlutterSession();
  DishIngredients dishIngredients;
  bool showText = false, favorite = false;

  @override
  void initState() {
    this._init();
    super.initState();
  }

  void _init() {
    this._detailsDish();
    super.initState();
  }

  void _detailsDish() async {
    dynamic token = await _session.get("token");
    await _restClientServices
        .getAuthorization("api_admin/dish/get_dish/${widget.dish.id}", token)
        .then((value) {
      if (value.statusCode == 0) {
        setState(() {
          dishIngredients = DishIngredients.fromJson(jsonDecode(value.data));
          showText = true;
        });
      } else {
        MessageDialog.dialogMessageWarning(
            context, "Warning", jsonDecode(value.message), "Ok");
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
            child: DialogAddIngredientInDish(
              title: "add ingredient to this Dish".capitalizeFirstWord(),
              descriptions: "you want to add a new ingredient to this dish"
                  .capitalizeFirstWord(),
              dishId: widget.dish.id.toString(),
            ),
          );
        });
    if (result) {
      this._detailsDish();
    }
  }

  void dialogDeleteIngredient(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return BasicAlertDialog(
            title: "Delete Ingredient",
            desc: "Are you sure about delete this ingredient in the dish",
            okButton: true,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        actions: [
          FlatButton(
            minWidth: responsive.wp(5),
            onPressed: () {
              setState(() {
                favorite = !favorite;
              });
            },
            child: Icon(
              favorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              //constraints: BoxConstraints.expand(),
              height: responsive.height * 0.4,
              width: responsive.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.dish.photo),
                  fit: BoxFit.cover,
                ),
              ),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    //alignment: Alignment.center,
                    color: Colors.grey.withOpacity(0.1),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Align(
                                      child: Text(
                                        "${widget.dish.name}"
                                            .capitalizeEachWord(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: responsive.dp(4),
                                          color: Colors.white,
                                        ),
                                      ),
                                      alignment: Alignment.topLeft,
                                    ),
                                  ),
                                  SizedBox(
                                    height: responsive.height * 0.145,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        "\$ ${widget.dish.price}"
                                            .capitalizeEachWord(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: responsive.dp(3),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: responsive.height * 0.6, // pass
              width: responsive.width,
              decoration: new BoxDecoration(
                color: MyColors.darkPrimaryColor,
                borderRadius: BorderRadius.only(
                  topRight: const Radius.circular(20),
                  topLeft: const Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: dishIngredients != null
                            ? Column(
                                children: List.generate(
                                  dishIngredients.ingredients.length,
                                  (index) {
                                    return ItemIngredient(
                                      ingredient:
                                          dishIngredients.ingredients[index],
                                      longPress: () =>
                                          this.dialogDeleteIngredient(context),
                                    );
                                  },
                                ),
                              )
                            : SizedBox(
                                height: responsive.height * 0.5,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                    semanticsLabel: "sin info",
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          this._displayTextInputDialog(context);
          print("add ingredient to dish ${dishIngredients.dish.id}");
        },
        child: const Icon(Icons.add),
        backgroundColor: MyColors.accentColor,
      ),
    );
  }
}

/*
* dishIngredients != null
          ?
          *
          * : Center(
              child: CircularProgressIndicator(
                semanticsLabel: "sin info",
              ),
            ),
* */
