import 'package:admissionhacks/ui/pages/admissionPage.dart';
import 'package:admissionhacks/ui/pages/homePage.dart';
import 'package:admissionhacks/ui/pages/newsPage.dart';
import 'package:admissionhacks/ui/pages/profilePage.dart';
import 'package:admissionhacks/ui/pages/studyPage.dart';
import 'package:line_icons/line_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:admissionhacks/ui/profile/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:admissionhacks/model/user.dart';
import 'package:admissionhacks/services/helper.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State createState() {
    return _HomeState(user);
  }
}

class _HomeState extends State<HomeScreen> {
  final User user;
  bool _notifications = true;
  int _selectedIndex = 0;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _HomeState(this.user);

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = <Widget>[
      HomePage(),
      AdmissionPage(),
      StudyPage(),
      NewsPage(),
      ProfilePage(user: user),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admission Hacks",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(LineIcons.bars, size: 25),
          tooltip: 'মেনু',
          onPressed: () {},
        ),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.account_circle),
          //   tooltip: 'Profile',
          //   onPressed: () {
          //     push(context, ProfileScreen(user: user));
          //   },
          // ),
          Padding(
            padding: const EdgeInsets.only(right: 3.5),
            child: IconButton(
              icon: Stack(
                children: [
                  Icon(LineIcons.bell, size: 25),
                  _notifications != false
                      ? Positioned(
                          child: Icon(
                            Icons.brightness_1,
                            size: 8,
                            color: Colors.redAccent,
                          ),
                          right: 0,
                          top: 0,
                        )
                      : Material(),
                ],
              ),
              tooltip: 'নোটিফিকেশন',
              onPressed: () {
                //
              },
            ),
          ),
        ],
      ),
      body: PageView(
        children: _pages,
        onPageChanged: _onPageChanged,
        controller: _pageController,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.redAccent,
              iconSize: 28,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'হোম',
                ),
                GButton(
                  icon: LineIcons.graduationCap,
                  text: 'ভর্তি',
                ),
                GButton(
                  icon: LineIcons.bookOpen,
                  text: 'স্টাডি',
                ),
                GButton(
                  icon: LineIcons.newspaper,
                  text: 'নিউজ',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'প্রোফাইল',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: _onTapped,
            ),
          ),
        ),
      ),
    );
  }
}
