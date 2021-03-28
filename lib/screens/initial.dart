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
  final controller = ScrollController();
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    QuizPage(),
    NewsPage(),
    ExplorePage(),
  ];

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
        //child: AnimatedSwitcher(
        //duration: const Duration(milliseconds: 500),
        //transitionBuilder: (Widget child, Animation<double> animation) {
        //return ScaleTransition(child: child, scale: animation);
        //},
        child: _widgetOptions[_selectedIndex],
        //),
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
                activeColor: tPrimaryColor,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100],
                tabs: [
                  GButton(
                    icon: Icons.home_rounded,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.question_answer_rounded,
                    text: 'Quiz',
                  ),
                  GButton(
                    icon: Icons.text_snippet_rounded,
                    text: 'News',
                  ),
                  GButton(
                    icon: Icons.explore,
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
