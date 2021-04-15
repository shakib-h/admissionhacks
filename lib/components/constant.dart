import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

// Colors
const tBackgroundColor = Color(0xFFFEFEFE);
const tTitleTextColor = Color(0xFF303030);
const tListTextColor = Color(0xFF303030);
const tBodyTextColor = Color(0xFF4B4B4B);
const tTextLightColor = Color(0xFF959595);
const tPrimaryColor = Color(0xFF3382CC);
const tClusterColor = Color(0xFFFF8748);
const tPublishedColor = Color(0xFF00BFA6);
const tApplyColor = Color(0xFF36C12C);
const tEndedColor = Color(0xFFFF4848);
final tShadowColor = Color(0xFFB7B7B7).withOpacity(.16);
final tActiveShadowColor = Color(0xFF4056C6).withOpacity(.15);

// Text Style
const tHeadingTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w600,
);

const tTagTextStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
);

const tSubTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.normal,
  color: tTextLightColor,
);

const tTitleTextstyle = TextStyle(
  fontSize: 18,
  color: tTitleTextColor,
  fontWeight: FontWeight.bold,
);

const tListTextStyle = TextStyle(
  fontSize: 16,
  color: tListTextColor,
);

String wdProject = 'admission-hacks-0f8eae9';
String wdSecret = 'aux0d47ofch32v8rdj0gkj8mroqqzbvb5q0gg8gpl3mnmtqz';

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

String adUnitHome =
    "ca-app-pub-3940256099942544/6300978111"; //"ca-app-pub-1168036738005034/4058889704";
String adUnitBrowser =
    "ca-app-pub-3940256099942544/6300978111"; //"ca-app-pub-1168036738005034/6711585060";
String adUnitArticle =
    "ca-app-pub-3940256099942544/6300978111"; //"ca-app-pub-1168036738005034/4206794938";
String adUnitInterstitial =
    "ca-app-pub-3940256099942544/1033173712"; //"ca-app-pub-1168036738005034/8255766870";

String buildVersion = "1";
String buildNumber = "1";
