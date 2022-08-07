import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:my_restaurant_app/class/order.dart';
import 'package:my_restaurant_app/services/services.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/parse_data.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/input_custom.dart';
import 'package:my_restaurant_app/widgets/list/list_orders.dart';
import 'package:my_restaurant_app/widgets/title_app_bar.dart';

class ListOrdersPage extends StatefulWidget {
  const ListOrdersPage({Key? key}) : super(key: key);

  @override
  State<ListOrdersPage> createState() => _ListOrdersPageState();
}

class _ListOrdersPageState extends State<ListOrdersPage> {
  bool loading = false;
  final _session = SessionManager();
  final ApiProvider _api = ApiProvider();
  List<Order> orders = <Order>[];
  List<Order> searchList = <Order>[];
  dynamic _future;

  @override
  void initState() {
    super.initState();
    _future = _getOrders();
  }

  setLoading() {
    setState(() {
      loading = false;
    });
  }

  Future<List<Order>> _getOrders() async {
    dynamic token = await _session.get("token");
    dynamic response = await _api.get("api_waiter/orders/all/", token);
    dynamic data = parseOrders(response.data);
    setState(() {
      orders = data;
      searchList = data;
    });
    return data;
  }

  void filtersSearchResults(String query) {
    if (query.isNotEmpty) {
      List<Order> listData = [];
      for (var element in orders) {
        if (element.code.contains(query.toUpperCase())) {
          listData.add(element);
        }
      }
      setState(() => searchList = listData);
    } else {
      setState(() {
        searchList = orders;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: MyColors.darkPrimaryColor,
        title: const TitleAppBar(
          text: 'List Order',
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: responsive.width,
          height: responsive.height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InputCustom(
                  inputWidth: responsive.wp(95),
                  responsive: responsive,
                  labelText: "Filter",
                  hintText: "Filter List",
                  onChange: (text) {
                    filtersSearchResults(text);
                  },
                ),
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: responsive.hp(78.5),
                  child: ListOrders(
                    responsive: responsive,
                    getOrders: _future,
                    orders: searchList,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
