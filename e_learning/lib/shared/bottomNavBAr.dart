import 'package:e_learning/color.dart';
import 'package:e_learning/student/all%20courses/allCourses.dart';
import 'package:e_learning/student/my%20courses/myCourses.dart';
import 'package:e_learning/student/profile/stdProfile.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../student/home/stdHome.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const StudentHome(
              username: '',
              accessToken: '',
              refreshToken: '',
            ),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const StdAllCourses(
              username: '',
              accessToken: '',
              refreshToken: '',
            ),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyCourses(),
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const StudentProfile(
              username: '',
              accessToken: '',
              refreshToken: '',
            ),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: white,
      height: 70,
      selectedIndex: _selectedIndex,
      onDestinationSelected: _onItemTapped,
      destinations: const [
        NavigationDestination(
          icon: Icon(Iconsax.home),
          label: 'Home',
          selectedIcon: Icon(Iconsax.home, color: darkblue),
        ),
        NavigationDestination(
          icon: Icon(Iconsax.book),
          label: 'All Courses',
          selectedIcon: Icon(Iconsax.book, color: darkblue),
        ),
        NavigationDestination(
          icon: Icon(Iconsax.book_1),
          label: 'My Courses',
          selectedIcon: Icon(Iconsax.book_1, color: darkblue),
        ),
        NavigationDestination(
          icon: Icon(Iconsax.user),
          label: 'Profile',
          selectedIcon: Icon(Iconsax.user, color: darkblue),
        ),
      ],
    );
  }
}
