import 'dart:math';

import 'package:flutter/material.dart';

class CardFlip extends StatefulWidget {
  final Widget front;
  final Widget back;
  const CardFlip({Key? key, required this.front, required this.back})
      : super(key: key);

  @override
  _CardFlipState createState() => _CardFlipState();
}

class _CardFlipState extends State<CardFlip>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  AnimationStatus _status = AnimationStatus.dismissed;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween(begin: 1.0, end: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _status = status;
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        bool isFront = _controller.value < .5;
        return InkWell(
          onTap: () {
            if (_status == AnimationStatus.dismissed) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
          },
          child: Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.002)
              ..rotateY(
                pi * _animation.value + (isFront ? pi : 0),
              ),
            child: isFront ? widget.front : widget.back,
          ),
        );
      },
    );
  }
}
