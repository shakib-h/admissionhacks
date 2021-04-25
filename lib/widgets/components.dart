import 'package:admissionhacks/widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Dot extends StatelessWidget {
  final Color color;
  const Dot({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      height: 25,
      width: 25,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(.26),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(
            color: color,
            width: 2,
          ),
        ),
      ),
    );
  }
}

class Dropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Color(0xFFE5E5E5),
        ),
      ),
      child: Row(
        children: <Widget>[
          Dot(
            color: tPrimaryColor,
          ),
          SizedBox(width: 20),
          Expanded(
            child: DropdownButton(
              isExpanded: true,
              underline: SizedBox(),
              icon: SvgPicture.asset("assets/icons/dropdown.svg"),
              value: "Undergraduate",
              items: [
                'Undergraduate',
                'Coming Soon',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                if (value != 'Undergraduate') {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Coming Soon")));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Counter extends StatelessWidget {
  final int number;
  final Color color;
  final String title;
  final Function() onpress;
  const Counter({
    Key? key,
    required this.number,
    required this.color,
    required this.title,
    required this.onpress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onpress,
      child: Column(
        children: <Widget>[
          Dot(
            color: color,
          ),
          SizedBox(height: 10),
          Text(
            "$number",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.normal,
              color: color,
            ),
          ),
          Text(title, style: tSubTextStyle),
        ],
      ),
    );
  }
}
