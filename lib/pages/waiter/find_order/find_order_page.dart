import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:my_restaurant_app/class/dish.dart';
import 'package:my_restaurant_app/class/order.dart';
import 'package:my_restaurant_app/class/table.dart';
import 'package:my_restaurant_app/services/services.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/parse_data.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/empty.dart';
import 'package:my_restaurant_app/widgets/input_custom.dart';
import 'package:my_restaurant_app/widgets/list/list_dishes_simple.dart';
import 'package:my_restaurant_app/widgets/list/list_drinks_simple.dart';
import 'package:my_restaurant_app/widgets/title_app_bar.dart';

import '../../../class/drink.dart';
import '../../../widgets/button_tap.dart';

class FindOrderPage extends StatefulWidget {
  const FindOrderPage({Key? key}) : super(key: key);

  @override
  State<FindOrderPage> createState() => _FindOrderPageState();
}

class _FindOrderPageState extends State<FindOrderPage> {
  String codeOrder = '';
  bool loadingButton = false;
  Order order =
      Order(code: "", date: "", total: 0, action: 0, table: TableApp(ref: ""));
  List<Drink> drinks = <Drink>[];
  List<Dish> dishes = <Dish>[];
  final GlobalKey<FormState> _formKey = GlobalKey();
  final ApiProvider _api = ApiProvider();
  final _session = SessionManager();

  setLoading() {
    setState(() => loadingButton = !loadingButton);
  }

  findOrder() async {
    final isOk = _formKey.currentState!.validate();
    if (isOk) {
      dynamic token = await _session.get("token");
      var response =
          await _api.get('api_waiter/orders/find_order/$codeOrder', token);
      setState(() {
        order = parseOrder(response.data);
        dishes = parseDishes(response.data, key: 'dishes');
        drinks = parseDrinks(response.data, key: 'drinks');
      });
    }
  }

  actionOrder(int action) async {
    dynamic token = await _session.get('token');
    var response = await _api.post(
        'api_waiter/orders/action/${order.code}/$action/', null, token);
    print(response.data);
    setState(() {
      order = parseOrder(response.data, key: 'data');
    });
  }

  void unFocus() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: MyColors.darkPrimaryColor,
          title: const TitleAppBar(
            text: 'Find Order',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    verticalDirection: VerticalDirection.up,
                    children: [
                      InputCustom(
                        responsive: responsive,
                        inputWidth: responsive.dp(25),
                        labelText: "Code",
                        hintText: "Code",
                        onChange: (text) {
                          codeOrder = text;
                        },
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Please code of a order";
                          }
                          return null;
                        },
                      ),
                      ButtonTap(
                        text: "Find",
                        width: responsive.wp(25),
                        onPressed: () => findOrder(),
                        isLoading: loadingButton,
                      ),
                    ],
                  ),
                ),
              ),
              OrderInformation(order: order),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      "Dishes",
                      style: TextStyle(
                        fontSize: responsive.dp(2),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    dishes.isNotEmpty
                        ? ListDishesSimple(
                            responsive: responsive,
                            dishes: dishes,
                            shimmerHeight: 200,
                          )
                        : Empty(
                            responsive: responsive,
                            text: "Without Dishes Yet",
                          ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      "Drinks",
                      style: TextStyle(
                        fontSize: responsive.dp(2),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    drinks.isNotEmpty
                        ? ListDrinksSimple(
                            responsive: responsive,
                            drinks: drinks,
                            shimmerHeight: 200,
                          )
                        : Empty(
                            responsive: responsive,
                            text: "Without Drinks Yet",
                          ),
                  ],
                ),
              ),
              order.code != ''
                  ? order.action != 2
                      ? order.action != 3
                          ? order.action != 4
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ButtonTap(
                                              text: "Delivered",
                                              onPressed: () => actionOrder(3),
                                              width: responsive.wp(40),
                                              height: responsive.hp(5.5),
                                              withShadow: true,
                                              textBold: true,
                                              fillColor: MyColors.successColor,
                                            ),
                                            ButtonTap(
                                              text: "Cancelled",
                                              onPressed: () => actionOrder(2),
                                              width: responsive.wp(40),
                                              height: responsive.hp(5.5),
                                              withShadow: true,
                                              textBold: true,
                                              fillColor:
                                                  MyColors.darkPrimaryColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ButtonTap(
                                          text: "Edit",
                                          onPressed: () {},
                                          width: responsive.wp(80),
                                          height: responsive.hp(5.5),
                                          withShadow: true,
                                          textBold: true,
                                          icon: Icons.edit,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    width: responsive.wp(50),
                                    height: responsive.hp(5),
                                    decoration: BoxDecoration(
                                      color: MyColors.successColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Order Padded",
                                          style: TextStyle(
                                            fontSize: responsive.dp(1.6),
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                          : Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ButtonTap(
                                      text: "Paid",
                                      onPressed: () => actionOrder(4),
                                      width: responsive.wp(80),
                                      height: responsive.hp(5.5),
                                      withShadow: true,
                                      textBold: true,
                                      icon: Icons.paid,
                                      fillColor: MyColors.darkPrimaryColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ButtonTap(
                                      text: "Edit",
                                      onPressed: () {},
                                      width: responsive.wp(80),
                                      height: responsive.hp(5.5),
                                      withShadow: true,
                                      textBold: true,
                                      icon: Icons.edit,
                                    ),
                                  ),
                                ],
                              ),
                            )
                      : Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            width: responsive.wp(50),
                            height: responsive.hp(5),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Order Cancelled",
                                  style: TextStyle(
                                    fontSize: responsive.dp(1.6),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderInformation extends StatelessWidget {
  final Order? order;
  const OrderInformation({Key? key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Date : ${order!.date}",
              style: TextStyle(
                fontSize: responsive.dp(1.5),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Table : ${order!.table.ref}",
              style: TextStyle(
                fontSize: responsive.dp(1.5),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Total : \$${order!.total}",
              style: TextStyle(
                fontSize: responsive.dp(1.5),
                fontWeight: FontWeight.bold,
              ),
            ),
            StateOrder(responsive: responsive, order: order),
          ],
        ),
      ],
    );
  }
}

class StateOrder extends StatelessWidget {
  const StateOrder({
    Key? key,
    required this.responsive,
    required this.order,
  }) : super(key: key);

  final Responsive responsive;
  final Order? order;

  @override
  Widget build(BuildContext context) {
    Map<int, String> actions = {
      1: "pending",
      2: "cancelled",
      3: "delivery",
      4: "padded",
    };
    Map<int, Color> actionsColors = {
      1: MyColors.warningColor,
      2: MyColors.darkPrimaryColor,
      3: MyColors.successColor,
      5: MyColors.accentColor
    };
    return Container(
      width: responsive.wp(50),
      decoration: BoxDecoration(
        color: actionsColors.containsKey(order!.action)
            ? actionsColors[order!.action]
            : MyColors.accentColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Center(
          child: Text(
            "Status : ${actions.containsKey(order!.action) ? actions[order!.action] : 'no action'}"
                .toUpperCase(),
            style: TextStyle(
              fontSize: responsive.dp(1.5),
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
