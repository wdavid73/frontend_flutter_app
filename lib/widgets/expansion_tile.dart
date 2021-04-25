import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/class/Order.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';

class CustomExpansionTile extends StatelessWidget {
  final Order order;

  const CustomExpansionTile({
    Key key,
    this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
        child: ExpansionTile(
          backgroundColor: MyColors.defaultPrimaryColor,
          collapsedBackgroundColor: MyColors.darkPrimaryColor,
          title: Text(
            "Order #${order.code} \nDate : ${order.date}",
            style: TextStyle(
                fontSize: responsive.dp(2),
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          children: <Widget>[
            ListTile(
              title: Text(
                "Total : \$ ${order.total}",
                style: TextStyle(
                    fontSize: responsive.dp(2),
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              subtitle: Text(
                "State : ${order.action == 1 ? "Delivery" : order.action == 2 ? "Cancelled" : "Pending"}",
                style: TextStyle(
                    fontSize: responsive.dp(2),
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            ListTile(
              // Table
              title: Text(
                "Table Ref : ${order.table.ref}",
                style: TextStyle(
                    fontSize: responsive.dp(2),
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* types of actions
* 1: "delivery", 2: "cancelled", 3: "pending"
* */
