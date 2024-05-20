import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

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
              Image.asset('/images/intro3.jpg'),
              SizedBox(height: 20,),
              Text("Achieve Success", textAlign: TextAlign.center, style: GoogleFonts.nunito(fontSize: 25, fontWeight: FontWeight.w800),),
              SizedBox(height: 20,),
              Text('Gain the knowledge you need to achieve your personal and professional goals.',textAlign: TextAlign.center, style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.w400),),
            ],
          ),
        ),
      ),
    );
  }
}