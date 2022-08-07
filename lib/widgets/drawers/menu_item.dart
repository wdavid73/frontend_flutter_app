import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final void Function()? onTap;
  final int index;
  final String title;
  final double padding;
  const MenuItem({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.index,
    required this.title,
    required int selectedDestination,
    this.padding = 5,
  })  : _selectedDestination = selectedDestination,
        super(key: key);

  final int _selectedDestination;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: ListTile(
        leading: Icon(
          icon,
          //color: _selectedDestination == index ? Colors.blueGrey : Colors.white,
          color: Colors.white,
        ),
        title: Text(
          title,
          style: const TextStyle(
            //color: _selectedDestination == index ? Colors.amber : Colors.white,
            color: Colors.white,
            fontSize: 12,
          ),
        ),
        selected: _selectedDestination == index,
        onTap: onTap,
      ),
    );
  }
}
