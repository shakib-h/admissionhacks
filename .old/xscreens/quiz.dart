import 'package:admissionhacks/xwidgets/constant.dart';
import 'package:admissionhacks/xwidgets/bannerAds.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  String url = "https://app.admissionhacks.com/explore";

  int position = 1;

  final key = UniqueKey();

  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }

  startLoading(String A) {
    setState(() {
      position = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(index: position, children: <Widget>[
      Column(
        children: [
          Expanded(
            child: BannerAds(
              adUnit: adUnitBrowser,
              adSize: AdSize.fullBanner,
            ),
          )
        ],
      ),
      Container(
        color: Colors.white,
        child: Center(child: CircularProgressIndicator()),
      ),
    ]));
  }
}
