import 'package:flutter/material.dart';
import 'package:my_restaurant_app/class/ingredient.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/shimmer/list_item.dart';
import 'package:shimmer/shimmer.dart';

import 'items/item_ingredient.dart';

class ListIngredientsSimple extends StatelessWidget {
  final bool reload;
  final Responsive responsive;
  final Color textColor;
  final String size;
  final bool selectable;
  final List selected;
  final List<Ingredient> ingredients;
  final void Function(dynamic state)? setSelectable;
  const ListIngredientsSimple({
    Key? key,
    required this.responsive,
    required this.ingredients,
    this.reload = false,
    this.textColor = Colors.black,
    this.size = "lg",
    this.selectable = false,
    this.selected = const <Ingredient>[],
    this.setSelectable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ingredients.isNotEmpty
        ? ListView.builder(
            itemCount: ingredients.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ItemIngredient(
                ingredient: ingredients[index],
                length: ingredients.length,
                selectable: selectable,
                selected: selected,
                setSelectable: setSelectable,
              );
            },
          )
        : SizedBox(
            width: responsive.width,
            height: responsive.height,
            child: Shimmer.fromColors(
              child: ListItemShimmer(
                responsive: responsive,
                size: size,
              ),
              baseColor: Colors.black26,
              highlightColor: Colors.black12,
            ),
          );
  }
}
