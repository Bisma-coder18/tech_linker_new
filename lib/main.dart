import 'package:flutter/material.dart';
import 'package:tech_linker_new/screens/Splash_screenOne.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Container(
          decoration:  BoxDecoration(
            // color: Color(0xff4B4DA4)
            gradient: LinearGradient(
              colors: [
                Color(0xff0E5D95),
                Color(0xff3978A9),
                Color(0xff0A5A95),
                // Color(0xff48AF91),
                // Color(0xff4D95AA),
                // Color(0xff3F9894),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            // gradient: LinearGradient(
            //   colors: [
            //     Color(0xFF38B4FE), // Light Blue
            //     Color(0xFF2683E1), // Medium Blue
            //     Color(0xFF1F69C8), // Dark Blue
            //   ],
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            // ),
          ),
          child: child,
        );
      },
      home: ScreenOne(),
    );
  }
}




