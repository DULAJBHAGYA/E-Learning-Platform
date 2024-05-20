import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

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
              Image.asset('/images/intro2.png'),
              SizedBox(height: 20,),
              Text("Grow Your Skills", textAlign: TextAlign.center, style: GoogleFonts.nunito(fontSize: 25, fontWeight: FontWeight.w800),),
              SizedBox(height: 20,),
              Text('Enhance your skills with top-notch content and advance your career.',textAlign: TextAlign.center, style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w400),),
            ],
          ),
        ),
      ),
    );
  }
}