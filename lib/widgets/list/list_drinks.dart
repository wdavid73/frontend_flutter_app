import 'package:flutter/material.dart';
import 'package:my_restaurant_app/class/drink.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/alerts/error_list.dart';
import 'package:my_restaurant_app/widgets/shimmer/list_item.dart';
import 'package:shimmer/shimmer.dart';

import 'items/item_drink.dart';

class ListDrinks extends StatelessWidget {
  final bool reload;
  final Responsive responsive;
  final Future<List<Drink>> getDrinks;
  const ListDrinks({
    Key? key,
    this.reload = false,
    required this.responsive,
    required this.getDrinks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getDrinks,
      builder: (context, AsyncSnapshot<List<Drink>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return SizedBox(
            width: responsive.width,
            height: responsive.height,
            child: Shimmer.fromColors(
              child: ListItemShimmer(
                responsive: responsive,
              ),
              baseColor: Colors.black26,
              highlightColor: Colors.black12,
            ),
          );
        }
        if (snapshot.hasError) {
          return ErrorList(
            message: "Error obtaining list of drinks",
            responsive: responsive,
          );
        }
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView(
            children: List.generate(
              snapshot.data!.length,
              (index) {
                return ItemDrink(
                  responsive: responsive,
                  drink: snapshot.data![index],
                );
              },
            ),
          );
        }
        return const Text("No data");
      },
    );
  }
}
