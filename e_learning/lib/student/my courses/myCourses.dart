import 'package:e_learning/shared/bottomNavBAr.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';

class MyCourses extends StatelessWidget {
  const MyCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            children: [
              Text('My Courses', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: black),),
            ]
              //user info
          )
        )
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}