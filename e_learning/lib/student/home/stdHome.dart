import 'package:e_learning/student/home/horizontalList.dart';
import 'package:e_learning/student/home/topCategories.dart';
import 'package:flutter/material.dart';

import '../../color.dart';
import '../../shared/bottomNavBar.dart';
import 'courseList.dart';
import 'imageSlider.dart';
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: background,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Container(
            child: Column(
              children: [
                //user info
                UserInfo(),

                SizedBox(height: 10),

                //count details
                UserStats(),
                SizedBox(height: 0),

                //image slider
                ImageSlider(),
                SizedBox(height: 5),

                // SizedBox(height: 10),
                //topcategories
                Topcategories(
                    username: widget.username,
                    accessToken: widget.accessToken,
                    refreshToken: widget.refreshToken),
                SizedBox(height: 30),

                //course filter
                HorizontalListview(),

                SizedBox(height: 10),

                CourseList(
                    username: widget.username,
                    accessToken: widget.accessToken,
                    refreshToken: widget.refreshToken),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
