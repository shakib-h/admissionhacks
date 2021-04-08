import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matrix/components/constant.dart';
import 'package:flutter/foundation.dart';

class UpcomingExams extends StatelessWidget {
  const UpcomingExams({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text('Upcoming Exams'),
        backgroundColor: tPrimaryColor,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 30,
                  color: tShadowColor,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Title",
                  style: tListTextStyle,
                ),
                Text(
                  "Remaining Days",
                  style: tListTextStyle,
                ),
                Text(
                  "Exam Date",
                  style: tListTextStyle,
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('admission')
                .doc('p0OkS0K4q7ds9HBkp0Id')
                .collection('upcomingexams')
                .orderBy('time', descending: false)
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return LinearProgressIndicator(
                  backgroundColor: tPrimaryColor,
                );
              } else {
                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    indent: 5,
                    endIndent: 5,
                    color: Colors.black26,
                  ),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (_, index) => ExamTile(
                    data: snapshot.data.docs[index],
                  ),
                );
              }
            },
          ),
        ],
      ),
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
    String examDateFormat = DateFormat("dd MMMM yyyy").format(examDate);

    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 30,
            color: tShadowColor,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            data["title"],
            style: tListTextStyle,
          ),
          Text(
            examIn + " day(s)",
            style: tListTextStyle,
          ),
          Text(
            examDateFormat,
            style: tListTextStyle,
          )
        ],
      ),
    );
  }
}
