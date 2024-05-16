import 'package:e_learning/shared/searchBar.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

import '../../color.dart';

class AdminCourses extends StatefulWidget {
  const AdminCourses({Key? key}) : super(key: key);

  @override
  _AdminCoursesState createState() => _AdminCoursesState();
}

class _AdminCoursesState extends State<AdminCourses>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AllCourses',
              style: GoogleFonts.openSans(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: black,
              ),
            ),
            SizedBox(height: 20),
            CustomSearchBar(),
            SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                     
                     AdminCourseView(),

                     SizedBox(height: 20),

                     AdminCourseView(),

                     SizedBox(height: 20),

                     AdminCourseView(),

                     SizedBox(height: 20),

                     AdminCourseView(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminCourseView extends StatelessWidget {
  const AdminCourseView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container (
      width: MediaQuery.of(context).size.width,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
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
                  ),
                ),
                Align
                (
                  alignment: Alignment.topRight,
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Icon(UniconsThinline.ellipsis_h, color: black, size: 30,),
                 )),
              ],
            ),
    
            SizedBox(height: 10,),
    
           
    
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0, top: 10.0),
                child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Row(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       Container(
                         alignment: Alignment.center,
                         padding: EdgeInsets.all(5),
                         decoration: BoxDecoration(
                           color: white,
                           borderRadius: BorderRadius.circular(20),
                         ),
                         child: Text(
                           'ARTIFICAL INTELLIGENCE',
                           style: GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.w500, color: lightgrey),
                         ),
                       ),
                     ],
                   ),
    
    
                   SizedBox(height: 5,),
    
                    Text('Data Science Basic', style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.w700, color: black),),
    
                     Row(
                       children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Row(
                               children: [
                                 Icon(EneftyIcons.video_play_outline, color: lightgrey, size: 15,),
                                 SizedBox(width: 5,),
                                 Text('7 lessons', style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w500, color: lightgrey),),
                               ],
                             ),
    
                             SizedBox(height: 10,),
    
                             Row(
                               children: [
                                 Icon(EneftyIcons.clock_2_outline, color: lightgrey, size: 15,),
                                 SizedBox(width: 5,),
                                 Text('2.5 Hours', style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w500, color: lightgrey),),
                               ],
                             ),
                           ],
                         ),
    
                         Spacer(),
    
                         Container(
                           alignment: Alignment.center,
                           padding: EdgeInsets.all(5),
                           decoration: BoxDecoration(
                             color: white,
                             borderRadius: BorderRadius.circular(8),
                             border: Border.all(color: darkblue, width: 2),
                           ),
                           child: Text('View Details', style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w500, color: darkblue),),
                         )
                       ],
                     )
                    
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
