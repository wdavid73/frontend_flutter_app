import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:my_restaurant_app/utils/error_manager.dart';
import 'package:my_restaurant_app/utils/navigation/waiter.dart';
import 'package:my_restaurant_app/utils/snack_bar_message.dart';

import '../../../class/dish.dart';
import '../../../class/drink.dart';
import '../../../class/table.dart';
import '../../../services/services.dart';
import '../../../utils/parse_data.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/dropdown/custom_dropdown.dart';
import '../../../widgets/list/list_dishes_simple.dart';
import '../../../widgets/list/list_drinks_simple.dart';
import './steps/stepper_order.dart';

class MakeOrderForm extends StatefulWidget {
  const MakeOrderForm({Key? key}) : super(key: key);

  @override
  State<MakeOrderForm> createState() => _MakeOrderFormState();
}

class _MakeOrderFormState extends State<MakeOrderForm> {
  int _currentStep = 0;
  bool valid = false;

  late int _tableId;
  List<TableApp> tables = [];
  List<TableApp> tableSelected = [];
  List<Dish> dishes = [];
  List<Dish> dishesSelected = [];
  List<Drink> drinks = [];
  List<Drink> drinksSelected = [];
  bool loading = false;

  final ApiProvider _api = ApiProvider();
  final _session = SessionManager();
  final GlobalKey<FormState> _formKeyTable = GlobalKey();

  @override
  void initState() {
    super.initState();
    _getTables();
  }

  Future<void> _getTables() async {
    dynamic token = await _session.get("token");
    var response = await _api.get(
      "api_admin/tables/tables_by_restaurant",
      token,
    );
    if (response.status) {
      setState(() => tables = parseTables(response.data));
    } else {
      String error = ErrorManager.manager(response);
      snackBarMessage(context, error);
    }
  }

  Future<void> _getDishes() async {
    dynamic token = await _session.get("token");
    var response = await _api.get("api_admin/dish/", token);
    if (response.status) {
      setState(() => dishes = parseDishes(response.data));
    } else {
      String error = ErrorManager.manager(response);
      snackBarMessage(context, error);
    }
  }

  Future<void> _getDrinks() async {
    dynamic token = await _session.get("token");
    var response = await _api.get("api_admin/drink/", token);
    if (response.status) {
      setState(() => drinks = parseDrinks(response.data));
    } else {
      String error = ErrorManager.manager(response);
      snackBarMessage(context, error);
    }
  }

  void addDishList(Dish dish) {
    !dishesSelected.contains(dish)
        ? setState(() => dishesSelected.add(dish))
        : setState(() =>
            dishesSelected.removeWhere((element) => element.id == dish.id));
  }

  void addDrinkList(Drink drink) {
    !drinksSelected.contains(drink)
        ? setState(() => drinksSelected.add(drink))
        : setState(() =>
            drinksSelected.removeWhere((element) => element.id == drink.id));
  }

  void nextStep() {
    switch (_currentStep) {
      case 0:
        final isOk = _formKeyTable.currentState!.validate();
        if (isOk) {
          setState(() {
            _currentStep += 1;
          });
          _getDishes();
        }
        return;
      case 1:
        if (dishesSelected.isNotEmpty) {
          setState(() {
            _currentStep += 1;
          });
          _getDrinks();
        } else {
          snackBarMessage(context, "Please select at least one dish");
        }
        return;
      case 2:
        if (drinksSelected.isNotEmpty) {
          setState(() {
            _currentStep += 1;
          });
        } else {
          snackBarMessage(context, "Please select at least one drink");
        }
        return;
    }
  }

  void backStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  setLoading() {
    setState(() => loading = !loading);
  }

  void finalStep() async {
    setLoading();

    Map<String, dynamic> data = {
      "table_id": _tableId,
      "dishes_selected": dishesSelected,
      "drinks_selected": drinksSelected,
    };

    dynamic token = await _session.get("token");
    await _api.post("api_waiter/orders/", data, token).then((response) {
      if (response.status) {
        snackBarMessage(context, "Order Create Successfully");
        setState(() {
          dishesSelected = [];
          drinksSelected = [];
        });
        FocusScope.of(context).unfocus();
        NavigationWaiter.goToWaiterPage(context);
      } else {
        String error = ErrorManager.manager(response);
        snackBarMessage(context, error);
      }
    });
    setLoading();
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    return SizedBox(
      width: responsive.width,
      height: responsive.height,
      child: Column(
        children: [
          StepperOrder(
            currentStep: _currentStep,
            onNextStep: nextStep,
            onBackStep: backStep,
            onFinalStep: finalStep,
            loading: loading,
            steps: [
              Step(
                title: const Text("Select a Table"),
                content: SizedBox(
                  height: responsive.hp(11.5),
                  child: Form(
                    key: _formKeyTable,
                    child: CustomDropdown(
                      inputWidth: responsive.wp(95),
                      options: tables,
                      hintText: "Select a Table",
                      labelText: "Select Table",
                      responsive: responsive,
                      onChange: (value) {
                        _tableId = value!;
                      },
                      validator: (text) {
                        if (text == null) {
                          return "Please select a table";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                isActive: _currentStep == 0,
                state:
                    _currentStep >= 0 ? StepState.complete : StepState.disabled,
              ),
              Step(
                title: const Text("Select one or more dishes"),
                content: SizedBox(
                  height: responsive.hp(45),
                  width: responsive.width,
                  child: ListDishesSimple(
                    responsive: responsive,
                    dishes: dishes,
                    selectable: true,
                    selected: dishesSelected,
                    ratio: 1.4,
                    setSelectable: (dish) {
                      addDishList(dish);
                    },
                  ),
                ),
                isActive: _currentStep == 1,
                state:
                    _currentStep >= 1 ? StepState.complete : StepState.disabled,
              ),
              Step(
                title: const Text("Select one or more drinks"),
                content: SizedBox(
                  width: responsive.width,
                  height: responsive.hp(25),
                  child: ListDrinksSimple(
                    responsive: responsive,
                    drinks: drinks,
                    selectable: true,
                    selected: drinksSelected,
                    setSelectable: (drink) {
                      addDrinkList(drink);
                    },
                  ),
                ),
                isActive: _currentStep == 2,
                state:
                    _currentStep >= 2 ? StepState.complete : StepState.disabled,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
