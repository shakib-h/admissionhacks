import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 8, // 60% of space => (6/(6 + 4))
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo_splash.png'),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              "Welcome to Admission Hacks",
              style: TextStyle(fontSize: 18),
              textDirection: TextDirection.ltr,
            ),
          ),
        ),
      ],
    );
  }
}
