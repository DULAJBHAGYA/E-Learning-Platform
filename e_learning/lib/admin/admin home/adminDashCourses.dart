import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';
import '../../services/courseServices.dart';
import '../admin courses/adminCourses.dart';

class AdminDashCourses extends StatefulWidget {
  const AdminDashCourses({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;

  @override
  _AdminDashCoursesState createState() => _AdminDashCoursesState();
}

class _AdminDashCoursesState extends State<AdminDashCourses> {
  List<dynamic> _courses = [];

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    try {
      final courseData = await CourseService.instance.fetchAllCourses();
      setState(() {
        _courses = courseData ?? [];
      });
    } catch (e) {
      print('Error fetching courses: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Courses'.toUpperCase(),
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.w700, color: black),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminCourses(
                                  username: '',
                                  accessToken: '',
                                  refreshToken: '',
                                )));
                  },
                  child: Text(
                    'View all',
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: darkblue),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: _courses.take(3).map((course) {
                return AdminDashCoursessDisplayCard(
                  what_will: course['what_will'] ?? {},
                  description: course['description'] ?? 'No Description',
                  course_id: course['course_id'] ?? 0,
                  image: course['image'] ?? '',
                  title: course['title'] ?? 'No Title',
                  catagory: course['catagory'] ?? 'Uncategorized',
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}

class AdminDashCoursessDisplayCard extends StatelessWidget {
  final int course_id;
  final String description;
  final String image;
  final String title;
  final String catagory;
  final Map<String, dynamic> what_will;

  const AdminDashCoursessDisplayCard({
    required this.course_id,
    required this.image,
    required this.title,
    required this.catagory,
    required this.description,
    required this.what_will,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            // Image
            Container(
              height: 95,
              width: 95,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            SizedBox(width: 20),
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: background,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          catagory.toUpperCase(),
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: lightgrey,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.openSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
