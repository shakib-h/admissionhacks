import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SubtopicList extends StatelessWidget {
  final String id;
  final String path;
  final String topic;
  const SubtopicList({
    Key? key,
    required this.id,
    required this.path,
    required this.topic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          topic,
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
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
                  .collection('topics')
                  .doc(path)
                  .collection('subtopics')
                  //.orderBy('order')
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
                      QueryDocumentSnapshot quizData =
                          (snapshot.data! as QuerySnapshot).docs[index];
                      String title = quizData['title'];
                      String subtitle = quizData['sub'];
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
                          trailing: TextButton(
                            onPressed: null,
                            child: Text(
                              "START",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: EdgeInsets.zero,
                              visualDensity:
                                  VisualDensity(horizontal: 0, vertical: -2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                          ),
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
