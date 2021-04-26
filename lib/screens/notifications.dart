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
          Text("data"),
          FutureBuilder(
            future:
                FirebaseFirestore.instance.collection('notifications').get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return LinearProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.black12,
                  ),
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
                    itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                    itemBuilder: (_, index) {
                      QueryDocumentSnapshot notificationData =
                          (snapshot.data! as QuerySnapshot).docs[index];
                      return Row(
                        children: [
                          Text(
                            notificationData["content"],
                          ),
                          Text("data")
                        ],
                      );
                    });
              }
            },
          ),
        ],
      ),
    );
  }
}
