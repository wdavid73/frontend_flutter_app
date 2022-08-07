import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_restaurant_app/utils/my_colors.dart';
import 'package:my_restaurant_app/utils/responsive.dart';
import 'package:my_restaurant_app/widgets/inputs/button_custom.dart';

class CustomDialogBox extends StatefulWidget {
  //final Responsive responsive;
  final BuildContext context;
  final String description, type;
  final bool buttonCopy;
  final void Function()? copyCode;
  const CustomDialogBox({
    Key? key,
    required this.description,
    required this.type,
    required this.context,
    this.buttonCopy = false,
    this.copyCode,
  }) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: widget.type == "success"
          ? contextBox(context, "Success", Colors.green,
              "assets/icons/success.svg", "Success Icon")
          : widget.type == "error"
              ? contextBox(context, "Error", Colors.red,
                  "assets/icons/error.svg", "Error Icon")
              : widget.type == "info"
                  ? contextBox(context, "Information", Colors.blueAccent,
                      "assets/icons/information.svg", "Information Icon")
                  : widget.type == "warning"
                      ? contextBox(context, "Warning", Colors.amberAccent,
                          "assets/icons/warning.svg", "Warning Icon")
                      : contextBox(context, "Question", Colors.orangeAccent,
                          "assets/icons/question.svg", "Question Icon"),
    );
  }

  contextBox(
    context,
    String title,
    Color color,
    String icon,
    String labelIcon,
  ) {
    final Responsive responsive = Responsive(context);
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
            right: 20,
            left: 20,
            top: 65,
            bottom: 20,
          ),
          width: responsive.wp(80),
          height: responsive.hp(widget.buttonCopy ? 35 : 30),
          margin: const EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            /*boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                offset: Offset(0, 10),
                blurRadius: 10,
              ),
            ],*/
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: responsive.dp(3),
                          fontWeight: FontWeight.w600,
                          color: color,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget.description,
                        style: const TextStyle(fontSize: 14),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                    ],
                  ),
                ),
              ),
              widget.buttonCopy
                  ? Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Button(
                        text: "Copy",
                        icon: Icons.copy,
                        responsive: responsive,
                        onPressed: widget.copyCode,
                      ),
                    )
                  : Container()
            ],
          ),
        ),
        Positioned(
          left: responsive.wp(25),
          right: responsive.wp(25),
          bottom: responsive.hp(widget.buttonCopy ? 25 : 20),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: responsive.dp(8),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  icon,
                  semanticsLabel: labelIcon,
                  placeholderBuilder: (BuildContext context) => Container(
                    padding: const EdgeInsets.all(30.0),
                    child: const CircularProgressIndicator(
                      color: MyColors.accentColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
