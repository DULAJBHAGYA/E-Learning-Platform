import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';
import '../../services/courseServices.dart';

class CourseList extends StatefulWidget {
  const CourseList({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;

  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
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
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: _courses.take(3).map((course) {
            return CourseListCard(
              what_will: course['what_will'] ?? {},
              description: course['description'] ?? 'No Description',
              course_id: course['course_id'] ?? 0,
              image: course['image'] ?? '',
              title: course['title'] ?? 'No Title',
              catagory: course['catagory'] ?? 'Uncategorized',
            );
          }).toList(),
        ),
      ),
    );
  }
}

class CourseListCard extends StatelessWidget {
  final int course_id;
  final String description;
  final String image;
  final String title;
  final String catagory;
  final Map<String, dynamic> what_will;

  const CourseListCard({
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
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            // image
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Row(mainAxisAlignment: MainAxisAlignment.start,
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
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: lightgrey,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: black,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
