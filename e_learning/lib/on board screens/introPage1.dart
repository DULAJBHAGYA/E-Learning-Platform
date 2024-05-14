import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, 
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.asset('/images/intro1.png'),
            SizedBox(height: 20,),
            Text("Learn and Earn", style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            Text('loren ipsum ssssssssssssss ssssssssssssss sssssssssss sssssssssss', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w500),),
          ],
        ),
      ),
    );
  }
}