import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:matrix/components/constant.dart';
import 'package:matrix/widgets/bannerAds.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Browser extends StatefulWidget {
  final String url;
  final String title;
  const Browser({
    Key key,
    this.url,
    this.title,
  }) : super(key: key);

  @override
  _BrowserState createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  WebViewController webView;

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
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Expanded(
              child: IndexedStack(index: position, children: <Widget>[
                WebView(
                    initialUrl: widget.url,
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
                                  "Something went wrong. Please try again."),
                              action: SnackBarAction(
                                label: "Retry",
                                onPressed: () {
                                  webView.loadUrl(widget.url);
                                },
                              ),
                            ),
                          );
                        }
                      });
                    }),
                Container(
                  color: Colors.white,
                  child: Center(child: CircularProgressIndicator()),
                ),
              ]),
            ),
            BannerAds(
              adUnit: adUnitBrowser,
              adSize: AdSize.fullBanner,
            ),
          ],
        ));
  }
}
