import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, 
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Image.asset('assets/images/intro1.png'),
              SizedBox(height: 20,),
              Text("Learn Anytime, Anywhere", textAlign: TextAlign.center, style: GoogleFonts.nunito(fontSize: 25, fontWeight: FontWeight.w800),),
              SizedBox(height: 20,),
              Text('Access a variety of courses and learn from experts from the comfort of your home.',textAlign: TextAlign.center, style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w400),),
            ],
          ),
        ),
      ),
    );
  }
}