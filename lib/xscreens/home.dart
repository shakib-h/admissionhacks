import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:admissionhacks/widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:admissionhacks/widgets/admissionnews.dart';
import 'package:admissionhacks/widgets/admissionupdate.dart';
import 'package:admissionhacks/widgets/bannerAds.dart';
import 'package:admissionhacks/widgets/upcomingexamswidget.dart';

class OldHomePage extends StatefulWidget {
  const OldHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _OldHomePageState createState() => _OldHomePageState();
}

class _OldHomePageState extends State<OldHomePage> {
  Future? getSliderImage() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection('home_slider').get();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                AdmissionUpdate(),
                SizedBox(height: 20),
                UpcomingExamsWidget(),
                SizedBox(height: 20),
                BannerAds(
                  adUnit: adUnitHome,
                  adSize: AdSize.fullBanner,
                ),
                SizedBox(height: 10),
                AdmissionNews(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
