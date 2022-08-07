import 'package:flutter/material.dart';
import 'package:my_restaurant_app/class/dish.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/alerts/error_list.dart';
import 'package:my_restaurant_app/widgets/list/items/item_dish.dart';
import 'package:my_restaurant_app/widgets/shimmer/grid_item.dart';
import 'package:shimmer/shimmer.dart';

class ListDishes extends StatelessWidget {
  final bool reload;
  final Responsive responsive;
  final Future<List<Dish>> getDishes;
  const ListDishes({
    Key? key,
    this.reload = false,
    required this.responsive,
    required this.getDishes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getDishes,
      builder: (context, AsyncSnapshot<List<Dish>> snapshot) {
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
            message: "Error obtening list of dishes",
            responsive: responsive,
          );
        }
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: (responsive.width / responsive.height) * 1.7,
            children: List.generate(
              snapshot.data!.length,
              (index) {
                return ItemDish(
                  responsive: responsive,
                  dish: snapshot.data![index],
                );
              },
            ),
          );
        }
        return const Text("No data");
      },
    );
  }
  //const
}
