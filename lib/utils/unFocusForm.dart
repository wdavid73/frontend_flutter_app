import 'package:flutter/material.dart';

unFocusForm(context) {
  FocusScope.of(context).requestFocus(new FocusNode());
}
