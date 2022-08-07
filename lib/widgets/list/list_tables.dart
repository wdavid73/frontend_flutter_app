import 'package:flutter/material.dart';
import 'package:my_restaurant_app/class/table.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/alerts/error_list.dart';
import 'package:my_restaurant_app/widgets/shimmer/list_item.dart';
import 'package:shimmer/shimmer.dart';

import 'items/item_table.dart';

class ListTables extends StatefulWidget {
  final bool reload;
  final Responsive responsive;
  final Future<List<TableApp>> getTables;
  final bool selectable;
  final List selected;
  final void Function(dynamic state)? setSelectable;
  const ListTables({
    Key? key,
    this.reload = false,
    required this.responsive,
    required this.getTables,
    this.selectable = false,
    this.setSelectable,
    this.selected = const <TableApp>[],
  }) : super(key: key);

  @override
  State<ListTables> createState() => _ListTablesState();
}

class _ListTablesState extends State<ListTables> {

  late Future<List<TableApp>> tables;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: tables,
      builder: (context, AsyncSnapshot<List<TableApp>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return SizedBox(
            width: widget.responsive.width,
            height: widget.responsive.height,
            child: Shimmer.fromColors(
              child: ListItemShimmer(
                responsive: widget.responsive,
              ),
              baseColor: Colors.black26,
              highlightColor: Colors.black12,
            ),
          );
        }
        if (snapshot.hasError) {
          return ErrorList(
            message: "Error obtaining list of tables",
            responsive: widget.responsive,
          );
        }
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView(
            children: List.generate(
              snapshot.data!.length,
              (index) {
                return ItemTable(
                  responsive: widget.responsive,
                  table: snapshot.data![index],
                  selectable: widget.selectable,
                  selected: widget.selected,
                  setSelectable: widget.setSelectable,
                );
              },
            ),
          );
        }
        return const Text("No data");
      },
    );
  }

  @override
  void initState() {
    super.initState();
    tables = widget.getTables;
  }
}
