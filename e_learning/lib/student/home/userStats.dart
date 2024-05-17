import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';

class UserStats extends StatelessWidget {
  const UserStats({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
    
              children: [
                
                Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: darkblue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        
                        Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('176', style: GoogleFonts.openSans(fontSize: 30, fontWeight: FontWeight.w900, color: white),),
                          Text('Courses', style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.bold, color: white),),
                        ],
                      ),
                      ]
                    ),    
                  )
                )  ,
    
                SizedBox(width: 10),
    
                Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: darkblue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('12', style: GoogleFonts.openSans(fontSize: 30, fontWeight: FontWeight.w900, color: white),),
                        Text('Registered \nCourses', textAlign: TextAlign.left, style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.bold, color: white),),
                      ],
                    ),    
                  )
                )  ,
    
                SizedBox(width: 10),
    
                Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: darkblue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('7', style: GoogleFonts.openSans(fontSize: 30, fontWeight: FontWeight.w900, color: white),),
                        Text('Ongoing \nCourses', style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.bold, color: white),),
                      ],
                    ),    
                  )
                )  
    
    
              ],
            ),
          ],    
    )
    ),
    
    
    );
  }
}