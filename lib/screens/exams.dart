import 'package:admissionhacks/components/constant.dart';
import 'package:bangla_utilities/bangla_utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ExamsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ভর্তি পরীক্ষা",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: tBackgroundColor,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('examdate')
            .where('time', isGreaterThan: DateTime.now())
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
                return ListTile(
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
                          "DETAILS",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: EdgeInsets.zero,
                          visualDensity:
                              VisualDensity(horizontal: 1, vertical: -2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  onTap: () async {
                    if (url.isNotEmpty) {
                      await canLaunch(url)
                          ? await launch(url)
                          : throw 'Could not launch $url';
                    }
                    return null;
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
