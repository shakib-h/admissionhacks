import 'package:admissionhacks/shared/constant.dart';
import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String title;
  final String button;
  final VoidCallback? ontap;
  const Heading({
    Key? key,
    required this.title,
    required this.button,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: tHeadingTextStyle,
          ),
          TextButton(
            onPressed: ontap,
            child: Text(button),
            style: TextButton.styleFrom(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
                //side: BorderSide(color: Colors.black),
              ),
              //primary: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
