import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAds extends StatelessWidget {
  final String adUnit;
  final AdSize adSize;
  //final VoidCallback onPressed;
  const BannerAds({
    Key key,
    this.adUnit,
    this.adSize,
    //this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AdListener listener = AdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) => {},
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {},
      // Called when an ad opens an overlay that covers the screen.
      onAdOpened: (Ad ad) => {},
      // Called when an ad removes an overlay that covers the screen.
      onAdClosed: (Ad ad) => {},
      // Called when an ad is in the process of leaving the application.
      onApplicationExit: (Ad ad) => {},
    );

    final BannerAd myBanner = BannerAd(
      adUnitId: adUnit,
      size: adSize,
      request: AdRequest(),
      listener: listener,
    );

    myBanner.load();

    final AdWidget adWidget = AdWidget(ad: myBanner);

    final Container adContainer = Container(
      alignment: Alignment.center,
      child: adWidget,
      width: myBanner.size.width.toDouble(),
      height: myBanner.size.height.toDouble(),
    );

    return adContainer;
  }
}
