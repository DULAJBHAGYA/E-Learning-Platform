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
                Text('Most Popular Courses', style: GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.bold, color: black),),

                Spacer(),

                Text('See All', style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.bold, color: darkblue),),
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
                      color: background2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('ALL COURSES', style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.bold, color: lightgrey),),
                  ),
    
                  SizedBox(width: 10),
    
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: background2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('IT', style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.bold, color: lightgrey),),
                  ),
    
                  SizedBox(width: 10),
    
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: background2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('SCIENCE', style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.bold, color: lightgrey),),
                  ),
    
                  SizedBox(width: 10),
    
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: background2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('MATH', style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.bold, color: lightgrey),),
                  ),
    
                  SizedBox(width: 10),
    
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: background2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('LANGUAGE', style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.bold, color: lightgrey),),
                  ),

                  SizedBox(width: 10),
    
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: background2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('OTHER', style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.bold, color: lightgrey),),
                  ),
                  
                ],
              )
            )
          ],
        ),
      );
  }
}