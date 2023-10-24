import 'package:HackathonApp/pageviewbuilder/pageview.dart';
import 'package:flutter/material.dart';

import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterSplashScreen.gif(
        backgroundColor: Colors.white,
        gifPath: 'assets/blood-donation2.gif',
        gifWidth: 269,
        gifHeight: 474,
        // duration: const Duration(milliseconds: 3515),
        onInit: () async {
          debugPrint("onInit 1");
          await Future.delayed(const Duration(milliseconds: 3500));
          Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) =>  CustomPageView()),
  );
        },
        onEnd: () async {
          debugPrint("onEnd 1");
          debugPrint("onEnd 2");
        },
      ),
    );
  }
}