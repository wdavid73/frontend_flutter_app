import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final Function onTap;
  final int index;
  final String title;

  const MenuItem({
    Key key,
    @required int selectedDestination,
    @required this.icon,
    @required this.title,
    this.onTap,
    this.index,
  })  : _selectedDestination = selectedDestination,
        super(key: key);

  final int _selectedDestination;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ListTile(
        leading: Icon(
          icon,
          color:
              _selectedDestination == index ? Colors.pinkAccent : Colors.white,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: _selectedDestination == index
                ? Colors.pinkAccent
                : Colors.white,
          ),
        ),
        selected: _selectedDestination == index,
        onTap: onTap,
      ),
    );
  }
}
