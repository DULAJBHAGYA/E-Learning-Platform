import 'package:e_learning/student/home/horizontalList.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

import '../../color.dart';
import '../../shared/bottomNavBar.dart';
import 'courseList.dart';
import 'userInfo.dart';
import 'userStats.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;

  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: Column(
            children: [
              //user info
              UserInfo(),


              SizedBox(height: 30),

              //count details
              UserStats(),

              SizedBox(height: 30),

               //course filter
              HorizontalListview(),

              SizedBox(height: 30),

              CourseList(),
            ],
          ),
        ),
      
      ),

      bottomNavigationBar: BottomNavBar(),  
    );                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
  }
}









