import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_restaurant_app/class/ingredient.dart';
import 'package:my_restaurant_app/services/services.dart';
import 'package:my_restaurant_app/utils/error_manager.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/utils/snack_bar_message.dart';
import 'package:my_restaurant_app/widgets/dialogs/dialog_container.dart';
import 'package:my_restaurant_app/widgets/dropdown/custom_dropdown.dart';
import 'package:my_restaurant_app/widgets/inputs/button_custom.dart';
import 'package:my_restaurant_app/widgets/inputs/numeric_step_button.dart';

import '../input_custom.dart';

class DialogAddIngredient extends StatefulWidget {
  const DialogAddIngredient({Key? key}) : super(key: key);

  @override
  _DialogAddIngredientState createState() => _DialogAddIngredientState();
}

class _DialogAddIngredientState extends State<DialogAddIngredient> {
  String _unit = '', _name = '';
  int _quantity = 0;
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final ApiProvider _api = ApiProvider();
  final _session = SessionManager();

  setLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> _createIngredient() async {
    var isOk = _formKey.currentState!.validate();
    if (_quantity > 0) {
      if (isOk) {
        setLoading();
        dynamic data = Ingredient(
          name: _name,
          unit: _unit,
          quantity: _quantity.toString(),
        ).toJson();
        dynamic token = await _session.get("token");
        await _api.post("api_admin/ingredients/", data, token).then((response) {
          if (response.status) {
            snackBarMessage(context, "Ingredient created successfully");
            _formKey.currentState!.reset();
            Navigator.pop(context, true);
          } else {
            String error = ErrorManager.manager(response);
            snackBarMessage(context, error);
          }
        });
        setLoading();
      }
    } else {
      Fluttertoast.showToast(
        msg: "Please input a quantity of ingredient",
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        backgroundColor: MyColors.accentColor,
        fontSize: 12,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return DialogContainer(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(height: responsive.hp(60.6)),
              child: Container(
                padding: const EdgeInsets.only(
                  right: 15,
                  left: 15,
                  top: 65,
                  bottom: 20,
                ),
                margin: const EdgeInsets.only(top: 45),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      child: Text(
                        "Add Ingredient to this Dish",
                        style: TextStyle(
                          fontSize: responsive.dp(2.3),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      alignment: Alignment.centerRight,
                    ),
                    SizedBox(height: responsive.hp(3)),
                    Align(
                      child: SizedBox(
                        width: responsive.wp(60),
                        child: Text(
                          "You want to add a new ingredient",
                          style: TextStyle(
                            fontSize: responsive.dp(1.6),
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      alignment: Alignment.centerRight,
                    ),
                    SizedBox(height: responsive.hp(3)),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          InputCustom(
                            responsive: responsive,
                            labelText: 'Name',
                            onChange: (String text) {
                              _name = text;
                            },
                            hintText: 'Name of Ingredient',
                            validator: (text) {
                              if (text!.isEmpty) {
                                return "Please input name of ingredient";
                              }
                              return "";
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                NumericStepButton(
                                  minValue: 0,
                                  maxValue: 500,
                                  onChanged: (value) => {_quantity = value},
                                ),
                                CustomDropdown(
                                  options: const ["gr", "oz"],
                                  hintText: "Select a unit",
                                  labelText: "Unit of ingredients",
                                  responsive: responsive,
                                  onChange: (text) {
                                    _unit = text!;
                                  },
                                  validator: (text) {
                                    if (text == "" || text == null) {
                                      return "Please select a unit";
                                    }
                                    return "";
                                  },
                                ),
                              ],
                            ),
                          ),
                          Button(
                            text: "Create Ingredient",
                            responsive: responsive,
                            icon: Icons.create_outlined,
                            onPressed: () => _createIngredient(),
                            isLoading: isLoading,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 1,
            right: 1,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 45,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(45)),
                  child: SvgPicture.asset("assets/icons/ingredients.svg"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
