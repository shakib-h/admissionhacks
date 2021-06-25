import 'package:admissionhacks/ui/quiz/subtopicList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                //.orderBy('end')
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
                    String subtitle = quizData['desc'];
                    String id = quizData['id'];
                    String path = quizData.reference.id;
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
                          debugPrint(id);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubtopicList(
                                id: id,
                                path: path,
                                topic: title,
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
        ),
      ],
    );
  }
}
