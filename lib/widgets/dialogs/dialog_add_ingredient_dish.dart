import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_restaurant_app/class/dish.dart';
import 'package:my_restaurant_app/class/ingredient.dart';
import 'package:my_restaurant_app/services/services.dart';
import 'package:my_restaurant_app/utils/error_manager.dart';
import 'package:my_restaurant_app/utils/parse_data.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/utils/snack_bar_message.dart';
import 'package:my_restaurant_app/widgets/dialogs/dialog_container.dart';
import 'package:my_restaurant_app/widgets/inputs/button_custom.dart';
import 'package:my_restaurant_app/widgets/list/list_ingredients_simple.dart';

class DialogAddIngredientDish extends StatefulWidget {
  final Dish dish;
  const DialogAddIngredientDish({Key? key, required this.dish})
      : super(key: key);

  @override
  _DialogAddIngredientDishState createState() =>
      _DialogAddIngredientDishState();
}

class _DialogAddIngredientDishState extends State<DialogAddIngredientDish> {
  List<Ingredient> ingredients = [], ingredientsSelected = [];
  bool isLoading = false;
  final _session = SessionManager();
  final ApiProvider _api = ApiProvider();

  setLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    _getIngredients();
  }

  Future<void> _getIngredients() async {
    dynamic token = await _session.get("token");
    var response = await _api.get("api_admin/ingredients/", token);
    if (response.status) {
      setState(() {
        ingredients = parseIngredients(response.data);
      });
    } else {
      String error = ErrorManager.manager(response);
      snackBarMessage(context, error);
    }
    //return parseIngredients(response.data);
  }

  void addIngredientList(Ingredient ingredient) {
    if (!ingredientsSelected.contains(ingredient)) {
      setState(() {
        ingredientsSelected.add(ingredient);
      });
    } else {
      setState(() {
        ingredientsSelected.removeWhere(
          (element) => element.id == ingredient.id,
        );
      });
    }
  }

  Future<void> _addIngredient() async {
    if (ingredientsSelected.isNotEmpty) {
      setLoading();
      List<int?> ingredientsId = ingredientsSelected.map((e) => e.id).toList();
      dynamic data = {
        "dish_id": widget.dish.id,
        "ingredients_id": ingredientsId,
      };
      dynamic token = await _session.get("token");
      await _api
          .post("api_admin/dish/dish_ingredient", data, token)
          .then((response) {
        if (response.status) {
          snackBarMessage(context, "Ingredients Added successfully");
          Navigator.pop(context, true);
          setState(() {
            ingredientsSelected = [];
          });
        } else {
          String error = ErrorManager.manager(response);
          snackBarMessage(context, error);
        }
      });
      setLoading();
    } else {
      snackBarMessage(context, "Please select at least one item from the list");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return DialogContainer(
        child: Stack(
      children: [
        SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints.expand(height: responsive.hp(67.1)),
            child: Container(
              padding: const EdgeInsets.only(
                right: 15,
                left: 15,
                top: 65,
                bottom: 20,
              ),
              margin: const EdgeInsets.only(top: 45),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: responsive.width,
                    height: responsive.hp(40),
                    child: ListIngredientsSimple(
                      responsive: responsive,
                      size: "md",
                      selectable: true,
                      ingredients: ingredients,
                      selected: ingredientsSelected,
                      setSelectable: (ingredient) {
                        addIngredientList(ingredient);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Button(
                      text: "Add Ingredient",
                      responsive: responsive,
                      icon: Icons.add,
                      onPressed: () => _addIngredient(),
                      isLoading: isLoading,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 1,
          right: 1,
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 45,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(45)),
                child: SvgPicture.asset("assets/icons/ingredients.svg"),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
