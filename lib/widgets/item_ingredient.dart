import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/class/Ingredient.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/utils/string_extension.dart';

class ItemIngredient extends StatelessWidget {
  final Ingredient ingredient;
  final void Function() longPress;

  const ItemIngredient({
    Key key,
    this.ingredient,
    this.longPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Container(
      child: Card(
        color: MyColors.defaultPrimaryColor,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: new InkWell(
          onLongPress: this.longPress,
          child: ListTile(
            leading: CircleAvatar(
              child: Image.asset(
                'assets/icons/icon_ingredientes.png',
                scale: 0.1,
              ),
            ),
            title: Text(
              '${ingredient.name}'.capitalizeEachWord(),
              style: TextStyle(
                fontSize: responsive.dp(2),
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: Text(
              '${ingredient.quantity} ${ingredient.unit}',
              style: TextStyle(
                fontSize: responsive.dp(1.5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
