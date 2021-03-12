import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/class/User.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/utils/string_extension.dart';
import 'package:my_restaurant_frontend_app/utils/styles.dart';
import 'package:my_restaurant_frontend_app/widgets/card_item.dart';
import 'package:my_restaurant_frontend_app/widgets/screen_options_dashboard.dart';

class UserDetails extends StatefulWidget {
  final FullUser user;

  UserDetails({Key key, this.user}) : super(key: key);
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return ScreenOptionsDashboard(
      title: "details User",
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              color: Colors.white,
              height: responsive.height,
              width: responsive.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            maxRadius: responsive.dp(12),
                            backgroundImage: NetworkImage(
                                "https://cdn4.iconfinder.com/data/icons/small-n-flat/24/user-alt-512.png"),
                          ),
                        ),
                      ),
                      Text(
                        "${widget.user.firstName} ${widget.user.lastName}"
                            .capitalizeEachWord(),
                        style: textStyle(context, true, Colors.black),
                      ),
                      Text(
                        "+57 ${widget.user.phone}",
                        style: textStyle(context, false, Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: responsive.height * 0.5,
              width: responsive.width,
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: const Radius.circular(30),
                  topLeft: const Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  CardItem(
                    text: widget.user.email,
                    responsive: responsive,
                    color: Colors.indigoAccent,
                    title: "Email",
                  ),
                  CardItem(
                    text: widget.user.userName,
                    responsive: responsive,
                    color: Colors.indigoAccent,
                    title: "Username",
                  ),
                  CardItem(
                    text: widget.user.position.name,
                    responsive: responsive,
                    color: Colors.indigoAccent,
                    title: "Position",
                  ),
                  CardItem(
                    text: widget.user.restaurant.name,
                    responsive: responsive,
                    color: Colors.indigoAccent,
                    title: "Restaurant Name",
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
