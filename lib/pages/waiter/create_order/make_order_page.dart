import 'package:flutter/material.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/widgets/title_app_bar.dart';

import 'make_order_form.dart';

class MakeOrderPage extends StatefulWidget {
  const MakeOrderPage({Key? key}) : super(key: key);

  @override
  State<MakeOrderPage> createState() => _MakeOrderPageState();
}

class _MakeOrderPageState extends State<MakeOrderPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.darkPrimaryColor,
        centerTitle: true,
        elevation: 0,
        title: const TitleAppBar(
          text: "Make Order",
        ),
      ),
      body: const SingleChildScrollView(
        child: MakeOrderForm(),
      ),
    );
  }
}
