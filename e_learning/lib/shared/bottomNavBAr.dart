import 'package:e_learning/color.dart';
import 'package:e_learning/student/my%20courses/myCourses.dart';
import 'package:e_learning/student/profile/stdProfile.dart';
import 'package:flutter/material.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:unicons/unicons.dart';

import '../student/home/stdHome.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: white,
      height: 70,
      destinations: const [
        NavigationDestination(icon: Icon(EneftyIcons.home_2_outline), label: 'Home'),
        NavigationDestination(icon: Icon(EneftyIcons.book_2_outline), label: 'My Courses'),
        NavigationDestination(icon: Icon(EneftyIcons.a_3d_cube_outline), label: 'All Courses'), 
        NavigationDestination(icon: Icon(EneftyIcons.user_outline), label: 'Profile'),
      ],
      onDestinationSelected: (int index) {
        switch (index) {
          case 0:
            // Navigate to Home screen
            Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentHome()));
            break;
          case 1:
            // Navigate to My Courses screen
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MyCourses()));
            break;
          case 2:
            // Navigate to All Courses screen
            Navigator.pushNamed(context, '/all_courses');
            break;
          case 3:
            // Navigate to Profile screen
            Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentProfile()));
            break;
        }
      },
    );
  }
}
