import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 24.3 / 9,
            child: FutureBuilder(
              future:
                  FirebaseFirestore.instance.collection('home_slider').get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return LinearProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.black12,
                    ),
                  );
                } else {
                  return CarouselSlider.builder(
                    slideBuilder: (index) {
                      QueryDocumentSnapshot sliderData =
                          (snapshot.data! as QuerySnapshot).docs[index];
                      return Container(
                        margin: EdgeInsets.fromLTRB(7.5, 15, 7.5, 15),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(5, 5),
                              blurRadius: 5,
                              color: Colors.black12,
                            ),
                          ],
                          border: Border.all(color: Colors.black12, width: 0.5),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              sliderData["img-url"],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                    slideIndicator: CircularWaveSlideIndicator(
                      padding: EdgeInsets.only(bottom: 20),
                      indicatorBackgroundColor: Colors.white,
                      currentIndicatorColor: Colors.black,
                      indicatorRadius: 3,
                      indicatorBorderWidth: 0,
                      indicatorBorderColor: Colors.transparent,
                    ),
                    enableAutoSlider: true,
                    unlimitedMode: true,
                    viewportFraction: 0.8,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
