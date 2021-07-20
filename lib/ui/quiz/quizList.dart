import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuizList extends StatelessWidget {
  final String title;
  final String subject;
  final int chapter;
  const QuizList({
    Key? key,
    required this.title,
    required this.subject,
    required this.chapter,
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
                .collection('quizzes')
                .where("subject", isEqualTo: subject)
                .where("chapter", isEqualTo: chapter)
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
                    String name = quizData['title'];
                    String subtitle = "sub";
                    return Material(
                      color: Colors.transparent,
                      child: ListTile(
                        dense: true,
                        title: Text(
                          name,
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
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Starting " + title + " quiz."),
                          ));
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
