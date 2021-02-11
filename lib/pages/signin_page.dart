import 'package:flutter/material.dart';
import 'package:my_restaurant_frontend_app/class/Positions.dart';
import 'package:my_restaurant_frontend_app/services/services.dart';
import 'package:my_restaurant_frontend_app/utils/my_colors.dart';
import 'package:my_restaurant_frontend_app/utils/responsive.dart';
import 'package:my_restaurant_frontend_app/utils/string_extension.dart';
import 'package:my_restaurant_frontend_app/widgets/icon_container.dart';
import 'package:my_restaurant_frontend_app/widgets/input_text.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _username, _email, _phone, _password, _codeRestaurant;
  int _idPosition;
  GlobalKey<FormState> _formKey = GlobalKey();
  RestClientServices _restClientServices = RestClientServices();
  List<Position> positions = [];

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    this._getPositions();
    super.initState();
  }

  Future<void> _getPositions() async {
    await _restClientServices
        .getPositions("api_admin/api_auth/positions")
        .then((value) {
      setState(() {
        positions = value.position;
      });
    });
    print("get positions");
  }

  _register() async {
    final isOk = _formKey.currentState.validate();
    if (isOk) {
      Map<String, dynamic> data = {
        "username": _username,
        "email": _email,
        "phone": _phone,
        "password": _password,
        "position_id": _idPosition,
        "restaurant_code": _codeRestaurant
      };
      print(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign in",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: responsive.dp(2),
          ),
        ),
        backgroundColor: MyColors.darkPrimaryColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: responsive.height * 0.7,
              width: responsive.width,
              color: MyColors.darkPrimaryColor,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 3),
                        child: IconContainer(
                          size: responsive.dp(12),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: responsive.height * 0.7,
              width: responsive.width,
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(50),
                  topRight: const Radius.circular(50.0),
                ),
              ),
              child: buildBody(responsive),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBody(Responsive responsive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InputText(
                  type: TextInputType.text,
                  label: 'your username',
                  fontSize: responsive.dp(2),
                  onChanged: (text) {
                    _username = text;
                  },
                  validator: (text) {
                    if (text.trim().length <= 0 || text.isEmpty) {
                      return "invalid username".capitalizeEachWord();
                    }
                    return null;
                  },
                ),
                InputText(
                  type: TextInputType.emailAddress,
                  label: 'your email address',
                  fontSize: responsive.dp(2),
                  onChanged: (text) {
                    _email = text;
                  },
                  validator: (text) {
                    if (text.trim().length <= 0 || text.isEmpty) {
                      return "invalid email".capitalizeEachWord();
                    }
                    return null;
                  },
                ),
                InputText(
                  type: TextInputType.text,
                  label: 'your password',
                  fontSize: responsive.dp(2),
                  obscureText: true,
                  onChanged: (text) {
                    _password = text;
                  },
                  validator: (text) {
                    if (text.trim().length <= 0 || text.isEmpty) {
                      return "invalid password".capitalizeEachWord();
                    }
                    if (text.length <= 8) {
                      return "password size must be greater than 8"
                          .capitalizeEachWord();
                    }
                    return null;
                  },
                ),
                InputText(
                  type: TextInputType.phone,
                  label: 'your phone',
                  fontSize: responsive.dp(2),
                  onChanged: (text) {
                    _phone = text;
                  },
                  validator: (text) {
                    if (text.trim().length <= 0 || text.isEmpty) {
                      return "invalid phone".capitalizeEachWord();
                    }
                    return null;
                  },
                ),
                InputText(
                  type: TextInputType.text,
                  label: 'code of your restaurant',
                  fontSize: responsive.dp(2),
                  onChanged: (text) {
                    _codeRestaurant = text;
                  },
                  validator: (text) {
                    if (text.trim().length <= 0 || text.isEmpty) {
                      return "invalid code of restaurant".capitalizeEachWord();
                    }
                    return null;
                  },
                ),
                selectPosition(responsive),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            this._register();
          },
          child: SizedBox(
            height: responsive.height * 0.07,
            width: responsive.width * 0.7,
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              color: MyColors.darkPrimaryColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Text(
                    "Register",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: responsive.dp(2),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: responsive.height * 0.05,
        )
      ],
    );
  }

  Widget selectPosition(Responsive responsive) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: responsive.width * 0.9,
        child: DropdownButtonFormField(
          hint: Text(
            "select a position".capitalizeEachWord(),
          ),
          isExpanded: true,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: MyColors.dividerColor,
              ),
            ),
            filled: true,
            fillColor: Colors.white54,
            focusColor: Colors.white70,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: MyColors.dividerColor,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          ),
          style: TextStyle(
            color: Colors.black45,
            fontSize: responsive.dp(2),
            fontWeight: FontWeight.w500,
          ),
          itemHeight: responsive.height * 0.08,
          items: positions.map((item) {
            return DropdownMenuItem(
              value: item.id,
              child: Text(
                item.name.toUpperCase(),
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: MyColors.primaryTextColor,
                  fontSize: responsive.dp(2),
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }).toList(),
          onChanged: (int idPosition) {
            _idPosition = idPosition;
          },
        ),
      ),
    );
  }
}

/*
*
Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: MyColors.darkPrimaryColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Sign In",
          maxLines: 1,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: responsive.dp(2.5),
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: responsive.height,
                width: responsive.width,
                color: MyColors.darkPrimaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          child: IconButton(
                            iconSize: responsive.width * 0.3,
                            onPressed: () {
                              print("reset");
                              //_formKey.currentState.reset();
                            },
                            icon: IconContainer(
                              size: responsive.width * 0.3,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: responsive.height * 0.7,
                            width: responsive.width,
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(35),
                                topRight: const Radius.circular(35),
                              ),
                            ),
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Form(
                                            key: _formKey,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                InputText(
                                                  type: TextInputType.text,
                                                  label: 'your username',
                                                  fontSize: responsive.dp(2),
                                                  onChanged: (text) {
                                                    _username = text;
                                                  },
                                                  validator: (text) {
                                                    if (text.trim().length <=
                                                            0 ||
                                                        text.isEmpty) {
                                                      return "invalid username"
                                                          .capitalizeEachWord();
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                InputText(
                                                  type: TextInputType
                                                      .emailAddress,
                                                  label: 'your email address',
                                                  fontSize: responsive.dp(2),
                                                  onChanged: (text) {
                                                    _email = text;
                                                  },
                                                  validator: (text) {
                                                    if (text.trim().length <=
                                                            0 ||
                                                        text.isEmpty) {
                                                      return "invalid email"
                                                          .capitalizeEachWord();
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                InputText(
                                                  type: TextInputType.text,
                                                  label: 'your password',
                                                  fontSize: responsive.dp(2),
                                                  obscureText: true,
                                                  onChanged: (text) {
                                                    _password = text;
                                                  },
                                                  validator: (text) {
                                                    if (text.trim().length <=
                                                            0 ||
                                                        text.isEmpty) {
                                                      return "invalid password"
                                                          .capitalizeEachWord();
                                                    }
                                                    if (text.length <= 8) {
                                                      return "password size must be greater than 8"
                                                          .capitalizeEachWord();
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                InputText(
                                                  type: TextInputType.phone,
                                                  label: 'your phone',
                                                  fontSize: responsive.dp(2),
                                                  onChanged: (text) {
                                                    _phone = text;
                                                  },
                                                  validator: (text) {
                                                    if (text.trim().length <=
                                                            0 ||
                                                        text.isEmpty) {
                                                      return "invalid phone"
                                                          .capitalizeEachWord();
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                InputText(
                                                  type: TextInputType.text,
                                                  label:
                                                      'code of your restaurant',
                                                  fontSize: responsive.dp(2),
                                                  onChanged: (text) {
                                                    _codeRestaurant = text;
                                                  },
                                                  validator: (text) {
                                                    if (text.trim().length <=
                                                            0 ||
                                                        text.isEmpty) {
                                                      return "invalid code of restaurant"
                                                          .capitalizeEachWord();
                                                    }
                                                    return null;
                                                  },
                                                ),

                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                  SizedBox(
                                    height: responsive.height * 0.05,
                                  ),
                                ],
                              ),
                            ),
                          ), //container of form
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
* */
