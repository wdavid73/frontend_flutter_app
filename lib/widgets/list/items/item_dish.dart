import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:my_restaurant_app/class/dish.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/navigation/admin.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/utils/utils.dart';

class ItemDish extends StatefulWidget {
  final Dish dish;
  final bool selectable;
  final List selected;
  final Responsive responsive;
  final void Function(dynamic state)? setSelectable;

  const ItemDish({
    Key? key,
    required this.dish,
    required this.responsive,
    this.selectable = false,
    this.selected = const <Dish>[],
    this.setSelectable,
  }) : super(key: key);

  @override
  _ItemDishState createState() => _ItemDishState();
}

class _ItemDishState extends State<ItemDish> {
  bool select = false;

  addSelected(e) {
    widget.setSelectable!(e);
    select = Utils.checkSelected(e, widget.selected);
    /*widget.setSelectable!(e);
    List<Dish>? list = widget.selected! ?? [];
    selected = Utils.checkSelectedDish(e, list!);*/
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        !widget.selectable
            ? NavigationAdmin.goToDishDetails(context, widget.dish)
            : addSelected(widget.dish);
      },
      child: SizedBox(
        height: widget.responsive.hp(30),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: select ? MyColors.accentColor : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(
                color: select ? MyColors.accentColor : Colors.white,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 6,
                  child: ExtendedImage.network(
                    widget.dish.photo,
                    width: widget.responsive.wp(55),
                    fit: BoxFit.fill,
                    cache: true,
                    border: Border.all(color: Colors.white, width: 1.0),
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    loadStateChanged: (ExtendedImageState state) {
                      switch (state.extendedImageLoadState) {
                        case LoadState.failed:
                          return GestureDetector(
                            child: Stack(
                              children: <Widget>[
                                Center(
                                  child: Image.asset(
                                    "assets/images/failed.png",
                                    height: widget.responsive.hp(20),
                                    width: widget.responsive.wp(20),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0.0,
                                  left: 0.0,
                                  right: 0.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      "load image failed, click to reload",
                                      style: TextStyle(
                                        fontSize: widget.responsive.dp(1.3),
                                        fontWeight: FontWeight.bold,
                                        color: MyColors.accentColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            onTap: () {
                              state.reLoadImage();
                            },
                          );
                        case LoadState.loading:
                          return null;
                        case LoadState.completed:
                          return null;
                      }
                    },
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              text: widget.dish.name,
                              style: TextStyle(
                                fontSize: widget.responsive.dp(1.9),
                                color: select ? Colors.white : Colors.black,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' (${widget.dish.type})',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: select ? Colors.white : Colors.green,
                                    fontSize: widget.responsive.dp(1.6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "\$ ${widget.dish.price} ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: widget.responsive.dp(2),
                              color: select ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
