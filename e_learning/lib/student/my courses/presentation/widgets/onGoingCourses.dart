import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:shared_preferences/shared_preferences.dart'; // Comment out real service
// import 'package:dio/dio.dart'; // Comment out real service

import '../../../../color.dart';
// import '../../services/enrollServices.dart'; // Comment out real service
import '../../../course content/courseContent.dart';
import 'onGoingCourseCard.dart'; // Import the new OnGoingCourseCard widget

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
  // Mock data for ongoing courses
  List<Map<String, dynamic>> _mockOngoingCourses = [
    {
      'course_id': 1,
      'title': 'Introduction to Flutter Development',
      'catagory': 'Mobile Development',
      'progress': 75,
      'image': 'assets/images/flutter.png',
    },
    {
      'course_id': 2,
      'title': 'Advanced React Patterns',
      'catagory': 'Web Development',
      'progress': 40,
      'image': 'assets/images/reactCourse.jpg',
    },
    {
      'course_id': 3,
      'title': 'UI/UX Design Fundamentals',
      'catagory': 'Design',
      'progress': 90,
      'image': 'assets/images/psCourse.jpg',
    },
  ];

  List<dynamic> _ongoingcourses = [];

  @override
  void initState() {
    super.initState();
    // Use mock data instead of fetching from API
    _ongoingcourses = _mockOngoingCourses;
    // fetchOngoingCourses();
  }

  // Comment out the real fetch function
  /*
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
  */

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: _ongoingcourses.map((ongoingcourse) {
          return OnGoingCourseCard(
              image: ongoingcourse['image'] ?? 'assets/images/flutter.png', // Use mock image
              title: ongoingcourse['title'] ?? 'No title',
              catagory: ongoingcourse['catagory'] ?? 'No category',
              progress: ongoingcourse['progress'] ?? 0,
              course_id: ongoingcourse['course_id'] ?? 0);
        }).toList(),
      ),
    );
  }
}
