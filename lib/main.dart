import 'package:wiredash/wiredash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:admissionhacks/screens/initial.dart';
import 'package:admissionhacks/widgets/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Wiredash(
      projectId: wdProject,
      secret: wdSecret,
      navigatorKey: _navigatorKey,
      child: MaterialApp(
        themeMode: ThemeMode.light,
        theme: ThemeData(
          fontFamily: "Poppins",
        ),
        title: 'Admission Hacks',
        debugShowCheckedModeBanner: false,
        navigatorKey: _navigatorKey,
        home: InitialPage(),
      ),
    );
  }
}
