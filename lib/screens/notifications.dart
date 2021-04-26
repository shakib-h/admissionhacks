import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoticationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Column(
        children: [
          Container(
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('notifications')
                  .orderBy('time')
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return LinearProgressIndicator();
                } else {
                  return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                      itemBuilder: (_, index) {
                        QueryDocumentSnapshot notificationData =
                            (snapshot.data! as QuerySnapshot).docs[index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              notificationData["content"],
                            )
                          ],
                        );
                      });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
