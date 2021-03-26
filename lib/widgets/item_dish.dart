import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/class/Dish.dart';
import 'package:my_restaurant_frontend_app/utils/my_navigator.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';

class ItemDish extends StatefulWidget {
  final Dish dish;

  const ItemDish({Key key, this.dish}) : super(key: key);

  @override
  _ItemDishState createState() => _ItemDishState();
}

class _ItemDishState extends State<ItemDish> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return GestureDetector(
      onTap: () {
        MyNavigator.goToDishDetails(context, this.widget.dish);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => DishDetails()),
        // );
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(widget.dish.photo),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: '${widget.dish.name}',
                            style: TextStyle(
                              fontSize: responsive.dp(1.9),
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' (${widget.dish.type})',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  fontSize: responsive.dp(1.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "\$ ${widget.dish.price} ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: responsive.dp(2),
                          ),
                        ),
                      ],
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
