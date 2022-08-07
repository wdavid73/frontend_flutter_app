import 'package:flutter/material.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/responsive.dart';

class NumericStepButton extends StatefulWidget {
  final String label;
  final int minValue;
  final int maxValue;
  final int step;

  final ValueChanged<int> onChanged;

  const NumericStepButton({
    Key? key,
    this.minValue = 0,
    this.maxValue = 10,
    this.step = 1,
    required this.onChanged,
    this.label = '',
  }) : super(key: key);

  @override
  State<NumericStepButton> createState() {
    return _NumericStepButtonState();
  }
}

class _NumericStepButtonState extends State<NumericStepButton> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.label != ''
            ? Text(
                widget.label,
                style: TextStyle(
                  fontSize: responsive.dp(1.6),
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              )
            : Container(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(
                Icons.remove,
                color: MyColors.accentColor,
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 15.0),
              iconSize: responsive.dp(2),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                setState(() {
                  if (counter > widget.minValue) {
                    widget.step == 1
                        ? counter--
                        : counter = counter - widget.step;
                  }
                  widget.onChanged(counter);
                });
              },
            ),
            Text(
              '$counter',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.add,
                color: MyColors.accentColor,
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 15.0),
              iconSize: responsive.dp(2),
              color: MyColors.darkPrimaryColor,
              onPressed: () {
                setState(() {
                  if (counter < widget.maxValue) {
                    widget.step == 1
                        ? counter++
                        : counter = counter + widget.step;
                  }
                  widget.onChanged(counter);
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
