import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:admissionhacks/widgets/constant.dart';

class OpenBrowser extends StatelessWidget {
  final String url;
  final String text;
  const OpenBrowser({
    Key key,
    this.url,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (Platform.isAndroid) ...[
          ElevatedButton(
            onPressed: () {
              FlutterWebBrowser.openWebPage(
                url: url,
                customTabsOptions: CustomTabsOptions(
                  toolbarColor: tPrimaryColor,
                  //secondaryToolbarColor: Colors.green,
                  //navigationBarColor: Colors.amber,
                  addDefaultShareMenuItem: true,
                  instantAppsEnabled: true,
                  showTitle: true,
                  urlBarHidingEnabled: true,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(fontFamily: "Kalpurush", fontSize: 20),
              ),
            ),
          ),
        ],
        if (Platform.isIOS) ...[
          ElevatedButton(
            onPressed: () {
              FlutterWebBrowser.openWebPage(
                url: url,
                safariVCOptions: SafariViewControllerOptions(
                  barCollapsingEnabled: true,
                  //preferredBarTintColor: Colors.green,
                  //preferredControlTintColor: Colors.amber,
                  dismissButtonStyle:
                      SafariViewControllerDismissButtonStyle.close,
                  modalPresentationCapturesStatusBarAppearance: true,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: tHeadingTextStyle,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
