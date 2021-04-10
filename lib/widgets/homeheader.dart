import 'package:matrix/components/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wiredash/wiredash.dart';

class HomeHeader extends StatelessWidget {
  final String image;
  final String textTop;
  final String textBottom;
  final double offset;
  const HomeHeader({
    Key key,
    this.image,
    this.textTop,
    this.textBottom,
    this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(left: 40, top: 50, right: 20),
        height: 350,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            PopupMenuButton(
              onSelected: (value) {
                if (value == 0) {
                  Wiredash.of(context).setBuildProperties(
                    buildNumber: buildNumber,
                    buildVersion: buildVersion,
                  );
                  Wiredash.of(context).show();
                }
              },
              child: SvgPicture.asset("assets/icons/menu.svg"),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(
                        Icons.offline_bolt,
                        color: Colors.black87,
                      ),
                      Text("Give Feedback")
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    //top: (widget.offset < 0) ? 0 : widget.offset,
                    child: SvgPicture.asset(
                      image,
                      width: 230,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  Positioned(
                    top: 35 - offset / 2,
                    right: 35,
                    child: Text(
                      textTop,
                      style: tHeadingTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 65 - offset / 2,
                    right: 35,
                    child: Text(
                      textBottom,
                      style: tTagTextStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
