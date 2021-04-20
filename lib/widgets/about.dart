import 'package:flutter/material.dart';
import 'package:admissionhacks/components/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAboutDialog extends StatelessWidget {
  final String _teemteem = 'https://teemteem.com';
  final String _feedback = Uri(
    scheme: 'mailto',
    path: 'app@admissionhacks.com',
    query:
        'subject=AdmissionHacks Feedback&body=App Version $buildVersion.$buildNumber',
  ).toString();

  void _launchTeemteem() async => await canLaunch(_teemteem)
      ? await launch(_teemteem)
      : throw 'Could not launch $_teemteem';

  void _launchFeedback() async => await canLaunch(_feedback)
      ? await launch(_feedback)
      : throw 'Could not launch $_feedback';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: Consts.avatarRadius + Consts.padding,
              bottom: Consts.padding,
              left: Consts.padding,
              right: Consts.padding,
            ),
            margin: EdgeInsets.only(top: Consts.avatarRadius),
            decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(Consts.padding),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                Text(
                  "Admission Hacks",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  "We developed this app to help admission candidates with the latest admission updates and news.\n\nThanks for being a part of the Admission Hacks family.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 30.0),
                TextButton(
                  onPressed: _launchTeemteem,
                  child: Column(
                    children: [
                      Text(
                        "a teemteem.com production",
                        style: tTitleTextstyle,
                      ),
                      Text(
                        "tap to learn more",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: _launchFeedback,
                      child: Text("Send Feedback"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // To close the dialog
                      },
                      child: Text("Okay"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                backgroundColor: tPrimaryColor,
                foregroundImage: AssetImage("assets/images/logo_splash.png"),
                radius: Consts.avatarRadius,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 64.0;
}
