import 'package:admissionhacks/components/constant.dart';
import 'package:admissionhacks/widgets/bannerAds.dart';
import 'package:flutter/material.dart';
import 'package:admissionhacks/widgets/customappbar.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  WebViewController webView;
  String url = "https://app.admissionhacks.com/explore";

  num position = 1;

  final key = UniqueKey();

  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }

  startLoading(String A) {
    setState(() {
      position = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
            textTop: "Explore",
            icon: Icons.arrow_back,
            onpress: () async {
              if (await webView.canGoBack()) {
                webView.goBack();
              }
            }),
        body: IndexedStack(index: position, children: <Widget>[
          Column(
            children: [
              Expanded(
                child: WebView(
                    initialUrl: "https://admissionhacks.com",
                    userAgent: "admissionhacks",
                    javascriptMode: JavascriptMode.unrestricted,
                    onPageFinished: doneLoading,
                    onPageStarted: startLoading,
                    onWebViewCreated: (WebViewController controller) {
                      webView = controller;
                    },
                    onWebResourceError: (WebResourceError error) {
                      setState(() {
                        webView.loadUrl("about:blank");
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Something went wrong.\nPlease try again."),
                              action: SnackBarAction(
                                label: "Retry",
                                onPressed: () {
                                  webView.loadUrl(url);
                                },
                              ),
                            ),
                          );
                        }
                      });
                    }),
              ),
              BannerAds(
                adUnit: adUnitBrowser,
                adSize: AdSize.fullBanner,
              ),
            ],
          ),
          Container(
            color: Colors.white,
            child: Center(child: CircularProgressIndicator()),
          ),
        ]));
  }
}
