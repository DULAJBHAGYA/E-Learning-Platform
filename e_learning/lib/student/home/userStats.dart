import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';
import '../../services/countServices.dart';

class UserStats extends StatefulWidget {
  const UserStats({Key? key}) : super(key: key);

  @override
  _UserStatsState createState() => _UserStatsState();
}

class _UserStatsState extends State<UserStats> {
  int studentCount = 0;
  int courseCount = 0;
  int adminCount = 0;
  int subscriptionCount = 0;

  @override
  void initState() {
    super.initState();
    fetchStudentCount();
    fetchCourseCount();
    fetchAdminCount();
    fetchSubscriptionCount();
  }

  Future<void> fetchStudentCount() async {
    try {
      final response = await CountService.instance.getStudentCount();

      if (response != null) {
        if (response is int) {
          setState(() {
            studentCount = response;
          });
        } else {
          throw Exception('Student count is not an integer');
        }
      } else {
        throw Exception('Response is null');
      }
    } catch (e) {
      print('Error fetching student count: $e');
    }
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

  Future<void> fetchSubscriptionCount() async {
    try {
      final response = await CountService.instance.getSubscriptionCount();

      if (response != null) {
        if (response is int) {
          setState(() {
            subscriptionCount = response;
          });
        } else {
          throw Exception('Subscription count is not an integer');
        }
      } else {
        throw Exception('Response is null');
      }
    } catch (e) {
      print('Error fetching subscription count: $e');
    }
  }

  Future<void> fetchAdminCount() async {
    try {
      final response = await CountService.instance.getAdminsCount();

      if (response != null) {
        if (response is int) {
          setState(() {
            adminCount = response;
          });
        } else {
          throw Exception('Admins count is not an integer');
        }
      } else {
        throw Exception('Response is null');
      }
    } catch (e) {
      print('Error fetching student count: $e');
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
                          '12',
                          style: GoogleFonts.openSans(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: white),
                        ),
                        Text(
                          'Registered \nCourses',
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
                          '7',
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
