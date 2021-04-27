import 'dart:io';
import 'package:admissionhacks/components/constant.dart';
import 'package:admissionhacks/screens/explore.dart';
import 'package:admissionhacks/screens/home.dart';
import 'package:admissionhacks/screens/news.dart';
import 'package:admissionhacks/screens/notifications.dart';
import 'package:admissionhacks/screens/practice.dart';
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

  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    PracticeScreen(),
    NewsScreen(),
    ExploreScreen(),
  ];

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: Text(
              'Are you sure you want to close the app?',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
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
      position: RelativeRect.fromLTRB(25.0, 50.0, 0.0,
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
              IconButton(
                icon: Stack(
                  children: [
                    Icon(LineIcons.bell, size: 25),
                    _notifications != false
                        ? Positioned(
                            child: Icon(
                              Icons.brightness_1,
                              size: 8,
                              color: Colors.red,
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
            ],
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: tBackgroundColor,
            elevation: 0,
          ),
          body: _widgetOptions[_selectedIndex],
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
              onTap: (index) => setState(() => _selectedIndex = index),
              items: [
                BottomNavigationBarItem(
                    icon: Icon(LineIcons.home), label: 'হোম'),
                BottomNavigationBarItem(
                    icon: Icon(LineIcons.graduationCap), label: 'প্র্যাকটিস'),
                BottomNavigationBarItem(
                    icon: Icon(LineIcons.newspaper), label: 'নিউজ'),
                BottomNavigationBarItem(
                    icon: Icon(LineIcons.compass), label: 'এক্সপ্লোর'),
              ],
            ),
          )),
    );
  }
}
