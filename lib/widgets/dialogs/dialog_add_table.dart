import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_restaurant_app/class/table.dart';
import 'package:my_restaurant_app/services/services.dart';
import 'package:my_restaurant_app/utils/error_manager.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/utils/snack_bar_message.dart';
import 'package:my_restaurant_app/widgets/inputs/button_custom.dart';

import '../input_custom.dart';
import 'dialog_container.dart';

class DialogAddTable extends StatefulWidget {
  const DialogAddTable({Key? key}) : super(key: key);

  @override
  _DialogAddTableState createState() => _DialogAddTableState();
}

class _DialogAddTableState extends State<DialogAddTable> {
  bool validateForm = true;
  String _refTable = '';
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

  Future<void> _createTable() async {
    var isOK = _formKey.currentState!.validate();
    validationForm(isOK);
    if (validateForm) {
      setLoading();
      Map<String, dynamic> data = TableApp(ref: _refTable).toJson();
      dynamic token = await _session.get("token");
      await _api.post("api_admin/tables/", data, token).then((response) {
        if (response.status) {
          snackBarMessage(context, "Table created successfully");
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
                height: responsive.hp(validateForm ? 45 : 50),
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
                              labelText: 'Reference',
                              onChange: (String text) {
                                _refTable = text;
                              },
                              hintText: 'Reference of Table',
                              validator: (text) {
                                if (text!.isEmpty) {
                                  return "Please input ref of table";
                                }
                                return "";
                              },
                            ),
                          ),
                          Button(
                            text: "Create Complement",
                            responsive: responsive,
                            icon: Icons.create_outlined,
                            onPressed: () => _createTable(),
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
                  child: SvgPicture.asset("assets/icons/tabla.svg"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
