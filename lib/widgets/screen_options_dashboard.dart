import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/utils/string_extension.dart';

class ScreenOptionsDashboard extends StatelessWidget {
  final String title;
  final Widget child, floatingActionButton;

  const ScreenOptionsDashboard({
    Key key,
    @required this.title,
    @required this.child,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.darkPrimaryColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          title.capitalizeEachWord(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: responsive.dp(2),
          ),
        ),
      ),
      body: child,
      floatingActionButton: floatingActionButton,
    );
  }
}
