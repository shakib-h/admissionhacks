import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class AppBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(LineIcons.graduationCap, size: 20), label: 'Topics'),
        BottomNavigationBarItem(
            icon: Icon(LineIcons.info, size: 20), label: 'About'),
        BottomNavigationBarItem(
            icon: Icon(LineIcons.userCircle, size: 20), label: 'Profile'),
      ].toList(),
      fixedColor: Colors.deepPurple[200],
      onTap: (int idx) {
        switch (idx) {
          case 0:
            // do nuttin
            break;
          case 1:
            Navigator.pushNamed(context, '/about');
            break;
          case 2:
            Navigator.pushNamed(context, '/profile');
            break;
        }
      },
    );
  }
}
