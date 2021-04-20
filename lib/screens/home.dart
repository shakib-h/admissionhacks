import 'package:admissionhacks/widgets/components.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:admissionhacks/widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:admissionhacks/widgets/admissionnews.dart';
import 'package:admissionhacks/widgets/admissionupdate.dart';
import 'package:admissionhacks/widgets/bannerAds.dart';
import 'package:admissionhacks/widgets/homeheader.dart';
import 'package:admissionhacks/widgets/upcomingexamswidget.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          HomeHeader(
            image: "assets/images/undraw_studying.svg",
            textTop: "Admission Hacks",
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
