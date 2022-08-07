import 'package:flutter/material.dart';
import 'package:my_restaurant_app/utils/responsive.dart';

class NoData extends StatelessWidget {
  final Responsive responsive;
  final Color textColor;
  final void Function()? refresh;
  const NoData({
    Key? key,
    required this.responsive,
    this.textColor = Colors.black,
    this.refresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "No data",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: responsive.dp(4),
              color: textColor,
            ),
          ),
          TextButton.icon(
            onPressed: refresh,
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            label: const Text(
              "Tap to reload",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
