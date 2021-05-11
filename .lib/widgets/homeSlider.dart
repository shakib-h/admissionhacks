import 'package:admissionhacks/shared/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';

class HomeSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 24.3 / 9,
      child: FutureBuilder(
        future: FirebaseFirestore.instance.collection('home_slider').get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LinearProgressIndicator(
              backgroundColor: tBackgroundColor,
              valueColor: AlwaysStoppedAnimation<Color>(
                tShadowColor,
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
                    color: tShadowColor,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(5, 5),
                        blurRadius: 10,
                        color: tShadowColor,
                      ),
                    ],
                    border: Border.all(color: tShadowColor, width: 0.5),
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
                indicatorBackgroundColor: tBackgroundColor,
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
    );
  }
}
