import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:matrix/components/openbrowser.dart';
import 'package:matrix/components/constant.dart';
import 'package:crypto/crypto.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticlePage extends StatefulWidget {
  ArticlePage({this.data, this.offline, this.title});

  final data, offline, title;

  @override
  State<StatefulWidget> createState() {
    return _ArticlePageState(
      data: data,
      offline: offline,
      title: title,
    );
  }
}

class _ArticlePageState extends State<ArticlePage>
    with SingleTickerProviderStateMixin {
  _ArticlePageState({this.data, this.offline, this.title});

  final data, offline, title;

  double lineLength = 0;

  Widget makeOfflineIcon = Icon(Icons.file_download);
  AnimationController _controller;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      value: 1,
    );
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => loopOnceAtStart(context));
  }

  Future<void> loopOnceAtStart(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    if (offline == true) {
      setState(() {
        makeOfflineIcon = Icon(Icons.delete_outline);
      });
    } else if (prefs.containsKey(generateMd5(data['title']))) {
      setState(() {
        makeOfflineIcon = Icon(Icons.offline_pin);
      });
    }

    await _controller.forward();
    await _controller.reverse();
    setState(() {
      lineLength = MediaQuery.of(context).size.width * 0.3;
    });
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String titleData, subTitleData, imageUrlData, bodyData, url;
    Widget imageWidget;
    List<String> dateAndTimeData;
    titleData = data['title'];
    if (data['sub-title'] != null) {
      subTitleData = data['sub-title'].replaceAll("\\n", "\n");
    } else {
      subTitleData = "";
      // allow full body to appear.
    }
    imageUrlData = data['image-url'] ?? '';
    bodyData = data['body'].replaceAll("\\n", "\n");
    url = data['url'];

    dateAndTimeData = <String>[
      DateFormat("dd MMM").format(data['timestamp'].toDate()),
      DateFormat.jm().format(data['timestamp'].toDate()),
    ];

    if (offline == true) {
      imageWidget = Hero(
        tag: generateMd5(titleData + "offline"),
        child: FadeInImage(
          placeholder: Image.asset('images/comingsoon-square.png').image,
          image: Image.memory(base64Decode(data["image-base64"])).image,
          fadeInDuration: Duration(milliseconds: 100),
          fadeInCurve: Curves.easeIn,
        ),
      );
    } else {
      imageWidget = Hero(
        tag: generateMd5(titleData),
        child: CachedNetworkImage(
          imageUrl: imageUrlData,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(
            Icons.broken_image,
            size: 40,
          ),
        ),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: tPrimaryColor,
        title: Text(
          title,
          style: TextStyle(letterSpacing: 3),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(13, 13, 13, 8),
            child: Text(
              titleData,
              style: TextStyle(
                fontFamily: 'Times New Roman',
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 16, top: 10, bottom: 25),
            child: AnimatedContainer(
              curve: Curves.easeOut,
              duration: Duration(milliseconds: 700),
              height: 8,
              width: lineLength,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.indigoAccent],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(13, 0, 13, 10),
            child: Text(
              dateAndTimeData[0] + ' • ' + dateAndTimeData[1].toUpperCase(),
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: imageWidget,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(13, 0, 13, 10),
            child: Text(
              subTitleData,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontStyle: FontStyle.italic,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              bodyData,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(15),
              child: OpenBrowser(
                text: "বিস্তারিত",
                url: url,
              )),
          Padding(
            padding: EdgeInsets.all(30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  width: 80,
                  height: 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1),
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade900, Colors.blue.shade400],
                    ),
                  ),
                ),
                Text(
                  "o",
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontSize: 13,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  width: 80,
                  height: 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1),
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade900, Colors.blue.shade400],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
