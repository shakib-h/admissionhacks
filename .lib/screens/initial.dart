import 'dart:io';
import 'package:admissionhacks/components/constant.dart';
import 'package:admissionhacks/screens/admit.dart';
import 'package:admissionhacks/screens/home.dart';
import 'package:admissionhacks/screens/news.dart';
import 'package:admissionhacks/screens/notifications.dart';
import 'package:admissionhacks/screens/study.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
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
      duration: const Duration(milliseconds: 400),
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
            decoration: BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  blurRadius: 3.0,
                  offset: Offset(0, 0),
                  color: Colors.black45,
                ),
              ],
            ),
            child: SnakeNavigationBar.color(
              elevation: 0,
              // height: 80,
              behaviour: SnakeBarBehaviour.pinned,
              //shape: RoundedRectangleBorder(
              //borderRadius: BorderRadius.all(Radius.circular(25)),
              //),
              snakeShape: SnakeShape.indicator,
              padding: EdgeInsets.zero,
              snakeViewColor: Colors.black,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black87,
              showUnselectedLabels: true,
              showSelectedLabels: true,
              currentIndex: _selectedIndex,
              onTap: _onTapped,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(LineIcons.home), label: 'হোম'),
                BottomNavigationBarItem(
                    icon: Icon(LineIcons.graduationCap), label: 'ভর্তি'),
                BottomNavigationBarItem(
                    icon: Icon(LineIcons.bookOpen), label: 'স্টাডি'),
                BottomNavigationBarItem(
                    icon: Icon(LineIcons.newspaper), label: 'নিউজ'),
              ],
            ),
          )),
    );
  }
}
