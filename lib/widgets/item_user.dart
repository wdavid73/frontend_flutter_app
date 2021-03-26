import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/class/User.dart';
import 'package:my_restaurant_frontend_app/utils/my_navigator.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/utils/string_extension.dart';

class ItemUser extends StatefulWidget {
  final FullUser user;

  ItemUser({Key key, this.user}) : super(key: key);

  @override
  _ItemUserState createState() => _ItemUserState();
}

class _ItemUserState extends State<ItemUser> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(
            "https://cdn4.iconfinder.com/data/icons/small-n-flat/24/user-alt-512.png"),
      ),
      title: Text(
        '${widget.user.firstName} ${widget.user.lastName}'.capitalizeEachWord(),
      ),
      subtitle: Text('${widget.user.email} - ${widget.user.phone}'),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        MyNavigator.goToUserDetails(context, widget.user);
      },
    );
  }
}
