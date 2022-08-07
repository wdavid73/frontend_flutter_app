import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_restaurant_app/class/complement.dart';
import 'package:my_restaurant_app/utils/responsive.dart';

class ItemComplement extends StatelessWidget {
  final Complement complement;
  final Responsive responsive;
  const ItemComplement({
    Key? key,
    required this.responsive,
    required this.complement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        child: ListTile(
          leading: CircleAvatar(
            child: SvgPicture.asset(
              "assets/icons/icon_ingredientes.svg",
              width: responsive.width * 0.8,
              height: responsive.height * 0.8,
            ),
            backgroundColor: Colors.white,
          ),
          title: Text(
            "Complement - ${complement.name}",
            style: TextStyle(
              fontSize: responsive.dp(1.5),
            ),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "price : \$ ${complement.price}",
                style: TextStyle(
                  fontSize: responsive.dp(1.5),
                ),
              ),
              Text(
                "quantity : \$ ${complement.quantity} ${complement.unit}",
                style: TextStyle(
                  fontSize: responsive.dp(1.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
