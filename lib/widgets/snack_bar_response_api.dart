import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';

void snackBarResponseAPI(BuildContext context, Map<String, dynamic> json) {
  final Responsive responsive = Responsive(context);
  json.forEach((k, v) {
    if (v.length > 1) {
      v.forEach((item) {
        //   return ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: Row(
        //         children: [
        //           Padding(
        //             padding: const EdgeInsets.symmetric(horizontal: 5),
        //             child: Icon(
        //               Icons.info,
        //               color: Colors.white,
        //               size: responsive.dp(3),
        //             ),
        //           ),
        //           Text(
        //             "$item",
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontWeight: FontWeight.bold,
        //               fontSize: responsive.dp(2),
        //             ),
        //           ),
        //         ],
        //       ),
        //       backgroundColor: MyColors.darkPrimaryColor,
        //       duration: Duration(seconds: 3),
        //       behavior: SnackBarBehavior.floating,
        //     ),
        //   );
      });
    } else {
      // return ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Row(
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.symmetric(horizontal: 5),
      //           child: Icon(
      //             Icons.info,
      //             color: Colors.white,
      //             size: responsive.dp(3),
      //           ),
      //         ),
      //         Text(
      //           "${v[0]}",
      //           style: TextStyle(
      //             color: Colors.white,
      //             fontWeight: FontWeight.bold,
      //             fontSize: responsive.dp(2),
      //           ),
      //         ),
      //       ],
      //     ),
      //     backgroundColor: MyColors.darkPrimaryColor,
      //     duration: Duration(seconds: 3),
      //     behavior: SnackBarBehavior.floating,
      //   ),
      // );
    }
  });
}
