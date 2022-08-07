import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_restaurant_app/class/complement.dart';
import 'package:my_restaurant_app/services/services.dart';
import 'package:my_restaurant_app/utils/error_manager.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/utils/snack_bar_message.dart';
import 'package:my_restaurant_app/widgets/dialogs/dialog_container.dart';
import 'package:my_restaurant_app/widgets/dropdown/custom_dropdown.dart';
import 'package:my_restaurant_app/widgets/input_custom.dart';
import 'package:my_restaurant_app/widgets/inputs/button_custom.dart';
import 'package:my_restaurant_app/widgets/inputs/numeric_step_button.dart';

class DialogAddComplement extends StatefulWidget {
  const DialogAddComplement({Key? key}) : super(key: key);

  @override
  _DialogAddComplementState createState() => _DialogAddComplementState();
}

class _DialogAddComplementState extends State<DialogAddComplement> {
  bool validateForm = true;
  String _name = '', _unit = '', _price = '';
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

  validationForm(bool validate) {
    setState(() {
      validateForm = validate;
    });
  }

  Future<void> _createComplement() async {
    var isOK = _formKey.currentState!.validate();
    validationForm(isOK);
    if (_quantity > 0) {
      if (validateForm) {
        setLoading();
        Map<String, dynamic> data = Complement(
          name: _name,
          quantity: _quantity,
          unit: _unit,
          price: _price,
        ).toJson();

        dynamic token = await _session.get("token");
        await _api.post("api_admin/complement/", data, token).then((response) {
          if (response.status) {
            snackBarMessage(context, "Complement created successfully");
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
        msg: "Please input a quantity of complement",
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
              constraints: BoxConstraints.expand(
                height: responsive.hp(validateForm ? 78 : 83.6),
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
                        "Add Complement",
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
                      height: responsive.hp(3),
                    ),
                    Align(
                      child: SizedBox(
                        width: responsive.wp(60),
                        child: Text(
                          "Add your complements here.",
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
                              hintText: 'Name of Complement',
                              validator: (text) {
                                if (text!.isEmpty) {
                                  return "Please input name of complement";
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
                              hintText: 'Price of Complement',
                              validator: (text) {
                                if (text!.isEmpty) {
                                  return "Please input price of complement";
                                }
                                return "";
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: NumericStepButton(
                              label: "Quantity of Complement",
                              minValue: 0,
                              maxValue: 100,
                              step: 10,
                              onChanged: (value) => {_quantity = value},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: CustomDropdown(
                              options: const ["gr", "oz"],
                              hintText: "Select a unit",
                              labelText: "Unit of complement",
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
                          ),
                          Button(
                            text: "Create Complement",
                            responsive: responsive,
                            icon: Icons.create_outlined,
                            onPressed: () => _createComplement(),
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
            top: 5,
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
