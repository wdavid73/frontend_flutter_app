import 'package:flutter/material.dart';
import 'package:my_restaurant_app/class/drink.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/list/items/item_drink.dart';
import 'package:my_restaurant_app/widgets/shimmer/list_item.dart';
import 'package:shimmer/shimmer.dart';


class ListDrinksSimple extends StatelessWidget {
  final bool reload;
  final Responsive responsive;
  final Color textColor;
  final String size;
  final bool selectable;
  final List selected;
  final List<Drink> drinks;
  final void Function(dynamic state)? setSelectable;
  final double? shimmerWidth;
  final double? shimmerHeight;

  const ListDrinksSimple({
    Key? key,
    required this.responsive,
    required this.drinks,
    this.reload = false,
    this.textColor = Colors.black,
    this.size = "lg",
    this.selectable = false,
    this.selected = const <Drink>[],
    this.setSelectable,
    this.shimmerWidth = 500,
    this.shimmerHeight = 500,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return drinks.isNotEmpty
        ? ListView.builder(
            itemCount: drinks.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ItemDrink(
                drink: drinks[index],
                selectable: selectable,
                selected: selected,
                setSelectable: setSelectable,
                responsive: responsive,
              );
            },
          )
        : SizedBox(
            width: shimmerWidth,
            height: shimmerHeight,
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
