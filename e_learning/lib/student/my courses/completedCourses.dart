import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../color.dart';
import '../../services/enrollServices.dart';
import '../course content/courseContent.dart';

class CompletedCourses extends StatefulWidget {
  const CompletedCourses({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;

  @override
  _CompletedCoursesState createState() => _CompletedCoursesState();
}

class _CompletedCoursesState extends State<CompletedCourses> {
  List<dynamic> _completedcourses = [];

  @override
  void initState() {
    super.initState();
    fetchCompletedCourses();
  }

  Future<void> fetchCompletedCourses() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final user_id = prefs.getInt('user_id');

      if (user_id == null) {
        throw Exception('User ID not found in shared preferences');
      }

      final completedCourseData =
          await EnrollService.instance.fetchCompletedCourses(user_id);

      setState(() {
        _completedcourses = completedCourseData ?? [];
      });
    } on DioError catch (dioError) {
      if (dioError.response?.statusCode == 404) {
        print('Resource not found: ${dioError.response?.statusMessage}');
      } else {
        print('Dio error: ${dioError.message}');
      }
    } catch (e) {
      print('Error fetching courses: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: _completedcourses.map((completedcourse) {
          return CompletedCourseCard(
              image: completedcourse['image'] ?? '',
              title: completedcourse['title'] ?? 'No title',
              catagory: completedcourse['catagory'] ?? 'No category',
              progress: completedcourse['progress'] ?? 0,
              course_id: completedcourse['course_id'] ?? 0);
        }).toList(),
      ),
    );
  }
}

class CompletedCourseCard extends StatelessWidget {
  final String image;
  final String title;
  final String catagory;
  final int progress;
  final int course_id;

  const CompletedCourseCard({
    required this.image,
    required this.title,
    required this.catagory,
    required this.progress,
    required this.course_id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(children: [
            //image
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            SizedBox(width: 20),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: black),
                    ),
                    SizedBox(height: 5),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: background2,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        catagory.toUpperCase(),
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: lightgrey),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CourseContent(
                                course_id: course_id, progress: progress),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: darkblue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'REVIEW COURSE',
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: white),
                        ),
                      ),
                    ),
                  ]),
            ),
          ]),
        ));
  }
}
