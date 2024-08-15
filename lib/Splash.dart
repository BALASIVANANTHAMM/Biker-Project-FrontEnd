import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:bike/userLogin.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.gif(
        gifPath: 'assets/Splash.gif',
        backgroundColor: Colors.black,
        nextScreen: const UserLogin(),
        duration: const Duration(milliseconds: 1515),
        onInit: () async {
          debugPrint("onInit");
        },
        onEnd: () async {
          debugPrint("onEnd 1");
        }, gifWidth: double.infinity, gifHeight: double.infinity,
      );
  }
}
