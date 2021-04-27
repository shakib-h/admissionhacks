import 'package:admissionhacks/widgets/examsCard.dart';
import 'package:admissionhacks/widgets/formFillCard.dart';
import 'package:flutter/material.dart';
import 'package:admissionhacks/widgets/homeSlider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
