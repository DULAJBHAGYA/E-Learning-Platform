import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_learning/shared/bottomNavBAr.dart';

import '../../../../color.dart';
import '../widgets/completedCourses.dart';
import '../widgets/onGoingCourses.dart';

class MyCourses extends StatefulWidget {
  const MyCourses({Key? key}) : super(key: key);

  @override
  _MyCoursesState createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Mock data for course counts
  int ongoingCourseCount = 5;
  int completedCourseCount = 3;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'My Courses',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(
                        child: Row(
                          children: [
                            Text(
                              'Ongoing',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color:
                                    _tabController.index == 0 ? black : lightgrey,
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color:
                                    _tabController.index == 0 ? black : lightgrey,
                              ),
                              child: Center(
                                child: Text(
                                  ongoingCourseCount.toString(),
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14,
                                    color: white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          children: [
                            Text(
                              'Completed',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color:
                                    _tabController.index == 1 ? black : lightgrey,
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color:
                                    _tabController.index == 1 ? black : lightgrey,
                              ),
                              child: Center(
                                child: Text(
                                  completedCourseCount.toString(),
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14,
                                    color: white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    indicator: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: darkblue,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    onTap: (index) {
                      setState(() {
                        _tabController.index = index;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        OnGoingCourses(
                          username: '',
                          accessToken: '',
                          refreshToken: '',
                        ),
                        CompletedCourses(
                          username: '',
                          accessToken: '',
                          refreshToken: '',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 80),
            // Bottom Navigation Bar positioned same as all courses page
            Positioned(
              bottom: 10,
              left: MediaQuery.of(context).size.width * 0.04,
              right: MediaQuery.of(context).size.width * 0.04,
              child: BottomNavBar(),
            ),
          ],
        ),
      ),
    );
  }
}