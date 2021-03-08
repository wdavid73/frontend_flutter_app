import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconContainerBlack extends StatelessWidget {
  final double size;
  final String iconUrl;

  const IconContainerBlack({
    Key key,
    @required this.size,
    @required this.iconUrl,
  })  : assert(size != null && size > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size,
      height: this.size,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(this.size * 0.15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            offset: Offset(0, 15),
          )
        ],
      ),
      padding: EdgeInsets.all(this.size * 0.15),
      child: Center(
        child: SvgPicture.asset(
          //'assets/icon.svg',
          this.iconUrl,
          width: this.size * 0.8,
          height: this.size * 0.8,
        ),
      ),
    );
  }
}
