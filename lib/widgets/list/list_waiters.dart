import 'package:flutter/material.dart';
import 'package:my_restaurant_app/class/user.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/list/items/item_user.dart';
import 'package:my_restaurant_app/widgets/shimmer/list_item.dart';
import 'package:shimmer/shimmer.dart';

class ListUsers extends StatelessWidget {
  final Responsive responsive;
  final Future<List<User>> getUsers;
  const ListUsers({
    Key? key,
    required this.responsive,
    required this.getUsers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUsers,
      builder: (context, AsyncSnapshot<List<User>> snapshot) {
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
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
              ),
              Text(
                "Error obtaining the list of users",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: responsive.dp(2),
                ),
              ),
            ],
          );
        }
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView(
            children: List.generate(snapshot.data!.length, (index) {
              return ItemUser(user: snapshot.data![index]);
            }),
          );
        }
        return const Text("No data");
      },
    );
  }
}
