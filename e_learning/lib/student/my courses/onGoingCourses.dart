import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../color.dart';
import '../../services/enrollServices.dart';
import '../course content/courseContent.dart';

class OnGoingCourses extends StatefulWidget {
  const OnGoingCourses({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;

  @override
  _OnGoingCoursesState createState() => _OnGoingCoursesState();
}

class _OnGoingCoursesState extends State<OnGoingCourses> {
  List<dynamic> _ongoingcourses = [];

  @override
  void initState() {
    super.initState();
    fetchOngoingCourses();
  }

  Future<void> fetchOngoingCourses() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final user_id = prefs.getInt('user_id');

      if (user_id == null) {
        throw Exception('User ID not found in shared preferences');
      }

      final ongoingCourseData =
          await EnrollService.instance.fetchOngoingCourses(user_id);

      setState(() {
        _ongoingcourses = ongoingCourseData ?? [];
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
        children: _ongoingcourses.map((ongoingcourse) {
          return OnGoingCourseCard(
              image: ongoingcourse['image'] ?? '',
              title: ongoingcourse['title'] ?? 'No title',
              catagory: ongoingcourse['catagory'] ?? 'No category',
              progress: ongoingcourse['progress'] ?? 0,
              course_id: ongoingcourse['course_id'] ?? 0);
        }).toList(),
      ),
    );
  }
}

class OnGoingCourseCard extends StatelessWidget {
  final String image;
  final String title;
  final String catagory;
  final int progress;
  final int course_id;

  const OnGoingCourseCard({
    required this.image,
    required this.title,
    required this.catagory,
    required this.progress,
    required this.course_id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseContent(course_id: course_id),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 120,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(children: [
            // Image
            Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            SizedBox(width: 20),

            // Course Details
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  title,
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: black,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: background2,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    catagory.toUpperCase(),
                    overflow: TextOverflow.clip,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: lightgrey,
                    ),
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),

            Spacer(),

            // Progress Indicator
            CircularPercentIndicator(
              radius: 40.0,
              lineWidth: 8.0,
              progressColor: blue,
              animation: true,
              percent: progress / 100,
              center: Text(
                '${progress.toString()}%',
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w900,
                  fontSize: 15.0,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
