import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';

class CompletedCourses extends StatelessWidget {
  const CompletedCourses({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
          height: 170,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                //image
                Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('/images/mlbasic.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                  
                SizedBox(width: 20),
                  
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    
                  
                  
                    Text('HTML/CSS', style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.bold, color: black),),
                  
                    SizedBox(height: 5),

                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: background2,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    child: Text('IT', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.bold, color: lightgrey),),
                    ),

                    SizedBox(height: 10),
                  
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: darkblue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('Review Course', style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.w700, color: white),),
                    ),
                  ]
                ),
              
              ]
            ),
          )
        ),
    
        SizedBox(height: 20),
    
        Container(
          height: 170,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                //image
                Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('/images/mlbasic.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                  
                SizedBox(width: 20),
                  
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: lightblue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('Machine Learning', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: darkblue),),
                    ),
                  
                    SizedBox(height: 5),
                  
                    Text('Machine Learning \nBasic', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: black),),
                  
                    SizedBox(height: 5),
                  
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: darkblue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('View Details', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: white),),
                    ),
                  ]
                ),
              
              ]
            ),
          )
        ),
    
        ]
      ),
    );
  }
}
