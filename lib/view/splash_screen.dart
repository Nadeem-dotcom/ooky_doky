import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ooky_doky/view/home_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacity = 0;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () async{    
      setState(() {
        opacity = 1;
      });
      await Future.delayed(const Duration(seconds: 2)).
      then((value) => Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => HomeScreen(),)));
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(seconds: 2),
          opacity: opacity,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/logo.png'),
              ),
            ],
          ),
        )
      ),
    );
  }
}