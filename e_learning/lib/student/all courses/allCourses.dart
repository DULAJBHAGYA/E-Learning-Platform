import 'package:e_learning/shared/searchBar.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';
import '../../shared/bottomNavBAr.dart';

class StdAllCourses extends StatelessWidget {
  const StdAllCourses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('AllCourses', style: GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.w600, color: black),),

            SizedBox(height: 20,),

            CustomSearchBar(),

            SizedBox(height: 20,),

            HorizontalListview(),

            SizedBox(height: 20,),

            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    CourseViewCard(),
                    SizedBox(height: 20,),
                    CourseViewCard(),
                    SizedBox(height: 20,),
                    CourseViewCard(),
                    SizedBox(height: 20,),
                    CourseViewCard(),
                    SizedBox(height: 20,),
                    CourseViewCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}


class CourseViewCard extends StatelessWidget {
  const CourseViewCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: background,
      ),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.zero,
                image: DecorationImage(
                  image:AssetImage('/images/aibasic.png'),
                  fit: BoxFit.cover
            )
              )),
    
            SizedBox(height: 0,),
    
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: lightblue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('Machine Learning', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: darkblue),),
                  ),
                
        
            SizedBox(height: 5),
    
            Text('Machine Learning Basic', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: black),),
        
            SizedBox(height: 5),
    
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                      width: 150,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: darkblue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('View Course', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: white),),
                    ),
            ),
    
            ],
              ),
        
            ),
    
    
      ]))
    );
  }
}




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
    
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: darkblue, width: 2),
                    ),
                    child: Text('All Courses', style: GoogleFonts.sourceSans3(fontSize: 15, fontWeight: FontWeight.w600, color: darkblue),),
                  ),
    
                  SizedBox(width: 10),
    
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: darkblue, width: 2),
                    ),
                    child: Text('Data Science', style: GoogleFonts.sourceSans3(fontSize: 15, fontWeight: FontWeight.w600, color: darkblue),),
                  ),
    
                  SizedBox(width: 10),
    
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: darkblue, width: 2),
                    ),
                    child: Text('Machine Learning', style: GoogleFonts.sourceSans3(fontSize: 15, fontWeight: FontWeight.w600, color: darkblue),),
                  ),
    
                  SizedBox(width: 10),
    
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: darkblue, width: 2),
                    ),
                    child: Text('Artificial Intelligence', style: GoogleFonts.sourceSans3(fontSize: 15, fontWeight: FontWeight.w600, color: darkblue),),
                  ),
    
                  SizedBox(width: 10),
    
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: darkblue, width: 2),
                    ),
                    child: Text('Cyber Security', style: GoogleFonts.sourceSans3(fontSize: 15, fontWeight: FontWeight.w600, color: darkblue),),
                  ),
                  
                ],
              )
            )
          ],
        ),
      );
  }
}
