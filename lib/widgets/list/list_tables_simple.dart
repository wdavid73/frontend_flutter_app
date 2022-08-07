import 'package:flutter/material.dart';
import 'package:my_restaurant_app/class/table.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/list/items/item_table.dart';
import 'package:my_restaurant_app/widgets/shimmer/list_item.dart';
import 'package:shimmer/shimmer.dart';

class ListTableSimple extends StatelessWidget {
  final Responsive responsive;
  final bool selectable;
  final List selected;
  final List<TableApp> tables;
  final void Function(dynamic state)? setSelectable;

  const ListTableSimple({
    Key? key,
    required this.responsive,
    required this.tables,
    this.selectable = false,
    this.selected = const <TableApp>[],
    this.setSelectable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return tables.isNotEmpty
        ? ListView.builder(
            itemCount: tables.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ItemTable(
                table: tables[index],
                responsive: responsive,
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
              ),
              baseColor: Colors.black26,
              highlightColor: Colors.black12,
            ),
          );
  }
}
