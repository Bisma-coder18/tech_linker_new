import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_linker_new/screens/Splash_screenOne.dart';
import 'package:tech_linker_new/screens/student/home/home.dart';
import 'package:tech_linker_new/screens/student/main_tab.dart';
import 'package:tech_linker_new/screens/student/onBoarding/onBoarding.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Container(
          decoration:  BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff0E5D95),
                Color(0xff3978A9),
                Color(0xff0A5A95),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: child,
        );
      },
      home: OnBoardingScreen(),
    );
  }
}




