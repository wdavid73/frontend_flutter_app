import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/class/Ingredient.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/utils/string_extension.dart';

class ItemIngredient extends StatefulWidget {
  final Ingredient ingredient;

  ItemIngredient({Key key, this.ingredient}) : super(key: key);

  @override
  _ItemIngredientState createState() => _ItemIngredientState();
}

class _ItemIngredientState extends State<ItemIngredient> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return ListTile(
      leading: CircleAvatar(
        child: Image.asset(
          'assets/icons/icon_ingredientes.png',
          scale: 0.1,
        ),
      ),
      title: Text(
        '${widget.ingredient.name}'.capitalizeEachWord(),
      ),
      subtitle: Text('${widget.ingredient.quantity} ${widget.ingredient.unit}'),
    );
  }
}
