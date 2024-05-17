import 'package:e_learning/shared/searchBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

import '../../color.dart';
import '../../shared/bottomNavBAr.dart';

class StdAllCourses extends StatelessWidget {
  const StdAllCourses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: EdgeInsets.all(20), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('AllCourses', style: GoogleFonts.nunito(fontSize: 28, fontWeight: FontWeight.bold, color: black),),

            SizedBox(height: 10,),

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
        color: white,
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
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                image: DecorationImage(
                  image:AssetImage('/images/german.jpg'),
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
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: background2,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('OTHER', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w700, color: lightgrey),),
                        ),
                      ],
                    ),
                  ),
                
        
            SizedBox(height: 5),
    
            Text('3D Modeling', style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold, color: black),),

            SizedBox(height: 5),

            Row(
              children: [
                Row(
                  children: [
                    Icon(UniconsLine.clock_eight, size: 15, color: darkblue,),
                    SizedBox(width: 5,),
                    Text('2.5 hrs', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w700, color: lightgrey),),
                  ],
                ),

                SizedBox(width: 20,),

                Row(
                  children: [
                    Icon(UniconsLine.file_alt, size: 15, color: darkblue,),
                    SizedBox(width: 5,),
                    Text('Certificate', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w700, color: lightgrey),),
                  ],
                ),
              ],
                ),
        
            SizedBox(height: 5),
    
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('View Course', style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.w700, color: white),),
                        ),
                ],
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
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: darkblue, width: 2),
                    ),
                    child: Text('ALL COURSES', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w700, color: darkblue),),
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
                    child: Text('IT', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w700, color: darkblue),),
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
                  child: Text('SCIENCE', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w700, color: darkblue),),
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
                    child: Text('MATH', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w700, color: darkblue),),
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
                    child: Text('LANGUAGE', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w700, color: darkblue),),
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
                    child: Text('OTHER', style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w700, color: darkblue),),
                  ),
                  
                ],
              )
            )
          ],
        ),
      );
  }
}
