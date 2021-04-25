import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';

class MessageDialog {
  static Future<void> dialogMessageSuccessRestaurant(BuildContext context,
      String code, String title, String desc, String okText) async {
    final Responsive responsive = Responsive(context);
    return AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        title: title,
        desc: desc + code,
        btnOkText: okText,
        btnOkOnPress: () {
          debugPrint('OnClcik');
          Clipboard.setData(new ClipboardData(text: code));
          Fluttertoast.showToast(
            msg: "Code Copied!",
            fontSize: responsive.dp(2),
            backgroundColor: MyColors.darkPrimaryColor,
          );
        },
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: () {
          debugPrint('Dialog Dissmiss from callback');
        })
      ..show();
  }

  static Future<void> dialogMessageSuccess(
      BuildContext context, String title, String desc, String okText) async {
    return AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        title: title,
        desc: desc,
        btnOkText: okText,
        btnOkOnPress: () {
          debugPrint('OnClick');
        },
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: () {
          debugPrint('Dialog Dissmiss from callback');
        })
      ..show();
  }

  static Future<void> dialogMessageError(
      BuildContext context, String title, String desc, String okText) async {
    return AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.ERROR,
        title: title,
        desc: desc,
        btnOkText: okText,
        btnOkOnPress: () {
          debugPrint('OnClick');
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: MyColors.darkPrimaryColor,
        onDissmissCallback: () {
          debugPrint('Dialog Dissmiss from callback');
        })
      ..show();
  }

  static Future<void> dialogMessageInfo(
      BuildContext context, String title, String desc, String okText) async {
    return AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.INFO,
        title: title,
        desc: desc,
        btnOkText: okText,
        btnOkOnPress: () {
          debugPrint('OnClick');
        },
        btnOkIcon: Icons.info,
        btnOkColor: Colors.blue,
        onDissmissCallback: () {
          debugPrint('Dialog Dissmiss from callback');
        })
      ..show();
  }

  static Future<void> dialogMessageWarning(
      BuildContext context, String title, String desc, String okText) async {
    return AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.WARNING,
        title: title,
        desc: desc,
        btnOkText: okText,
        btnOkOnPress: () {
          debugPrint('OnClick');
        },
        btnOkIcon: Icons.warning,
        btnOkColor: MyColors.warningColor,
        onDissmissCallback: () {
          debugPrint('Dialog Dissmiss from callback');
        })
      ..show();
  }

  static Future<void> dialogMessageQuestion(
      BuildContext context, String title, String desc, String okText) async {
    return AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.QUESTION,
        title: title,
        desc: desc,
        btnOkText: okText,
        btnOkOnPress: () {
          debugPrint('OnClick');
        },
        btnOkIcon: Icons.question_answer,
        btnOkColor: Colors.deepOrange,
        onDissmissCallback: () {
          debugPrint('Dialog Dissmiss from callback');
        })
      ..show();
  }

  static Future<void> dialogMessageWarningLogOut(BuildContext context,
      String title, String desc, String okText, Function okPressed) async {
    return AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      headerAnimationLoop: false,
      dialogType: DialogType.WARNING,
      title: title,
      desc: desc,
      btnOkText: okText,
      btnOkOnPress: okPressed,
      btnOkIcon: Icons.warning,
      btnOkColor: MyColors.warningColor,
    )..show();
  }
}
