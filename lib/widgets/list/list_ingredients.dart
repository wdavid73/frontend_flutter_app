import 'package:flutter/material.dart';
import 'package:my_restaurant_app/class/ingredient.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/alerts/error_list.dart';
import 'package:my_restaurant_app/widgets/list/items/item_ingredient.dart';
import 'package:my_restaurant_app/widgets/shimmer/list_item.dart';
import 'package:shimmer/shimmer.dart';

class ListIngredients extends StatelessWidget {
  final bool reload;
  final Responsive responsive;
  final Color textColor;
  final Future<List<Ingredient>> getIngredients;
  final String size;
  final void Function()? refresh;

  const ListIngredients({
    Key? key,
    required this.responsive,
    required this.getIngredients,
    this.reload = false,
    this.textColor = Colors.black,
    this.size = "lg",
    this.refresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getIngredients,
      builder: (context, AsyncSnapshot<List<Ingredient>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return SizedBox(
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
        if (snapshot.hasError) {
          return ErrorList(
            message: "Error obtaining list of ingredients",
            responsive: responsive,
            color: Colors.white,
          );
        }
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView(
            children: List.generate(
              snapshot.data!.length,
              (index) {
                return ItemIngredient(
                  ingredient: snapshot.data![index],
                  length: snapshot.data!.length,
                );
              },
            ),
          );
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "No data",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: responsive.dp(4),
                  color: textColor,
                ),
              ),
              TextButton.icon(
                onPressed: refresh,
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
                label: const Text(
                  "Tap to reload",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
