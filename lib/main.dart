import 'package:flutter/material.dart';
import 'package:tech_linker_new/screens/Splash_screenOne.dart';
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
      home: ScreenOne(),
    );
  }
}




