import 'package:flutter/material.dart';
import 'package:tech_linker_new/screens/Splash_ScreenThree.dart';
import 'package:tech_linker_new/widget/coustomElevated_Button.dart';

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [ Color(0xff0E5D95),
              Color(0xff3978A9),
              Color(0xff0A5A95),],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Main Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Discover The\nRight Internship',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                    height: 1.3,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Image
              Center(
                child: Image.asset(
                  'assets/techLink.png',
                  width: 280,
                  height: 280,
                ),
              ),

              const SizedBox(height: 30),

              // Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  'Match your skills with top\nsoftware houses and institutes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              const Spacer(),

              // Button
              CustomElevatedButton(text:  'Let\'s Get Started', onPressed:(){ Navigator.of(context).push(_modernRoute());}),


              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
  Route _modernRoute() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 600),
      opaque: true,
      pageBuilder: (context, animation, secondaryAnimation) {
        return const ScreenThree();
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
