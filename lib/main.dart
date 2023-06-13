import 'package:flutter/cupertino.dart';
import 'package:ooky_doky/view/splash_screen.dart';

void main() async{

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp( 
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(brightness: Brightness.light),
      home:  const SplashScreen(),
    );
  }
}


