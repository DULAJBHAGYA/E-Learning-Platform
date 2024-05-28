import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../color.dart';
import '../../services/countServices.dart';

class UserStats extends StatefulWidget {
  const UserStats({Key? key}) : super(key: key);

  @override
  _UserStatsState createState() => _UserStatsState();
}

class _UserStatsState extends State<UserStats> {
  int courseCount = 0;
  int ongoingCourseCount = 0;
  int completedCourseCount = 0;

  @override
  void initState() {
    super.initState();
    fetchCourseCount();
    fetchOngoingCourseCount();
    fetchCompletedCourseCount();
  }

  Future<void> fetchCourseCount() async {
    try {
      final response = await CountService.instance.getCoursesCount();

      if (response != null) {
        if (response is int) {
          setState(() {
            courseCount = response;
          });
        } else {
          throw Exception('Course count is not an integer');
        }
      } else {
        throw Exception('Response is null');
      }
    } catch (e) {
      print('Error fetching student count: $e');
    }
  }

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
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: darkblue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(clipBehavior: Clip.none, children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            courseCount.toString(),
                            style: GoogleFonts.openSans(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                                color: white),
                          ),
                          Text(
                            'All \nCourses',
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: white),
                          ),
                        ],
                      ),
                    ]),
                  )),
              SizedBox(width: 10),
              Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: darkblue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          completedCourseCount.toString(),
                          style: GoogleFonts.openSans(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: white),
                        ),
                        Text(
                          'Completed \nCourses',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: white),
                        ),
                      ],
                    ),
                  )),
              SizedBox(width: 10),
              Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: darkblue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          ongoingCourseCount.toString(),
                          style: GoogleFonts.openSans(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: white),
                        ),
                        Text(
                          'Ongoing \nCourses',
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: white),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ],
      )),
    );
  }
}
