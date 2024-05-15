import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';
import '../../shared/bottomNavBar.dart';

class StudentProfile extends StatelessWidget {
  const StudentProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              child: Column(
                children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('MyProfile', style: GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.w600, color: black),),

                        Spacer(),

                        Icon(EneftyIcons.login_2_outline, size: 25, color: black,),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 20,),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: CircleAvatar( 
                        radius: 100,  
                        backgroundImage: AssetImage('/images/user.png'),
                      ),
                    )
                  ],
                ),

                SizedBox(height: 20,),

                Container(  
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: lightgrey,
                  ),
                  child: Column(
                    children: [

                      SizedBox(height: 20,),
                    ],
                  )
                )

              ]
              ),
            )
            ),

        bottomNavigationBar: BottomNavBar(),
            );
  }
}
