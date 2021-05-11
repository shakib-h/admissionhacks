import 'dart:io';
import 'package:admissionhacks/shared/constant.dart';
import 'package:admissionhacks/screens/admit.dart';
import 'package:admissionhacks/screens/home.dart';
import 'package:admissionhacks/screens/news.dart';
import 'package:admissionhacks/screens/notifications.dart';
import 'package:admissionhacks/screens/study.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  int _selectedIndex = 0;
  bool _notifications = true;

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

  final List<Widget> _screens = <Widget>[
    HomeScreen(),
    AdmitScreen(),
    StudyScreen(),
    NewsScreen(),
  ];

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            content: Text(
              'Are you sure you want to close the app?',
            ),
            insetPadding: EdgeInsets.zero,
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('NO'),
              ),
              TextButton(
                onPressed: () => exit(0),
                /*Navigator.of(context).pop(true)*/
                child: Text('YES'),
              ),
            ],
            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          ),
        )) ??
        false;
  }

  final String _teemteem = 'https://teemteem.com';
  final String _feedback = Uri(
          scheme: 'mailto',
          path: 'app@admissionhacks.com',
          query: 'subject=AdmissionHacks Feedback&body=App Version ')
      //TODO:$buildVersion.$buildNumber versioning
      .toString();

  void _launchTeemteem() async => await canLaunch(_teemteem)
      ? await launch(_teemteem)
      : throw 'Could not launch $_teemteem';

  void _launchFeedback() async => await canLaunch(_feedback)
      ? await launch(_feedback)
      : throw 'Could not launch $_feedback';

  _showPopupMenu() {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(0.0, 50.0, 25.0,
          0.0), //position where you want to show the menu on screen
      items: [
        PopupMenuItem(
          value: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                LineIcons.envelope,
                color: Colors.black,
              ),
              Text(" Give Feedback")
            ],
          ),
        ),
        PopupMenuItem(
          value: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                LineIcons.infoCircle,
                color: Colors.black,
              ),
              Text(" About App")
            ],
          ),
        ),
      ],
      elevation: 10,
    ).then<void>((value) {
      if (value == 0) {
        _launchFeedback();
      }
      if (value == 1) {
        //showDialog(
        //context: context,
        //builder: (BuildContext context) => CustomAboutDialog(
        //launchFeedback: _launchFeedback,
        //launchTeemteem: _launchTeemteem,
        //),
        return null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(LineIcons.bars, size: 25),
            tooltip: 'মেনু',
            onPressed: () {
              _showPopupMenu();
            },
          ),
          centerTitle: true,
          title: Text(
            "Admission Hacks",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
          actions: [
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoticationsScreen(),
                      ));
                },
              ),
            ),
          ],
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: tBackgroundColor,
          elevation: 0,
        ),
        body: PageView(
          children: _screens,
          onPageChanged: _onPageChanged,
          controller: _pageController,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
          ]),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
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
                ],
                selectedIndex: _selectedIndex,
                onTabChange: _onTapped,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
