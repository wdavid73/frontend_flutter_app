import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_restaurant_app/class/ingredient.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/utils/utils.dart';

class ItemIngredient extends StatefulWidget {
  final Ingredient ingredient;
  final int length;
  final bool selectable;
  final List selected;
  final void Function()? longPress;
  final void Function(dynamic state)? setSelectable;

  const ItemIngredient({
    Key? key,
    required this.ingredient,
    this.longPress,
    required this.length,
    this.selectable = false,
    this.selected = const <Ingredient>[],
    this.setSelectable,
  }) : super(key: key);

  @override
  State<ItemIngredient> createState() => _ItemIngredientState();
}

class _ItemIngredientState extends State<ItemIngredient> {
  bool select = false;

  addSelected(e) {
    widget.setSelectable!(e);
    select = Utils.checkSelected(e, widget.selected);
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return GestureDetector(
      onTap: () => addSelected(widget.ingredient),
      child: Card(
        color: select ? MyColors.accentColor : MyColors.defaultPrimaryColor,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: select ? MyColors.accentColor : MyColors.defaultPrimaryColor,
          ),
        ),
        child: InkWell(
          onLongPress: widget.longPress,
          child: formRow(responsive),
        ),
      ),
    );
  }

  Widget formRow(Responsive responsive) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: SvgPicture.asset(
              'assets/icons/icon_ingredientes.svg',
              semanticsLabel: "Ingredient icon",
              placeholderBuilder: (BuildContext context) => Container(
                padding: const EdgeInsets.all(30.0),
                child: const CircularProgressIndicator(
                  color: MyColors.accentColor,
                ),
              ),
            ),
          ),
        ),
      ),
      title: Text(
        widget.ingredient.name,
        style: TextStyle(
          fontSize: responsive.dp(2),
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        '${widget.ingredient.quantity} ${widget.ingredient.unit}',
        style: TextStyle(
          fontSize: responsive.dp(1.5),
          color: Colors.white,
        ),
      ),
    );
  }
}
