import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:matrix/widgets/admissionnews.dart';
import 'package:matrix/widgets/admissionupdate.dart';
import 'package:matrix/widgets/upcomingexams.dart';
import 'package:matrix/components/constant.dart';
import 'package:matrix/components/dropdown.dart';
import 'package:matrix/components/heading.dart';
import 'package:matrix/components/headingtag.dart';
import 'package:matrix/widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = ScrollController();
  double offset = 0;
  int _selectedIndex = 0;
  final firestoreInstance = FirebaseFirestore.instance;

  void _onPressed() {}

  @override
  void initState() {
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: <Widget>[
            MyHeader(
              image: "assets/images/banner/undraw_studying_s3l7.svg",
              textTop: "Admission ____",
              textBottom: "fine tune your preparation",
              offset: offset,
            ),
            Dropdown(),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  HeadingTag(
                    heading: "Admission Update\n",
                    tag: "Newest update March 28",
                    ctatext: "See details",
                    onPressed: _onPressed,
                  ),
                  SizedBox(height: 20),
                  AdmissionUpdate(
                    cluster: 6,
                    published: 7,
                    formfillup: 9,
                    ended: 10,
                  ),
                  SizedBox(height: 20),
                  Heading(
                    heading: "Upcoming Exams",
                    ctatext: "See details",
                    onPressed: _onPressed,
                  ),
                  UpcomingExams(),
                  SizedBox(height: 20),
                  Heading(
                    heading: "Admission News",
                    ctatext: "See details",
                    onPressed: _onPressed,
                  ),
                  AdmissionNews(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                rippleColor: Colors.grey[300],
                hoverColor: Colors.grey[100],
                gap: 8,
                activeColor: kPrimaryColor,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: kShadowColor,
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.laptop,
                    text: 'Likes',
                  ),
                  GButton(
                    icon: Icons.search,
                    text: 'Search',
                  ),
                  GButton(
                    icon: Icons.query_builder,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }
}
