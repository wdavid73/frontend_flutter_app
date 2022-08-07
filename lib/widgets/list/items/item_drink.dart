import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_restaurant_app/class/drink.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/utils/utils.dart';

class ItemDrink extends StatefulWidget {
  final Responsive responsive;
  final Drink drink;
  final bool selectable;
  final List selected;
  final void Function(dynamic state)? setSelectable;
  const ItemDrink({
    Key? key,
    required this.responsive,
    required this.drink,
    this.selectable = false,
    this.selected = const <Drink>[],
    this.setSelectable,
  }) : super(key: key);

  @override
  State<ItemDrink> createState() => _ItemDrinkState();
}

class _ItemDrinkState extends State<ItemDrink> {
  bool select = false;

  addSelect(e) {
    widget.setSelectable!(e);
    select = Utils.checkSelected(e, widget.selected);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => addSelect(widget.drink),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: select ? MyColors.accentColor : Colors.white,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CircleAvatar(
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: SvgPicture.asset(
                      'assets/icons/drink.svg',
                      width: widget.responsive.width * 0.5,
                      height: widget.responsive.height * 0.5,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  maxRadius: 25,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.drink.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: widget.responsive.dp(2),
                      color: select ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    '\$ ${widget.drink.price}',
                    style: TextStyle(
                      fontSize: widget.responsive.dp(1.5),
                      color: select ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
