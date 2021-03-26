import 'package:flutter/material.dart';
import 'package:matrix/components/constant.dart';

class Heading extends StatelessWidget {
  final String heading;
  final String ctatext;
  final VoidCallback onPressed;
  const Heading({
    Key key,
    this.heading,
    this.ctatext,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          heading,
          style: tTitleTextstyle,
        ),
        new InkWell(
          onTap: onPressed,
          child: new Text(
            ctatext,
            style: TextStyle(
              color: tPrimaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
