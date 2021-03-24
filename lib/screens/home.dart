import 'dart:convert';
import 'package:matrix/components/dropdown.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:matrix/widgets/admissionnews.dart';
import 'package:matrix/widgets/admissionupdate.dart';
import 'package:matrix/widgets/homeheader.dart';
import 'package:matrix/widgets/upcomingexams.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

class _MyHomePageState extends State<MyHomePage> {
  double offset = 0;
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: <Widget>[
            HomeHeader(
              image: "assets/images/banner/undraw_studying_s3l7.svg",
              textTop: "Admission ____",
              textBottom: "fine tune your preparation",
              offset: offset,
            ),
            Dropdown(),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  AdmissionUpdate(),
                  SizedBox(height: 20),
                  UpcomingExams(),
                  SizedBox(height: 20),
                  AdmissionNews(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
