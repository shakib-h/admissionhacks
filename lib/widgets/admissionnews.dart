import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matrix/components/constant.dart';
import 'package:matrix/components/heading.dart';
import 'package:matrix/screens/article.dart';
import 'package:matrix/screens/home.dart';
import 'package:timeago/timeago.dart' as timeago;

class AdmissionNews extends StatelessWidget {
  const AdmissionNews({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Heading(
          heading: "Admission News",
          ctatext: "See more",
          onPressed: null,
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.all(10),
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
          child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('news-articles')
                .limit(5)
                .orderBy('timestamp', descending: true)
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return LinearProgressIndicator(
                  backgroundColor: kPrimaryColor,
                );
              } else {
                return ListView.separated(
                  padding: EdgeInsets.zero,
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
    String titleData, subTitleData, imageUrlData, dateData;

    titleData = data['title'];
    if ((data['sub-title'] != null) && (data['sub-title'] != '')) {
      subTitleData = data['sub-title'];
    } else {
      subTitleData = data[
          'body']; // Overflow attribute will not allow full body to appear.
    }
    imageUrlData = data['image-url'];

    DateTime dateFetch = data['timestamp'].toDate();
    dateData = timeago.format(dateFetch);

    return FlatButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            //width: MediaQuery.of(context).size.width * 0.7,
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
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  subTitleData,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Hero(
                tag: generateMd5(titleData),
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
            builder: (context) => ArticlePage(data: data),
          ),
        );
      },
    );
  }
}
