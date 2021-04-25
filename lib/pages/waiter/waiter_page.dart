import 'package:fancy_bar/fancy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:my_restaurant_frontend_app/pages/waiter/list_order_page.dart';
import 'package:my_restaurant_frontend_app/pages/waiter/make_order_page.dart';
import 'package:my_restaurant_frontend_app/pages/waiter/search_order_page.dart';
import 'package:my_restaurant_frontend_app/services/services.dart';
import 'package:my_restaurant_frontend_app/utils/clearSession.dart';
import 'package:my_restaurant_frontend_app/utils/my_navigator.dart';
import 'package:my_restaurant_frontend_app/widgets/message_dialog.dart';
import 'package:my_restaurant_frontend_app/widgets/my_snack_bar.dart';
import 'package:ots/ots.dart';

class WaiterPageHome extends StatefulWidget {
  @override
  _WaiterPageHomeState createState() => _WaiterPageHomeState();
}

class _WaiterPageHomeState extends State<WaiterPageHome> {
  var _session = FlutterSession();
  RestClientServices _restClientServices = RestClientServices();
  PageController _pageController = PageController(initialPage: 0);

  _logout() async {
    Future.delayed(Duration(milliseconds: 300)).then(
      (value) => MessageDialog.dialogMessageWarningLogOut(
        context,
        "Logout",
        "Are you sure you want to log out?",
        "Yes",
        () async {
          dynamic token = await _session.get("token");
          showLoader(isModal: true);
          await _restClientServices
              .logout("dj-rest-auth/logout/", token)
              .then((response) {
            if (response.statusCode == 0) {
              clearSession();
              MyNavigator.goToHome(context);
            } else {
              print(response.message);
              hideLoader();
              mySnackBar(
                context,
                response.message.toString(),
              );
            }
          });
          hideLoader();
        },
      ),
    );
  }

  void optionSelected(int index) {
    setState(() {
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    //final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard Waiter"),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: _logout),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) {
          print("page changed to $index");
        },
        children: <Widget>[
          ListOrderPage(),
          MakeOrderPage(),
          SearchOrderPage(),
          anyPage(),
        ],
      ),
      bottomNavigationBar: FancyBottomBar(
        type: FancyType.FancyV2, // Fancy Bar Type
        items: [
          FancyItem(
            textColor: Colors.orange,
            title: 'List Order',
            icon: Icon(Icons.home),
          ),
          FancyItem(
            textColor: Colors.red,
            title: 'Make Order',
            icon: Icon(Icons.add),
          ),
          FancyItem(
            textColor: Colors.green,
            title: 'Search Order',
            icon: Icon(Icons.search),
          ),
          FancyItem(
            textColor: Colors.brown,
            title: 'Any',
            icon: Icon(Icons.circle),
          ),
        ],
        onItemSelected: (index) => optionSelected(index),
      ),
    );
  }

  Widget anyPage() {
    return Container(child: Text("Any Page"));
  }
}
