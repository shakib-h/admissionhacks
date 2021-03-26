import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matrix/components/constant.dart';
import 'package:matrix/components/heading.dart';
import 'package:flutter/foundation.dart';
import 'package:timeago/timeago.dart' as timeago;

class UpcomingExams extends StatelessWidget {
  const UpcomingExams({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Heading(
          heading: "Upcoming Exams",
          ctatext: "See more",
          onPressed: null,
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 30,
                color: kShadowColor,
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
          //style: tListTextStyle,
        ),
        Text(
          "in " + examIn + " days | " + examDateFormat,
          //style: tListTextStyle,
        ),
      ],
    );
  }
}
