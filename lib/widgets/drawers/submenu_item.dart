import 'package:flutter/material.dart';

class SubMenuItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;
  final bool initExpanded;
  const SubMenuItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.children,
    this.initExpanded = false,
  }) : super(key: key);

  @override
  State<SubMenuItem> createState() => _SubMenuItemState();
}

class _SubMenuItemState extends State<SubMenuItem> {
  bool _customTileExpanded = false;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    if (widget.initExpanded) {
      setState(() {
        _customTileExpanded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.white),
          ),
          iconColor: Colors.white,
          leading: Icon(widget.icon, color: Colors.white),
          trailing: Icon(
            _customTileExpanded
                ? Icons.keyboard_arrow_up_outlined
                : Icons.keyboard_arrow_down_outlined,
            color: Colors.white,
          ),
          initiallyExpanded: _customTileExpanded,
          onExpansionChanged: (bool expanded) {
            setState(() => _customTileExpanded = expanded);
          },
          children: widget.children,
        ),
      ),
    );
  }
}
