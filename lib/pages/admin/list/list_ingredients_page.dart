import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:my_restaurant_app/class/ingredient.dart';
import 'package:my_restaurant_app/services/services.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/parse_data.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/dialogs/dialog_add_ingredient.dart';
import 'package:my_restaurant_app/widgets/list/list_ingredients.dart';
import 'package:my_restaurant_app/widgets/screen/screen_options_admin.dart';

class ListIngredientsPage extends StatefulWidget {
  const ListIngredientsPage({Key? key}) : super(key: key);

  @override
  _ListIngredientsPageState createState() => _ListIngredientsPageState();
}

class _ListIngredientsPageState extends State<ListIngredientsPage> {
  bool reloadList = false;
  final List<Ingredient> ingredients = [];
  final _session = SessionManager();
  final ApiProvider _api = ApiProvider();

  Future<List<Ingredient>> _getIngredients() async {
    dynamic token = await _session.get("token");
    var response = await _api.get("api_admin/ingredients/", token);
    return parseIngredients(response.data);
  }

  Future<void> displayDialogAddIngredient(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          child: const SizedBox(
            width: 200,
            height: 300,
            child: DialogAddIngredient(),
          ),
          onWillPop: () => Future.value(false),
        );
      },
    );
    setState(() {
      reloadList = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return ScreenOptionsAdmin(
      title: "List Ingredients",
      child: ListIngredients(
        responsive: responsive,
        getIngredients: _getIngredients(),
        reload: reloadList,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          displayDialogAddIngredient(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: MyColors.accentColor,
      ),
    );
  }
}
