import 'package:admissionhacks/ui/quiz/quizList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChapterList extends StatelessWidget {
  final String subject;
  final String path;
  final String title;
  const ChapterList({
    Key? key,
    required this.subject,
    required this.path,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
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
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('subjects')
                .doc(path)
                .collection('chapters')
                .orderBy('chapter')
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
                    String title = quizData['name'];
                    int chapter = quizData['chapter'];
                    String subtitle = quizData['desc'];
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizList(
                                title: title,
                                subject: subject,
                                chapter: chapter,
                              ),
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
        ],
      ),
    );
  }
}
