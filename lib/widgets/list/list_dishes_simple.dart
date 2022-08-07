import 'package:flutter/material.dart';
import 'package:my_restaurant_app/class/dish.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/shimmer/grid_item.dart';
import 'package:shimmer/shimmer.dart';

import 'items/item_dish.dart';

class ListDishesSimple extends StatelessWidget {
  final Responsive responsive;
  final Color textColor;
  final bool selectable;
  final List selected;
  final List<Dish> dishes;
  final double ratio;
  final void Function(dynamic state)? setSelectable;
  final double? shimmerWidth;
  final double? shimmerHeight;
  const ListDishesSimple({
    Key? key,
    required this.responsive,
    required this.dishes,
    this.textColor = Colors.black,
    this.selectable = false,
    this.selected = const <Dish>[],
    this.setSelectable,
    this.ratio = 1.7,
    this.shimmerWidth = 500,
    this.shimmerHeight = 500,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double aspectRatio = (responsive.width / responsive.height) * ratio;
    return dishes.isNotEmpty
        ? GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            childAspectRatio: aspectRatio,
            children: List.generate(
              dishes.length,
              (index) {
                return ItemDish(
                  dish: dishes[index],
                  responsive: responsive,
                  selectable: selectable,
                  setSelectable: setSelectable,
                  selected: selected,
                );
              },
            ),
          )
        : SizedBox(
            width: shimmerWidth,
            height: shimmerHeight,
            child: Shimmer.fromColors(
              child: GridItemShimmer(
                ratio: ratio,
                responsive: responsive,
              ),
              baseColor: Colors.black26,
              highlightColor: Colors.black12,
            ),
          );
  }
}
