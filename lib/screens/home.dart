import 'package:admissionhacks/widgets/examsCard.dart';
import 'package:admissionhacks/widgets/formFillCard.dart';
import 'package:flutter/material.dart';
import 'package:admissionhacks/widgets/homeSlider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HomeSlider(),
          FormFillCard(),
          ExamsCard(),
        ],
      ),
    );
  }
}
