import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:e_learning/on%20board%20screens/onBoardingScreens.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../color.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container( // Wrap with Container
      color: darkblue, // Set desired background color
      child: AnimatedSplashScreen(
        splash: Stack(
          children: [
            // Text
            Positioned.fill(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //ULearn text
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "U",
                          style: TextStyle(
                            color: lightblue,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: "Learn",
                          style: GoogleFonts.urbanist(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent, // Make the background of AnimatedSplashScreen transparent
        nextScreen: const OnBoardScreen(),
        duration: 4000,
        splashTransition: SplashTransition.fadeTransition,
        animationDuration: const Duration(seconds: 1),
      ),
    );
  }
}
