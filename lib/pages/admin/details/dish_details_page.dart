import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:my_restaurant_app/class/dish.dart';
import 'package:my_restaurant_app/class/ingredient.dart';
import 'package:my_restaurant_app/services/services.dart';
import 'package:my_restaurant_app/utils/error_manager.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/parse_data.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/utils/snack_bar_message.dart';
import 'package:my_restaurant_app/widgets/dialogs/dialog_add_ingredient_dish.dart';
import 'package:my_restaurant_app/widgets/list/list_ingredients.dart';

class DishDetailsPage extends StatefulWidget {
  final Dish dish;
  const DishDetailsPage({Key? key, required this.dish}) : super(key: key);

  @override
  State<DishDetailsPage> createState() => _DishDetailsPageState();
}

class _DishDetailsPageState extends State<DishDetailsPage> {
  bool showText = false, favorite = false, loader = false;
  final List<Ingredient> ingredients = [];
  final _session = SessionManager();
  final ApiProvider _api = ApiProvider();

  setFavorite() {
    setState(() {
      favorite = !favorite;
    });
  }

  Future<List<Ingredient>> _getIngredientsDish() async {
    dynamic token = await _session.get("token");
    var response = await _api.get(
        "api_admin/dish/get_ingredients/${widget.dish.id}", token);
    if (response.status) {
      return parseIngredients(response.data);
    }
    String error = ErrorManager.manager(response);
    snackBarMessage(context, error);
    return [];
  }

  Future<void> _displayDialogAddIngredient(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          child: SizedBox(
            width: 200,
            height: 300,
            child: DialogAddIngredientDish(
              dish: widget.dish,
            ),
          ),
          onWillPop: () => Future.value(false),
        );
      },
    );
    if (result) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: MyColors.darkPrimaryColor,
        actions: [
          TextButton(
            onPressed: () => setFavorite(),
            child: Icon(
              favorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: responsive.hp(32),
              width: responsive.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.dish.photo),
                  fit: BoxFit.cover,
                ),
              ),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                  child: Container(
                    color: Colors.grey.withOpacity(0.1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.dish.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: responsive.dp(4),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "\$ ${widget.dish.price}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: responsive.dp(4),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
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
              height: responsive.hp(60),
              width: responsive.width,
              decoration: const BoxDecoration(
                color: MyColors.darkPrimaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: ListIngredients(
                responsive: responsive,
                getIngredients: _getIngredientsDish(),
                textColor: Colors.white,
                refresh: () {
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _displayDialogAddIngredient(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: MyColors.accentColor,
      ),
    );
  }
}
