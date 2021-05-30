import 'package:admissionhacks/main.dart';
import 'package:admissionhacks/model/user.dart';
import 'package:admissionhacks/services/authenticate.dart';
import 'package:admissionhacks/services/helper.dart';
import 'package:admissionhacks/ui/auth/authScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final User user;

  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          displayCircleImage(user.profilePictureURL, 125, false),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(user.firstName),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(user.email),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(user.phoneNumber),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(user.userID),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Text("Logout"),
              onPressed: () async {
                user.active = false;
                user.lastOnlineTimestamp = Timestamp.now();
                FireStoreUtils.updateCurrentUser(user);
                await auth.FirebaseAuth.instance.signOut();
                MyAppState.currentUser = null;
                pushAndRemoveUntil(context, AuthScreen(), false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
