import 'dart:async';
import 'initial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1800), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => InitialPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    var introImage =
        SvgPicture.asset('assets/images/banner/undraw_studying_s3l7.svg');

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            introImage,
            Text(
              "Admission ____",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
