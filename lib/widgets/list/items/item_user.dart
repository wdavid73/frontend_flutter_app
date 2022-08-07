import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_restaurant_app/class/user.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/navigation/admin.dart';

class ItemUser extends StatefulWidget {
  final User user;
  const ItemUser({Key? key, required this.user}) : super(key: key);

  @override
  State<ItemUser> createState() => _ItemUserState();
}

class _ItemUserState extends State<ItemUser> {
  @override
  Widget build(BuildContext context) {
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
              "assets/icons/user_profile.svg",
              semanticsLabel: "User Profile Picture",
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
      title: Text("${widget.user.firstName} ${widget.user.lastName}"),
      subtitle: Text("${widget.user.email} - ${widget.user.phone}"),
      trailing: const Icon(Icons.keyboard_arrow_right_sharp),
      onTap: () {
        NavigationAdmin.goToUserDetails(context, widget.user);
      },
    );
  }
}
