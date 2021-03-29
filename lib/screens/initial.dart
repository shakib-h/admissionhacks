import 'package:line_icons/line_icons.dart';
import 'package:matrix/components/constant.dart';

import 'package:flutter/material.dart';
import 'package:matrix/screens/explore.dart';
import 'package:matrix/screens/home.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:matrix/screens/news.dart';
import 'package:matrix/screens/quiz.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  double offset = 0;
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    QuizPage(),
    NewsPage(),
    ExplorePage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
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
                activeColor: tPrimaryColor,
                iconSize: 28,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100],
                tabs: [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: LineIcons.graduationCap,
                    text: 'Quiz',
                  ),
                  GButton(
                    icon: LineIcons.newspaper,
                    text: 'News',
                  ),
                  GButton(
                    icon: LineIcons.compass,
                    text: 'Explore',
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
