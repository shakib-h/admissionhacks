import 'package:admissionhacks/components/constant.dart';
import 'package:admissionhacks/components/dot.dart';
import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  final int number;
  final Color color;
  final String title;
  final Function onpress;
  const Counter({
    Key key,
    this.number,
    this.color,
    this.title,
    this.onpress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onpress,
      child: Column(
        children: <Widget>[
          Dot(
            color: color,
          ),
          SizedBox(height: 10),
          Text(
            "$number",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.normal,
              color: color,
            ),
          ),
          Text(title, style: tSubTextStyle),
        ],
      ),
    );
  }
}
