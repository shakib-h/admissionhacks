import 'package:flutter/material.dart';
import 'package:matrix/widgets/customappbar.dart';
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
        ),
        body: IndexedStack(index: position, children: <Widget>[
          WebView(
              initialUrl: url,
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
                        content:
                            Text("Something went wrong.\nPlease try again."),
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
          Container(
            color: Colors.white,
            child: Center(child: CircularProgressIndicator()),
          ),
        ]));
  }
}
