import 'package:matrix/components/constant.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String textTop;
  final IconData icon;
  final Function onpress;
  const CustomAppbar({
    Key key,
    this.textTop,
    this.icon,
    this.onpress,
  }) : super(key: key);

  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 40, right: 20),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF3383CD),
            Color(0xFF11249F),
          ],
        ),
        image: DecorationImage(
          image: AssetImage("assets/images/dots.png"),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(textTop,
              style: tHeadingTextStyle.copyWith(
                color: Colors.white,
              )),
          GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.white,
                ),
              ],
            ),
            onTap: onpress,
          ),
        ],
      ),
    );
  }
}
