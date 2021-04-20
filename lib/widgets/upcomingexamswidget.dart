import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:admissionhacks/components/constant.dart';
import 'package:admissionhacks/components/heading.dart';
import 'package:flutter/foundation.dart';
import 'package:admissionhacks/screens/upcomingexams.dart';

class UpcomingExamsWidget extends StatelessWidget {
  const UpcomingExamsWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isInterstitialAdReady = false;

    final AdListener listener = AdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) {
        _isInterstitialAdReady = true;
      },
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        _isInterstitialAdReady = false;
      },
      // Called when an ad opens an overlay that covers the screen.
      onAdOpened: (Ad ad) => {},
      // Called when an ad removes an overlay that covers the screen.
      onAdClosed: (Ad ad) => {},
      // Called when an ad is in the process of leaving the application.
      onApplicationExit: (Ad ad) => {},
    );

    final InterstitialAd myInterstitial = InterstitialAd(
      adUnitId: adUnitInterstitial,
      request: AdRequest(),
      listener: listener,
    );

    myInterstitial.load();

    return Column(
      children: [
        Heading(
            heading: "Upcoming Exams",
            ctatext: "See more",
            onPressed: () async {
              if (_isInterstitialAdReady) {
                myInterstitial.show();
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpcomingExams(),
                  ));
            }),
        Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 30,
                color: tShadowColor,
              ),
            ],
          ),
          child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('admission')
                .doc('p0OkS0K4q7ds9HBkp0Id')
                .collection('upcomingexams')
                .orderBy('time', descending: false)
                .limit(4)
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return LinearProgressIndicator(
                  backgroundColor: tPrimaryColor,
                );
              } else {
                return ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => Divider(
                    indent: 10,
                    endIndent: 10,
                    color: Colors.black26,
                  ),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (_, index) => ExamTile(
                    data: snapshot.data.docs[index],
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class ExamTile extends StatelessWidget {
  ExamTile({this.data});

  final data;

  @override
  Widget build(BuildContext context) {
    DateTime examDate = data['time'].toDate();
    DateTime dateTimeNow = DateTime.now();
    String examIn = examDate.difference(dateTimeNow).inDays.toString();
    String examDateFormat = DateFormat("dd MMM").format(examDate);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          data["title"],
          style: tListTextStyle,
        ),
        Text(
          "in " + examIn + " days - " + examDateFormat,
          style: tListTextStyle,
        ),
      ],
    );
  }
}
