import 'package:admissionhacks/shared/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class NoticationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "নোটিফিকেশন",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: tBackgroundColor,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('notifications')
            .orderBy('time')
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
                  QueryDocumentSnapshot notificationData =
                      (snapshot.data! as QuerySnapshot).docs[index];
                  String date = DateFormat("dd MMM")
                      .format(notificationData['time'].toDate());
                  String time =
                      DateFormat.jm().format(notificationData['time'].toDate());
                  String url = notificationData["url"];
                  String content = notificationData["content"];
                  return ListTile(
                    title: Text(
                      content,
                    ),
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.black),
                          child: Icon(
                            LineIcons.bell,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    trailing: Container(
                      width: 45,
                      child: Center(
                        child: Text(
                          date + "\n" + time,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
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
                });
          }
        },
      ),
    );
  }
}
