import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../color.dart';

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: Column(children: [
            Image.asset('/logos/logo.png', height: 250),
            Text('E-Learning Platform',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 40, fontWeight: FontWeight.bold, color: black)),
            const Text(
              'Learn Anytime, Anywhere',
              textAlign: TextAlign.center,
            )
          ]),
        ));
  }
}
