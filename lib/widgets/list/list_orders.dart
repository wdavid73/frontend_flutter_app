import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_restaurant_app/class/order.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/utils/snack_bar_message.dart';
import 'package:my_restaurant_app/widgets/alerts/error_list.dart';
import 'package:my_restaurant_app/widgets/shimmer/grid_item.dart';
import 'package:shimmer/shimmer.dart';

import '../card_flip.dart';
import '../icon_container.dart';
import '../no_data.dart';

class ListOrders extends StatelessWidget {
  final List<Order> orders;
  final Future<List<Order>> getOrders;
  final Responsive responsive;
  final Color textColor;

  const ListOrders({
    Key? key,
    required this.getOrders,
    required this.responsive,
    this.textColor = Colors.black,
    this.orders = const <Order>[],
  }) : super(key: key);

  copyCode(code, context) {
    Clipboard.setData(ClipboardData(text: code));
    snackBarMessage(context, "Code Copied!", color: MyColors.accentColor);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getOrders,
      builder: (context, AsyncSnapshot<List<Order>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return SizedBox(
            width: responsive.width,
            height: responsive.height,
            child: Shimmer.fromColors(
              child: GridItemShimmer(
                responsive: responsive,
              ),
              baseColor: Colors.black26,
              highlightColor: Colors.black12,
            ),
          );
        }
        if (snapshot.hasError) {
          return ErrorList(
            message: "Error obtaining list of orders",
            responsive: responsive,
          );
        }
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            children: List.generate(
              orders.length,
              (index) {
                return CardFlip(
                  front: _buildFront(
                    orders[index],
                    responsive,
                    Colors.redAccent,
                    context,
                  ),
                  back: _buildBack(
                    orders[index],
                    responsive,
                    MyColors.accentColor,
                  ),
                );
              },
            ),
          );
        }
        return NoData(
          responsive: responsive,
        );
      },
    );
  }

  Widget __buildLayout({
    Key? key,
    required Widget child,
    required Color backgroundColor,
  }) {
    return Card(
      key: key,
      elevation: 2,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: child,
      ),
    );
  }

  Widget _buildFront(
      Order order, Responsive responsive, Color color, BuildContext context) {
    return __buildLayout(
      key: const ValueKey(true),
      backgroundColor: color,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 0, left: 10),
              child: Text(
                "Table ${order.table.ref}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: IconContainer(
              color: Colors.transparent,
              shadow: false,
              size: responsive.dp(15),
              iconUrl: "food_tray.svg",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 0),
            child: Center(
              child: GestureDetector(
                onLongPress: () => copyCode(order.code, context),
                child: Text(
                  "Code : ${order.code}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: responsive.dp(1.6),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBack(Order order, Responsive responsive, Color color) {
    Map<int, String> actions = {
      1: "delivery",
      2: "cancelled",
      3: "pending",
    };
    return __buildLayout(
      key: const ValueKey(true),
      backgroundColor: color,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8, top: 5, bottom: 5),
                  child: Text(
                    "${actions.containsKey(order.action) ? actions[order.action] : 'no action'}"
                        .toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: responsive.dp(2),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: MyColors.myColors[order.action - 1],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                order.date,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: responsive.dp(2),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '\$ ${order.total}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: responsive.dp(2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
