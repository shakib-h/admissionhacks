import 'package:admissionhacks/components/constant.dart';
import 'package:admissionhacks/components/heading.dart';
import 'package:admissionhacks/screens/formfill.dart';
import 'package:bangla_utilities/bangla_utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

class FormFillCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Heading(
          title: "ফর্ম ফিলাপ",
          button: "আরও দেখুন",
          ontap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormFillScreen(),
                ));
          },
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 10), blurRadius: 30, color: tShadowColor),
            ],
          ),
          child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('formfillup')
                .orderBy('time')
                .where('time', isGreaterThan: DateTime.now())
                .limit(4)
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    tShadowColor,
                  ),
                  backgroundColor: tBackgroundColor,
                );
              } else {
                return ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => Divider(
                    indent: 10,
                    endIndent: 10,
                    color: tShadowColor,
                    height: 0,
                  ),
                  physics: BouncingScrollPhysics(),
                  itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                  itemBuilder: (_, index) {
                    QueryDocumentSnapshot formfillData =
                        (snapshot.data! as QuerySnapshot).docs[index];
                    String title = formfillData["title"];
                    String url = formfillData["url"];
                    DateTime date = formfillData['time'].toDate();
                    int daysLeft = date.difference(DateTime.now()).inDays;
                    int hoursLeft = date.difference(DateTime.now()).inHours;
                    return Material(
                      color: Colors.transparent,
                      child: ListTile(
                        dense: true,
                        title: Text(title, style: tListTextStyle),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              (daysLeft == 0)
                                  ? BanglaUtility.englishToBanglaDigit(
                                          englishDigit: hoursLeft) +
                                      " ঘণ্টা বাকি"
                                  : BanglaUtility.englishToBanglaDigit(
                                          englishDigit: daysLeft) +
                                      " দিন বাকি",
                              style: tListTextStyle.copyWith(
                                  color: (daysLeft < 5)
                                      ? Colors.redAccent
                                      : tListTextColor),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            TextButton(
                              onPressed: null,
                              child: Text(
                                "APPLY",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.black,
                                padding: EdgeInsets.zero,
                                visualDensity:
                                    VisualDensity(horizontal: -2, vertical: -2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                            )
                          ],
                        ),
                        onTap: () {
                          FlutterWebBrowser.openWebPage(
                            url: url,
                            customTabsOptions: CustomTabsOptions(
                              //secondaryToolbarColor: Colors.green,
                              //navigationBarColor: Colors.amber,
                              addDefaultShareMenuItem: true,
                              instantAppsEnabled: true,
                              showTitle: true,
                              urlBarHidingEnabled: true,
                            ),
                          );
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
    );
  }
}
