import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:bangla_utilities/bangla_utilities.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //slider
          AspectRatio(
            aspectRatio: 24.3 / 9,
            child: FutureBuilder(
              future:
                  FirebaseFirestore.instance.collection('home_slider').get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return LinearProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.purpleAccent,
                    ),
                  );
                } else {
                  return CarouselSlider.builder(
                    slideBuilder: (index) {
                      QueryDocumentSnapshot sliderData =
                          (snapshot.data! as QuerySnapshot).docs[index];
                      return Container(
                        margin: EdgeInsets.fromLTRB(7.5, 15, 7.5, 15),
                        decoration: BoxDecoration(
                          color: Colors.purpleAccent,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(5, 5),
                              blurRadius: 10,
                              color: Colors.purpleAccent,
                            ),
                          ],
                          border: Border.all(
                              color: Colors.purpleAccent, width: 0.5),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              sliderData["img-url"],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                    slideIndicator: CircularWaveSlideIndicator(
                      padding: EdgeInsets.only(bottom: 20),
                      indicatorBackgroundColor: Colors.white,
                      currentIndicatorColor: Colors.black,
                      indicatorRadius: 3,
                      indicatorBorderWidth: 0,
                      indicatorBorderColor: Colors.transparent,
                    ),
                    enableAutoSlider: true,
                    unlimitedMode: true,
                    viewportFraction: 0.8,
                  );
                }
              },
            ),
          ),
          //formfill
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 30,
                    color: Colors.purpleAccent),
              ],
            ),
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('formfillup')
                  //.orderBy('end')
                  //needs to fix it
                  .where('end', isGreaterThan: DateTime.now())
                  .limit(4)
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.purpleAccent,
                    ),
                    backgroundColor: Colors.white,
                  );
                } else {
                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => Divider(
                      indent: 10,
                      endIndent: 10,
                      color: Colors.purpleAccent,
                      height: 0,
                    ),
                    physics: BouncingScrollPhysics(),
                    itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                    itemBuilder: (_, index) {
                      QueryDocumentSnapshot formfillData =
                          (snapshot.data! as QuerySnapshot).docs[index];
                      bool announced = formfillData['announced'];
                      String title = formfillData['title'];
                      String subtitle = formfillData['subtitle'];
                      String url = formfillData['url'];
                      DateTime now = DateTime.now();
                      DateTime start = formfillData['start'].toDate();
                      int startsIn = start.difference(now).inDays;
                      DateTime end = formfillData['end'].toDate();
                      int daysLeft = end.difference(now).inDays;
                      int hoursLeft = end.difference(now).inHours;

                      return Material(
                        color: Colors.transparent,
                        child: ListTile(
                          dense: true,
                          title: Text(
                            title,
                            //style: tListTextStyle,
                          ),
                          subtitle: (subtitle.isNotEmpty)
                              ? Text(
                                  subtitle,
                                )
                              : null,
                          trailing: (announced == false)
                              ? Text(
                                  "এখনো ঘোষণা হয়নি",
                                  //style: tListTextStyle,
                                )
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    (start.isAfter(now))
                                        ? Text(
                                            BanglaUtility.englishToBanglaDigit(
                                                    englishDigit: startsIn) +
                                                " দিনে শুরু হবে",
                                            //style: tListTextStyle,
                                          )
                                        : Text(
                                            (daysLeft == 0)
                                                ? BanglaUtility
                                                        .englishToBanglaDigit(
                                                            englishDigit:
                                                                hoursLeft) +
                                                    " ঘণ্টা বাকি"
                                                : BanglaUtility
                                                        .englishToBanglaDigit(
                                                            englishDigit:
                                                                daysLeft) +
                                                    " দিন বাকি",
                                            style: //tListTextStyle.copyWith(
                                                TextStyle(
                                                    color: (daysLeft < 5)
                                                        ? Colors.redAccent
                                                        : Colors.purpleAccent),
                                          ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    TextButton(
                                      onPressed: null,
                                      child: Text(
                                        (start.isBefore(now))
                                            ? "APPLY"
                                            : "DETAILS",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        padding: EdgeInsets.zero,
                                        visualDensity: VisualDensity(
                                            horizontal: 0, vertical: -2),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                          onTap: () {
                            // FlutterWebBrowser.openWebPage(
                            //   url: url,
                            //   customTabsOptions: CustomTabsOptions(
                            //     //secondaryToolbarColor: Colors.green,
                            //     //navigationBarColor: Colors.amber,
                            //     addDefaultShareMenuItem: true,
                            //     instantAppsEnabled: true,
                            //     showTitle: true,
                            //     urlBarHidingEnabled: true,
                            //   ),
                            // );
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          //exams
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 30,
                    color: Colors.purpleAccent),
              ],
            ),
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('examdate')
                  .orderBy('time')
                  .where('time', isGreaterThan: DateTime.now())
                  .limit(4)
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.purpleAccent,
                    ),
                    backgroundColor: Colors.white,
                  );
                } else {
                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => Divider(
                      indent: 10,
                      endIndent: 10,
                      color: Colors.purpleAccent,
                      height: 0,
                    ),
                    physics: BouncingScrollPhysics(),
                    itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                    itemBuilder: (_, index) {
                      QueryDocumentSnapshot examData =
                          (snapshot.data! as QuerySnapshot).docs[index];
                      String title = examData["title"];
                      String subtitle = examData["subtitle"];
                      String url = examData["url"];
                      DateTime date = examData['time'].toDate();
                      int daysLeft = date.difference(DateTime.now()).inDays;
                      int hoursLeft = date.difference(DateTime.now()).inHours;
                      return Material(
                        color: Colors.transparent,
                        child: ListTile(
                          dense: true,
                          title: Text(
                            title,
                            //style: tListTextStyle,
                          ),
                          subtitle: (subtitle.isNotEmpty)
                              ? Text(
                                  subtitle,
                                )
                              : null,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              (date.isAfter(DateTime.now()))
                                  ? Text(
                                      (daysLeft == 0)
                                          ? BanglaUtility.englishToBanglaDigit(
                                                  englishDigit: hoursLeft) +
                                              " ঘণ্টা বাকি"
                                          : BanglaUtility.englishToBanglaDigit(
                                                  englishDigit: daysLeft) +
                                              " দিন বাকি",
                                      style: //tListTextStyle.copyWith(
                                          TextStyle(
                                              color: (daysLeft < 5)
                                                  ? Colors.redAccent
                                                  : Colors.purpleAccent),
                                    )
                                  : Text(
                                      "পরীক্ষা শেষ",
                                      style: //tListTextStyle.copyWith(
                                          TextStyle(color: Colors.redAccent),
                                    ),
                              SizedBox(
                                width: 10,
                              ),
                              TextButton(
                                onPressed: null,
                                child: Text(
                                  (date.isAfter(DateTime.now()))
                                      ? "DETAILS"
                                      : "RESULT",
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  padding: EdgeInsets.zero,
                                  visualDensity: VisualDensity(
                                      horizontal: 1, vertical: -2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                              )
                            ],
                          ),
                          onTap: () {
                            // FlutterWebBrowser.openWebPage(
                            //   url: url,
                            //   customTabsOptions: CustomTabsOptions(
                            //     //secondaryToolbarColor: Colors.green,
                            //     //navigationBarColor: Colors.amber,
                            //     addDefaultShareMenuItem: true,
                            //     instantAppsEnabled: true,
                            //     showTitle: true,
                            //     urlBarHidingEnabled: true,
                            //   ),
                            // );
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
