import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_restaurant_app/class/drink.dart';
import 'package:my_restaurant_app/services/services.dart';
import 'package:my_restaurant_app/utils/error_manager.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/utils/snack_bar_message.dart';
import 'package:my_restaurant_app/widgets/dialogs/dialog_container.dart';
import 'package:my_restaurant_app/widgets/inputs/button_custom.dart';

import '../input_custom.dart';

class DialogAddDrink extends StatefulWidget {
  const DialogAddDrink({Key? key}) : super(key: key);

  @override
  _DialogAddDrinkState createState() => _DialogAddDrinkState();
}

class _DialogAddDrinkState extends State<DialogAddDrink> {
  bool validateForm = true;
  bool isLoading = false;
  String _name = '', _price = '';
  final GlobalKey<FormState> _formKey = GlobalKey();
  final ApiProvider _api = ApiProvider();
  final _session = SessionManager();
  setLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  validationForm(bool validate) {
    setState(() {
      validateForm = validate;
    });
  }

  Future<void> _createDrink() async {
    var isOK = _formKey.currentState!.validate();
    validationForm(isOK);
    if (validateForm) {
      setLoading();
      Map<String, dynamic> data = Drink(
        name: _name,
        price: _price,
      ).toJson();
      dynamic token = await _session.get("token");
      await _api.post("api_admin/drink/", data, token).then((response) {
        if (response.status) {
          snackBarMessage(context, "Drink created successfully");
          _formKey.currentState!.reset();
          Navigator.pop(context, true);
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
    return DialogContainer(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(
                height: responsive.hp(validateForm ? 50 : 55.75),
              ),
              child: Container(
                padding: const EdgeInsets.only(
                  right: 10,
                  left: 10,
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
                        "Add Drink",
                        style: TextStyle(
                          fontSize: responsive.dp(2.3),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      alignment: Alignment.centerRight,
                    ),
                    SizedBox(
                      height: responsive.hp(1.5),
                    ),
                    Align(
                      child: SizedBox(
                        width: responsive.wp(60),
                        child: Text(
                          "Add your drink here.",
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                            child: InputCustom(
                              responsive: responsive,
                              labelText: 'Name',
                              onChange: (String text) {
                                _name = text;
                              },
                              hintText: 'Name of Drink',
                              validator: (text) {
                                if (text!.isEmpty) {
                                  return "Please input name of drink";
                                }
                                return "";
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                            child: InputCustom(
                              responsive: responsive,
                              keyboardType: TextInputType.number,
                              labelText: 'Price',
                              prefixText: "\$",
                              onChange: (String text) {
                                _price = text;
                              },
                              hintText: 'Price of Drink',
                              validator: (text) {
                                if (text!.isEmpty) {
                                  return "Please input price of Drink";
                                }
                                return "";
                              },
                            ),
                          ),
                          Button(
                            text: "Create Drink",
                            responsive: responsive,
                            icon: Icons.create_outlined,
                            onPressed: () => _createDrink(),
                            isLoading: isLoading,
                          ),
                        ],
                      ),
                    ),
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
            top: 5,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 45,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(45)),
                  child: SvgPicture.asset("assets/icons/drink.svg"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
