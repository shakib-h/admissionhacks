import 'package:matrix/components/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:matrix/widgets/admissionnews.dart';
import 'package:matrix/widgets/admissionupdate.dart';
import 'package:matrix/widgets/homeheader.dart';
import 'package:matrix/widgets/upcomingexamswidget.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        HomeHeader(
          image: "assets/images/banner/undraw_studying_s3l7.svg",
          textTop: "Admission ____",
          textBottom: "fine tune your preparation",
          offset: 0,
        ),
        Dropdown(),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              AdmissionUpdate(),
              SizedBox(height: 20),
              UpcomingExamsWidget(),
              SizedBox(height: 20),
              AdmissionNews(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
