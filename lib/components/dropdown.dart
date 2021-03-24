import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matrix/components/constant.dart';
import 'package:matrix/components/dot.dart';

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
            color: kPrimaryColor,
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
                'SSC',
                'HSC',
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
