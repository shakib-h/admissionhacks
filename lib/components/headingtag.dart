import 'package:flutter/material.dart';
import 'package:matrix/components/constant.dart';

class HeadingTag extends StatelessWidget {
  final String heading;
  final String tag;
  final String ctatext;
  final VoidCallback onPressed;
  const HeadingTag({
    Key key,
    this.heading,
    this.tag,
    this.ctatext,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: heading,
                style: kTitleTextstyle,
              ),
              TextSpan(
                text: tag,
                style: TextStyle(
                  color: kTextLightColor,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        new InkWell(
          onTap: onPressed,
          child: new Text(
            ctatext,
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
