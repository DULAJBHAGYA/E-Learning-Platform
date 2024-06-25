import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_learning/shared/bottomNavBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../color.dart';
import '../../services/countServices.dart';
import 'completedCourses.dart';
import 'onGoingCourses.dart';

class MyCourses extends StatefulWidget {
  const MyCourses({Key? key}) : super(key: key);

  @override
  _MyCoursesState createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int courseCount = 0;
  int ongoingCourseCount = 0;
  int completedCourseCount = 0;

  Future<void> fetchOngoingCourseCount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');

      if (userId != null) {
        final response =
            await CountService.instance.getOngoingCourseCountByUserId(userId);

        if (response != null) {
          if (response is int) {
            setState(() {
              ongoingCourseCount = response;
            });
          } else {
            throw Exception('Course count is not an integer');
          }
        } else {
          throw Exception('Response is null');
        }
      } else {
        throw Exception('User ID is null');
      }
    } catch (e) {
      print('Error fetching ongoing course count: $e');
    }
  }

  Future<void> fetchCompletedCourseCount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');

      if (userId != null) {
        final response =
            await CountService.instance.getCompletedCourseCountByUserId(userId);

        if (response != null) {
          if (response is int) {
            setState(() {
              completedCourseCount = response;
            });
          } else {
            throw Exception('Course count is not an integer');
          }
        } else {
          throw Exception('Response is null');
        }
      } else {
        throw Exception('User ID is null');
      }
    } catch (e) {
      print('Error fetching ongoing course count: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchOngoingCourseCount();
    fetchCompletedCourseCount();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: background,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'My Courses',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
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
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
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
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: white,
                                fontWeight: FontWeight.w500,
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
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
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
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: white,
                                fontWeight: FontWeight.w500,
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
                    // Content of the first tab ('Ongoing')
                    OnGoingCourses(
                      username: '',
                      accessToken: '',
                      refreshToken: '',
                    ),

                    // Content of the second tab ('Completed')
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
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
