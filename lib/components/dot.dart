import 'package:flutter/material.dart';

class Dot extends StatelessWidget {
  final Color color;
  const Dot({
    Key key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      height: 25,
      width: 25,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(.26),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(
            color: color,
            width: 2,
          ),
        ),
      ),
    );
  }
}
