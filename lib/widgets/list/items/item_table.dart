import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_restaurant_app/class/table.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/utils/utils.dart';

class ItemTable extends StatefulWidget {
  final TableApp table;
  final bool selectable;
  final List selected;
  final Responsive responsive;
  final void Function(dynamic state)? setSelectable;

   ItemTable({
    Key? key,
    required this.table,
    required this.responsive,
    this.selectable = false,
    this.setSelectable,
    this.selected = const <TableApp>[],
  }) : super(key: key);

  ValueNotifier select = ValueNotifier(false);

  @override
  State<ItemTable> createState() => _ItemTableState();
}

class _ItemTableState extends State<ItemTable> {
  bool select = false;

  setSelected(e) {
    widget.setSelectable!(e);
    select = Utils.checkSelected(e, widget.selected);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.selectable ? setSelected(widget.table) : null;
      },
      child: Card(
        color: select ? MyColors.accentColor : Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: select ? MyColors.accentColor : Colors.white,
          ),
        ),
        child: InkWell(
          child: ListTile(
            leading: CircleAvatar(
              child: SvgPicture.asset(
                'assets/icons/tabla.svg',
                width: widget.responsive.width * 0.8,
                height: widget.responsive.height * 0.8,
              ),
              backgroundColor: Colors.transparent,
            ),
            title: Text(
              'Table #${widget.table.id} $select',
              style: TextStyle(
                fontSize: widget.responsive.dp(2),
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: Text(
              'ref : ${widget.table.ref}',
              style: TextStyle(
                fontSize: widget.responsive.dp(1.5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
