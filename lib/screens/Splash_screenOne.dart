import 'package:flutter/material.dart';
import 'package:tech_linker_new/screens/Splash_ScreenTwo.dart';
import 'package:tech_linker_new/widget/coustomElevated_Button.dart';
class ScreenOne extends StatelessWidget {
  const ScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('assets/techLogo.jpeg'),
                ),
                SizedBox(height: 20),
                Text(
                  'TechLinker',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'From Dreams to Direction',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    'TechLinker is your guide. Explore internships\nthat match your passion and skills.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: 150),
                CustomElevatedButton(text: 'Get Started', onPressed: (){ Navigator.of(context).push(_modernRoute());})
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 👇 MODERN Slide + Fade + Scale Animation
  Route _modernRoute() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 600),
      opaque: true,
      pageBuilder: (context, animation, secondaryAnimation) {
        return const ScreenTwo();
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(1.0, 0.0), // From right
          end: Offset.zero,
        ).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOut),
        );

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }





}
