import 'package:e_learning/admin/add%20courses/addCourses.dart';
import 'package:e_learning/admin/requests/requests.dart';
import 'package:e_learning/color.dart';
import 'package:e_learning/login/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/countServices.dart';
import '../add new admin/admins.dart';
import '../admin courses/adminCourses.dart';
import '../admin profile/adminProfile.dart';
import '../admin students/adminStudents.dart';
import '../delete requests/deleteRequests.dart';
import '../enrollments/enrolments.dart';
import '../submissions/submissions.dart';
import 'adminDash.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  int _hoverIndex = -1;
  int _selectedIndex = -1;

  void _onEnter(int index) {
    setState(() {
      _hoverIndex = index;
    });
  }

  void _onExit() {
    setState(() {
      _hoverIndex = -1;
    });
  }

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildListTile({
    required int index,
    required IconData icon,
    required String title,
    required Widget destination,
  }) {
    bool isHovered = _hoverIndex == index;
    bool isSelected = _selectedIndex == index;

    return MouseRegion(
      onEnter: (_) => _onEnter(index),
      onExit: (_) => _onExit(),
      child: GestureDetector(
        onTap: () {
          _onTap(index);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: isHovered || isSelected ? darkblue : white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: Icon(
              icon,
              size: 20,
              color: isHovered || isSelected ? white : black,
            ),
            title: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isHovered || isSelected ? white : black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: white,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: white,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(color: darkblue),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/logos/logo.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Edu',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: lightblue,
                            ),
                            children: [
                              TextSpan(
                                text: 'App',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: 9, // Number of items
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return _buildListTile(
                      index: 0,
                      icon: Iconsax.home,
                      title: 'Dashboard',
                      destination: AdminDash(
                          username: '', accessToken: '', refreshToken: ''),
                    );
                  case 1:
                    return _buildListTile(
                      index: 1,
                      icon: Iconsax.book,
                      title: 'Courses',
                      destination: AdminCourses(
                          username: '', accessToken: '', refreshToken: ''),
                    );
                  case 2:
                    return _buildListTile(
                      index: 2,
                      icon: Iconsax.book_saved,
                      title: 'Add Courses',
                      destination: AddCourses(
                          username: '', accessToken: '', refreshToken: ''),
                    );
                  case 3:
                    return _buildListTile(
                      index: 3,
                      icon: Iconsax.people,
                      title: 'Students',
                      destination: AdminStudents(
                          username: '', accessToken: '', refreshToken: ''),
                    );
                  case 4:
                    return _buildListTile(
                      index: 4,
                      icon: Iconsax.add,
                      title: 'Enrollments',
                      destination: Enrollments(
                          username: '', accessToken: '', refreshToken: ''),
                    );
                  case 5:
                    return _buildListTile(
                      index: 5,
                      icon: Iconsax.document,
                      title: 'Submissions',
                      destination: Submissions(
                          username: '', accessToken: '', refreshToken: ''),
                    );
                  case 6:
                    return _buildListTile(
                      index: 6,
                      icon: Iconsax.people,
                      title: 'Admins',
                      destination: Admins(
                          username: '', accessToken: '', refreshToken: ''),
                    );
                  case 7:
                    return _buildListTile(
                      index: 7,
                      icon: Iconsax.user,
                      title: 'Profile',
                      destination: AdminProfile(
                          username: '', accessToken: '', refreshToken: ''),
                    );
                  case 8:
                    return _buildListTile(
                      index: 8,
                      icon: Iconsax.logout,
                      title: 'Logout',
                      destination: Login(),
                    );
                  default:
                    return SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}