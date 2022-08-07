import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:my_restaurant_app/class/dish.dart';
import 'package:my_restaurant_app/provider/loading_provider.dart';
import 'package:my_restaurant_app/services/services.dart';
import 'package:my_restaurant_app/utils/navigation/home.dart';
import 'package:my_restaurant_app/utils/snack_bar_message.dart';
import 'package:provider/provider.dart';

class Utils {
  static clearSession() async {
    var _session = SessionManager();
    await _session.set("token", '');
    await _session.set("username", "");
    await _session.set("email", "");
    await _session.set("full_name", "");
    await _session.set("position", "");
    await _session.set("restaurant_code", "");
  }

  static bool checkSelectedDish(dynamic item, List<Dish> list) {
    return list.contains(item);
  }

  static void logout(BuildContext context) async {
    var _session = SessionManager();
    ApiProvider _api = ApiProvider();
    context.read<LoadingProvider>().setLoad(true);
    dynamic token = await _session.get("token");
    await _api.post("api_auth/logout/", token).then((response) {
      if (response.status) {
        clearSession();
        NavigationHome.goToHome(context);
      } else {
        dynamic error = jsonDecode(response.message)["error"];
        snackBarMessage(context, error);
        if(response.httpCode == 400){
          clearSession();
          NavigationHome.goToHome(context);
        }
      }
    });
    context.read<LoadingProvider>().setLoad(false);
  }

  static void startTimer(int start) {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer timer) {
      if (start == 0) {
        timer.cancel();
      } else {
        start = start - 1;
      }
    });
  }

  static bool checkSelected(dynamic item, List list) {
    return list.contains(item);
  }

  static bool checkTableSelected(dynamic item, dynamic selected) {
    return item.id == selected.id;
  }

  static bool checkValidLogin(String? token) {
    return token != null;
  }
}
