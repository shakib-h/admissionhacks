import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrix/components/constant.dart';
import 'package:matrix/components/heading.dart';

class UpcomingExams extends StatelessWidget {
  const UpcomingExams({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Heading(
          heading: "Upcoming Exams",
          ctatext: "See details",
          onPressed: null,
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.all(20),
          height: 178,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 30,
                color: kShadowColor,
              ),
            ],
          ),
          child: SvgPicture.asset(
            "assets/images/banner/undraw_exams_g4ow.svg",
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
