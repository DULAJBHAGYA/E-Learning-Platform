import 'package:e_learning/color.dart';
import 'package:e_learning/student/all%20courses/allCourses.dart';
import 'package:e_learning/student/my%20courses/myCourses.dart';
import 'package:e_learning/student/profile/stdProfile.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../student/home/stdHome.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: white,
      height: 70,
      destinations: const [
        NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
        NavigationDestination(icon: Icon(Iconsax.book), label: 'All Courses'),
        NavigationDestination(icon: Icon(Iconsax.book_1), label: 'My Courses'),
        NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
      ],
      onDestinationSelected: (int index) {
        switch (index) {
          case 0:
            // Navigate to Home screen
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const StudentHome(
                        username: '', accessToken: '', refreshToken: '')));
            break;
          case 1:
            // Navigate to My Courses screen
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const StdAllCourses(
                        username: '', accessToken: '', refreshToken: '')));
            break;
          case 2:
            // Navigate to All Courses screen
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MyCourses()));
            break;
          case 3:
            // Navigate to Profile screen
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const StudentProfile(
                          username: '',
                          accessToken: '',
                          refreshToken: '',
                        )));
            break;
        }
      },
    );
  }
}
