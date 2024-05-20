import 'package:e_learning/services/courseServices.dart';
import 'package:e_learning/shared/searchBar.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

import '../../color.dart';
import '../admin home/adminDash.dart';

class AdminCourses extends StatefulWidget {
  const AdminCourses({
Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;
  
  @override
  _AdminCoursesState createState() => _AdminCoursesState();

}


class _AdminCoursesState extends State<AdminCourses> with SingleTickerProviderStateMixin {
      List<dynamic> _courses = []; 

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    fetchAllCourses();
  }

   Future<void> fetchAllCourses() async {
    try {
      final studentsData = await CourseService.instance.fetchAllCourses();
      setState(() {
        _courses = studentsData ?? [];
      });
    } catch (e) {
      print('Error fetching students: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,  // Assign the key to the Scaffold
      backgroundColor: background,
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        leading: IconButton(
          icon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(UniconsLine.bars, size: 30, color: black),
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer(); 
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'AllCourses',
                  style: GoogleFonts.nunito(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: black,
                  ),
                ),
              ],
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
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white, // Assuming 'white' is a Color variable
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
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                    image: DecorationImage(
                      image: AssetImage('/images/python.png'), 
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: PopupMenuButton<String>(
                      icon: Icon(UniconsLine.ellipsis_h, color: Colors.white, size: 30), // Assuming 'white' is a Color variable
                      onSelected: (value) {
                        switch (value) {
                          case 'Edit Course':
                            // Handle Edit Course action
                            print('Edit Course');
                            break;
                          case 'Delete Course':
                            // Handle Delete Course action
                            print('Delete Course');
                            break;
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return {'Edit Course', 'Delete Course'}.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
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
                            color: Colors.blue.shade50, // Assuming 'background2' is a Color variable
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'IT',
                            style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey), // Assuming 'lightgrey' is a Color variable
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Python Programming',
                      style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black), // Assuming 'black' is a Color variable
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(EneftyIcons.video_play_bold, color: Colors.blue, size: 15), // Assuming 'darkblue' is a Color variable
                                SizedBox(width: 5),
                                Text(
                                  '11 lessons',
                                  style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey), // Assuming 'lightgrey' is a Color variable
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(EneftyIcons.clock_2_bold, color: Colors.blue, size: 15), // Assuming 'darkblue' is a Color variable
                                SizedBox(width: 5),
                                Text(
                                  '3.5 Hours',
                                  style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey), // Assuming 'lightgrey' is a Color variable
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white, // Assuming 'white' is a Color variable
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.blue, width: 2), // Assuming 'darkblue' is a Color variable
                          ),
                          child: Text(
                            'View Details',
                            style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue), // Assuming 'darkblue' is a Color variable
                          ),
                        ),
                      ],
                    ),
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
