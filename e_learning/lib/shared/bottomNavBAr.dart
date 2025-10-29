import 'package:e_learning/color.dart';
import 'package:e_learning/student/all%20courses/allCourses.dart';
import 'package:e_learning/student/my%20courses/myCourses.dart';
import 'package:e_learning/student/profile/stdProfile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../student/home/stdHome.dart';
import '../student/notifications/notifications.dart'; // Import the new notifications screen

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  int _notificationCount = 3; // Sample notification count

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      
      // Reset notification count when navigating to notifications
      if (index == 3) {
        _notificationCount = 0;
      }
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
      case 3: // Notification is now at index 3
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NotificationsScreen(),
          ),
        );
        break;
      case 4: // User profile is now at index 4
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
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () => _onItemTapped(0),
            icon: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _selectedIndex == 0 ? darkblue.withOpacity(0.1) : Colors.transparent,
              ),
              child: Icon(
                Iconsax.home,
                color: _selectedIndex == 0 ? darkblue : grey,
                size: 20, // Increased from 18 to 24
              ),
            ),
          ),
          IconButton(
            onPressed: () => _onItemTapped(1),
            icon: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _selectedIndex == 1 ? darkblue.withOpacity(0.1) : Colors.transparent,
              ),
              child: Icon(
                Iconsax.book,
                color: _selectedIndex == 1 ? darkblue : grey,
                size: 20, // Increased from 18 to 24
              ),
            ),
          ),
          IconButton(
            onPressed: () => _onItemTapped(2),
            icon: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _selectedIndex == 2 ? darkblue.withOpacity(0.1) : Colors.transparent,
              ),
              child: Icon(
                Iconsax.book_1,
                color: _selectedIndex == 2 ? darkblue : grey,
                size: 20, // Increased from 18 to 24
              ),
            ),
          ),
          IconButton(
            onPressed: () => _onItemTapped(3), // Notification is now at index 3
            icon: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _selectedIndex == 3 ? darkblue.withOpacity(0.1) : Colors.transparent,
                  ),
                  child: Icon(
                    Iconsax.notification, // Notification icon
                    color: _selectedIndex == 3 ? darkblue : grey,
                    size: 20, // Increased from 18 to 24
                  ),
                ),
                // Notification badge
                if (_notificationCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: darkblue, // Using darkblue for the badge
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        _notificationCount > 99 ? '99+' : _notificationCount.toString(),
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _onItemTapped(4), // User profile is now at index 4
            icon: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _selectedIndex == 4 ? darkblue.withOpacity(0.1) : Colors.transparent,
              ),
              child: Icon(
                Iconsax.user, // User icon
                color: _selectedIndex == 4 ? darkblue : grey,
                size: 20, // Increased from 18 to 24
              ),
            ),
          ),
        ],
      ),
    );
  }
}