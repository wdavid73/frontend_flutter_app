import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/widgets/my_snack_bar.dart';

void snackBarResponseAPI(BuildContext context, Map<String, dynamic> json) {
  json.forEach(
    (k, v) {
      if (v.length > 1) {
        v.forEach(
          (item) {
            return mySnackBar(context, item);
          },
        );
      } else {
        mySnackBar(context, v[0].toString());
      }
    },
  );
}
