import 'package:flutter/material.dart';
import 'package:matrix/widgets/customappbar.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppbar(
          textTop: "Explore",
        ),
      ],
    );
  }
}
