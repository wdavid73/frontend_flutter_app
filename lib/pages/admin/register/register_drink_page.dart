import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:my_restaurant_app/class/drink.dart';
import 'package:my_restaurant_app/services/services.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/parse_data.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/dialogs/dialog_add_drink.dart';
import 'package:my_restaurant_app/widgets/list/list_drinks.dart';
import 'package:my_restaurant_app/widgets/screen/screen_options_admin.dart';

class RegisterDrinkPage extends StatefulWidget {
  const RegisterDrinkPage({Key? key}) : super(key: key);

  @override
  State<RegisterDrinkPage> createState() => _RegisterDrinkPageState();
}

class _RegisterDrinkPageState extends State<RegisterDrinkPage> {
  bool reloadList = false;
  bool enableFab = false;
  final ApiProvider _api = ApiProvider();
  final _session = SessionManager();

  Future<List<Drink>> _getDrinks() async {
    dynamic token = await _session.get("token");
    var response = await _api.get("api_admin/drink/", token);
    return parseDrinks(response.data);
  }

  Future<void> displayDialogAddDrink(BuildContext context) async {
    final result = await showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
            child: const SizedBox(
              width: 300,
              height: 200,
              child: DialogAddDrink(),
            ),
            onWillPop: () => Future.value(false),
          );
        });
    setState(() {
      reloadList = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return ScreenOptionsAdmin(
      title: "Drinks List",
      child: ListDrinks(
        getDrinks: _getDrinks(),
        responsive: responsive,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          displayDialogAddDrink(context);
        },
        child: const Icon(Icons.add),
        backgroundColor: MyColors.accentColor,
      ),
    );
  }
}
