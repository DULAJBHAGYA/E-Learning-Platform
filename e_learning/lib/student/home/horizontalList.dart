import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';

class HorizontalListview extends StatelessWidget {
  const HorizontalListview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Popular Courses', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: black),),

                Spacer(),

                Text('See All', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: darkblue),),
              ],
            ),
    
            SizedBox(height:10),
    
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: darkblue, width: 2),
                    ),
                    child: Text('ALL COURSES 🔥', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: darkblue),),
                  ),
    
                  SizedBox(width: 10),
    
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: darkblue, width: 2),
                    ),
                    child: Text('DATA SCIENCE 📈', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: darkblue),),
                  ),
    
                  SizedBox(width: 10),
    
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: darkblue, width: 2),
                    ),
                    child: Text('MACHINE LEARNING 👨‍💻', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: darkblue),),
                  ),
    
                  SizedBox(width: 10),
    
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: darkblue, width: 2),
                    ),
                    child: Text('ARTIFICIAL INTELLIGENCE 🤖', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: darkblue),),
                  ),
    
                  SizedBox(width: 10),
    
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: darkblue, width: 2),
                    ),
                    child: Text('CYBER SECURITY 🔒', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: darkblue),),
                  ),
                  
                ],
              )
            )
          ],
        ),
      );
  }
}