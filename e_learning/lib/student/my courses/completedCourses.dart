import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
          height: 120,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                //image
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('/images/htmlcss.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                  
                SizedBox(width: 20),
                  
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                    
                    
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
                  
                      Spacer(),                  
                    
                      
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('Review Course', style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.w700, color: white),),
                        ),
                      
                    ]
                  ),
                ),
              
              ]
            ),
          )
        ),
    
        SizedBox(height: 5),

        Container(
          height: 120,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                //image
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('/images/photoshop.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                  
                SizedBox(width: 20),
                  
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                    
                    
                      Text('Photoshop Basics', style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.bold, color: black),),
                    
                      SizedBox(height: 5),
                  
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: background2,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      child: Text('OTHER', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.bold, color: lightgrey),),
                      ),
                  
                      Spacer(),                  
                    
                      
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('Review Course', style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.w700, color: white),),
                        ),
                      
                    ]
                  ),
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
