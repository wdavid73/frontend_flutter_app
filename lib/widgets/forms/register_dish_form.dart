import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:my_restaurant_app/class/dish_upload_image.dart';
import 'package:my_restaurant_app/services/services.dart';
import 'package:my_restaurant_app/utils/error_manager.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/utils/snack_bar_message.dart';
import 'package:my_restaurant_app/widgets/dropdown/custom_dropdown.dart';
import 'package:my_restaurant_app/widgets/image_picker/image_picker.dart';
import 'package:my_restaurant_app/widgets/input_custom.dart';
import 'package:my_restaurant_app/widgets/inputs/button_custom.dart';

class RegisterDishForm extends StatefulWidget {
  const RegisterDishForm({Key? key}) : super(key: key);

  @override
  _RegisterDishFormState createState() => _RegisterDishFormState();
}

class _RegisterDishFormState extends State<RegisterDishForm> {
  File? _image;
  bool _imageNull = false, isLoading = false, validateForm = false;
  String _name = '', _type = '', _price = '';
  final GlobalKey<FormState> _formKey = GlobalKey();
  final ApiProvider _api = ApiProvider();
  final _session = SessionManager();

  handlePickImage(file) {
    setState(() {
      if (file != null) {
        _image = file;
      } else {
        _imageNull = true;
      }
    });
  }

  setLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> createDish() async {
    var isOK = _formKey.currentState!.validate();
    if (_image == null) {
      snackBarMessage(context, "Please pick a image to dish");
    }
    if (isOK && _image != null) {
      setLoading();
      dynamic data = DishUploadImage(
        name: _name,
        price: double.parse(_price),
        type: _type,
        photo: _image,
      ).toJson();

      dynamic token = await _session.get("token");
      await _api
          .postImage("api_admin/dish/", data, _image!.path, token)
          .then((response) {
        if (response.status) {
          setState(() {
            _image = null;
          });
          snackBarMessage(context, "Dish created Successfully");
          FocusScope.of(context).unfocus();
          _formKey.currentState!.reset();
        } else {
          String error = ErrorManager.manager(response);
          snackBarMessage(context, error);
        }
      });
      setLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ImagePickerCustom(
              responsive: responsive,
              image: _image,
              imageNull: _imageNull,
              onFileChanged: (file) {
                handlePickImage(file);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: InputCustom(
              responsive: responsive,
              onChange: (text) => _name = text,
              hintText: "Name of Dish",
              labelText: "Name",
              validator: (text) {
                if (text!.isEmpty) {
                  return "Please enter a name of Dish";
                }
                return "";
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: CustomDropdown(
              options: const ["BreakFast", "Lunch", "Dinner"],
              hintText: "Select a type of Dish",
              labelText: "Type",
              responsive: responsive,
              inputWidth: responsive.wp(80),
              onChange: (text) => _type = text!,
              validator: (text) {
                if (text == null) {
                  return "Please select a type";
                }
                return "";
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            child: InputCustom(
              responsive: responsive,
              labelText: "Price",
              hintText: "Price of Dish",
              prefixText: "\$",
              keyboardType: TextInputType.number,
              onChange: (text) => _price = text,
              validator: (text) {
                if (text!.isEmpty) {
                  return "Please enter a price of Dish";
                }
                return "";
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Button(
              responsive: responsive,
              icon: Icons.restaurant,
              text: "Create Dish",
              isLoading: isLoading,
              onPressed: () => createDish(),
            ),
          )
        ],
      ),
    );
  }
}
