import 'package:flutter/material.dart';
import 'package:matrix/widgets/customappbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  num position = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppbar(
          textTop: "Quiz",
        ),
        Expanded(
          child: WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: 'https://google.com',
            onProgress: (int progress) {
              print("WebView is loading (progress : $progress%)");
            },
          ),
        ),
      ],
    );
  }
}
