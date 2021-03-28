import 'package:flutter/material.dart';
import 'package:matrix/widgets/customappbar.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppbar(
          textTop: "Quiz",
        ),
      ],
    );
  }
}
