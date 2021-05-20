import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admissionhacks/constants.dart';
import 'package:admissionhacks/main.dart';
import 'package:admissionhacks/model/user.dart';
import 'package:admissionhacks/services/authenticate.dart';
import 'package:admissionhacks/services/helper.dart';
import 'package:admissionhacks/ui/auth/authScreen.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State createState() {
    return _ProfileState(user);
  }
}

class _ProfileState extends State<ProfileScreen> {
  final User user;

  _ProfileState(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Drawer Header',
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                color: Color(COLOR_PRIMARY),
              ),
            ),
            ListTile(
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.black),
              ),
              leading: Transform.rotate(
                  angle: pi / 1,
                  child: Icon(Icons.exit_to_app, color: Colors.black)),
              onTap: () async {
                user.active = false;
                user.lastOnlineTimestamp = Timestamp.now();
                FireStoreUtils.updateCurrentUser(user);
                await auth.FirebaseAuth.instance.signOut();
                MyAppState.currentUser = null;
                pushAndRemoveUntil(context, AuthScreen(), false);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            tooltip: 'Open shopping cart',
            onPressed: () {
              // handle the press
              push(context, ProfileScreen(user: user));
            },
          ),
        ],
      ),
      body: Center(
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
          ],
        ),
      ),
    );
  }
}
