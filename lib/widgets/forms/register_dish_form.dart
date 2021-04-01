import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_restaurant_frontend_app/class/Dish.dart';
import 'package:my_restaurant_frontend_app/services/services.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/utils/string_extension.dart';
import 'package:my_restaurant_frontend_app/widgets/custom_dropdowm_form.dart';
import 'package:my_restaurant_frontend_app/widgets/input_text.dart';
import 'package:ots/ots.dart';

import '../message_dialog.dart';

class FormRegisterDish extends StatefulWidget {
  @override
  _FormRegisterDishState createState() => _FormRegisterDishState();
}

class _FormRegisterDishState extends State<FormRegisterDish> {
  File _image;
  String _nameDish, _typeDish;
  double _priceDish;
  bool imageNull = false;
  GlobalKey<FormState> _formRegisterDish = GlobalKey();
  RestClientServices _restClientServices = RestClientServices();
  var _session = FlutterSession();
  final picker = ImagePicker();

  Future getImage() async {
    await picker.getImage(source: ImageSource.gallery).then((image) async {
      if (image != null) {
        setState(() {
          _image = File(image.path);
        });
      } else {
        setState(() {
          imageNull = true;
        });
        Fluttertoast.showToast(msg: "Image not Selected");
      }
    }).catchError((e) {
      print("Error ${e.toString()}");
    });
  }

  _submitDish() async {
    final isOK = _formRegisterDish.currentState.validate();
    if (_image == null) {
      setState(() {
        imageNull = true;
      });
      Fluttertoast.showToast(msg: "Please pick a image");
    }
    if (isOK && _image != null) {
      showLoader(isModal: true);
      dynamic token = await _session.get("token");
      dynamic data = DishUploadImage(
        name: _nameDish,
        type: _typeDish,
        price: _priceDish,
        photo: _image,
      ).toJson();

      await _restClientServices
          .postUploadImageGenericToken(
              "api_admin/dish/", data, token, _image.path)
          .then(
        (value) {
          if (value.statusCode == 0) {
            Fluttertoast.showToast(msg: "Dish registered successfully");
            _formRegisterDish.currentState.reset();
            FocusScope.of(context).unfocus();
            setState(() {
              _image = null;
            });
          } else {
            MessageDialog.dialogMessageWarning(
              context,
              "Warning",
              jsonDecode(value.message),
              "Ok",
            );
          }
        },
      );
      hideLoader();
    }
  }

  /* send image to api request
  * new UploadFileInfo(_image, basename(_image.path))
  * */

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Container(
      child: Form(
        key: _formRegisterDish,
        child: Column(
          children: [
            _image == null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => getImage(),
                      child: Container(
                        width: responsive.width * 0.5,
                        height: responsive.width * 0.5,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          border: imageNull
                              ? Border.all(
                                  color: Colors.redAccent,
                                  width: responsive.width * 0.01)
                              : null,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.photo_library,
                              color: Colors.white,
                              size: responsive.dp(5),
                            ),
                            Text(
                              "select a image".capitalizeEachWord(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: responsive.dp(2),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => getImage(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.file(
                          _image,
                          fit: BoxFit.cover,
                          width: responsive.width * 0.5,
                          height: responsive.width * 0.5,
                        ),
                      ),
                    ),
                  ),
            InputText(
              width: responsive.width * 0.8,
              formEnabled: true,
              label: "name dish",
              obscureText: true,
              onChanged: (text) => _nameDish = text,
              validator: (text) {
                if (text.trim().length <= 0 || text.isEmpty) {
                  return "invalid name".capitalizeEachWord();
                }
                return null;
              },
            ),
            CustomDropdownForm(
              options: ["BreakFast", "Lunch", "Dinner"],
              hintText: "select type of dinner",
              width: responsive.width * 0.8,
              onChanged: (text) => _typeDish = text,
              validator: (text) {
                if (text == null) {
                  return "enter a unit of ingredient".capitalizeFirstWord();
                }
                return null;
              },
            ),
            InputText(
              width: responsive.width * 0.8,
              formEnabled: true,
              label: "price dish",
              type: TextInputType.number,
              obscureText: true,
              withPrefix: true,
              onChanged: (text) => _priceDish = double.parse(text),
              validator: (text) {
                if (text.trim().length <= 0 || text.isEmpty) {
                  return "invalid price".capitalizeEachWord();
                }
                return null;
              },
            ),
            SizedBox(
              width: responsive.width * 0.8,
              child: ElevatedButton(
                onPressed: () => _submitDish(),
                child: Text("Register Dish"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      MyColors.darkPrimaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
