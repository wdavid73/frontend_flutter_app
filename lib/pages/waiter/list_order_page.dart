import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:my_restaurant_frontend_app/class/Order.dart';
import 'package:my_restaurant_frontend_app/services/services.dart';
import 'package:my_restaurant_frontend_app/utils/convertDataJson.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/widgets/expansion_tile.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListOrderPage extends StatefulWidget {
  @override
  _ListOrderPageState createState() => _ListOrderPageState();
}

class _ListOrderPageState extends State<ListOrderPage> {
  var _session = FlutterSession();
  List<Order> orders = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  RestClientServices _restClientServices = RestClientServices();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300));
    _init();
  }

  void _init() {
    super.initState();
    this._getOrders();
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    print(_refreshController.footerStatus);
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    this._getOrders();
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  Future<void> _getOrders() async {
    dynamic token = await _session.get("token");
    _restClientServices
        .getAuthorization("api_waiter/orders/", token)
        .then((response) {
      if (response.statusCode == 0) {
        print(response.data);
        setState(() {
          orders = parseOrder(response.data);
        });
      } else {
        print(response.message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return orders.length <= 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SmartRefresher(
            controller: _refreshController,
            enablePullUp: true,
            header: WaterDropHeader(
              waterDropColor: MyColors.darkPrimaryColor,
            ),
            onLoading: _onLoading,
            onRefresh: _onRefresh,
            child: ListView.builder(
              itemCount: orders.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CustomExpansionTile(
                  order: orders[index],
                );
              },
            ),
          );
  }
}
