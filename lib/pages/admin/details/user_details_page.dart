import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_restaurant_app/class/user.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/screen/screen_options_admin.dart';

class UserDetailsPage extends StatelessWidget {
  final User user;
  const UserDetailsPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    String background = user.position.name == "Chef"
        ? "assets/images/background-chef-h.jpg"
        : "assets/images/background-waiter-h.jpg";
    return ScreenOptionsAdmin(
      title: "User Detail",
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                height: responsive.hp(30),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(background),
                      fit: BoxFit.cover,
                    ),
                    color: MyColors.defaultPrimaryColor,
                  ),
                ),
              ),
              Positioned(
                bottom: -50.0,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: responsive.dp(10),
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
              ),
            ],
          ),
          const SizedBox(
            height: 45,
          ),
          ListTile(
            title: Center(
              child: Text("${user.firstName} ${user.lastName}".toUpperCase()),
            ),
            subtitle: Center(
              child: Text(user.position.name),
            ),
          ),
          ListTile(
            title: const Text('Phone'),
            subtitle: Text("+57 ${user.phone}"),
          ),
          ListTile(
            title: const Text('Email'),
            subtitle: Text(
              user.email,
            ),
          ),
          ListTile(
            title: const Text('Restaurant'),
            subtitle: Text(
              "Code: ${user.restaurant.code}\n"
              "Name: ${user.restaurant.name}\n"
              "Phone: ${user.restaurant.phone}\n"
              "Cellphone: ${user.restaurant.cellphone}\n"
              "Address: ${user.restaurant.address}",
            ),
          ),
        ],
      ),
    );
  }
}
