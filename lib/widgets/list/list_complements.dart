import 'package:flutter/material.dart';
import 'package:my_restaurant_app/class/complement.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/alerts/error_list.dart';
import 'package:my_restaurant_app/widgets/list/items/item_complement.dart';
import 'package:my_restaurant_app/widgets/shimmer/list_item.dart';
import 'package:shimmer/shimmer.dart';

class ListComplements extends StatelessWidget {
  final bool reload;
  final Responsive responsive;
  final Future<List<Complement>> getComplements;

  const ListComplements({
    Key? key,
    required this.responsive,
    required this.getComplements,
    this.reload = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getComplements,
      builder: (context, AsyncSnapshot<List<Complement>> snapshot) {
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
            message: "Error obtaining list of complement",
            responsive: responsive,
          );
        }
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView(
            children: List.generate(
              snapshot.data!.length,
              (index) {
                return ItemComplement(
                  responsive: responsive,
                  complement: snapshot.data![index],
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
