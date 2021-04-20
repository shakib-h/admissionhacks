import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:admissionhacks/widgets/constant.dart';
import 'package:admissionhacks/screens/article.dart';
import 'package:admissionhacks/widgets/customappbar.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsPage extends StatelessWidget {
  const NewsPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppbar(
          textTop: "News",
        ),
        FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('news-articles')
              .orderBy('timestamp', descending: true)
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return LinearProgressIndicator(
                backgroundColor: tPrimaryColor,
              );
            } else {
              return ListView.separated(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                separatorBuilder: (context, index) => Divider(
                  indent: 10,
                  endIndent: 10,
                  color: Colors.black26,
                ),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (_, index) => NewsTile(
                  data: snapshot.data.docs[index],
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

class NewsTile extends StatelessWidget {
  NewsTile({this.data});

  final data;

  @override
  Widget build(BuildContext context) {
    String titleData, imageUrlData, dateData;

    titleData = data['title'];

    imageUrlData = data['image-url'];

    DateTime dateFetch = data['timestamp'].toDate();
    dateData = timeago.format(dateFetch);

    return TextButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  dateData,
                  style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Wrap(
                  children: <Widget>[
                    Text(
                      titleData,
                      style: TextStyle(
                        fontSize: 20,
                        color: tTitleTextColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Kalpurush",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Hero(
                tag: titleData,
                child: CachedNetworkImage(
                  imageUrl: imageUrlData,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(
                    Icons.broken_image,
                    size: 40,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticlePage(
              data: data,
              title: "News",
            ),
          ),
        );
      },
    );
  }
}
