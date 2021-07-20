import 'package:admissionhacks/ui/quiz/chapterList.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('subjects')
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
              return GridView.builder(
                padding: EdgeInsets.all(20),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 2.5,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                physics: BouncingScrollPhysics(),
                itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                itemBuilder: (_, index) {
                  QueryDocumentSnapshot quizData =
                      (snapshot.data! as QuerySnapshot).docs[index];
                  String name = quizData['name'];
                  String subtitle = quizData['desc'];
                  String subject = quizData['subject'];
                  String path = quizData.reference.id;
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    margin: EdgeInsets.zero,
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            'https://images.unsplash.com/photo-1579546929662-711aa81148cf?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&w=1000&q=80',
                          ),
                        ),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(5.0),
                        child: Container(
                          padding: EdgeInsets.all(0),
                          child: Text(name),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChapterList(
                                  subject: subject, path: path, title: name),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
}
