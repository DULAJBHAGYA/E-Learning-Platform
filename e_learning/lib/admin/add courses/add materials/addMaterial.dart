import 'package:e_learning/admin/add%20courses/add%20materials/addMaterial.dart';
import 'package:e_learning/admin/add%20courses/add%20materials/newMaterial.dart';
import 'package:e_learning/admin/add%20courses/newCourse.dart';
import 'package:e_learning/color.dart';
import 'package:e_learning/shared/searchBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/courseServices.dart';

class AddMaterial extends StatefulWidget {
  const AddMaterial({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
    required this.course_id,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;
  final int course_id;

  @override
  _AddmaterialState createState() => _AddmaterialState();
}

class _AddmaterialState extends State<AddMaterial> {
  List<dynamic> _addedcourses = [];

  @override
  void initState() {
    super.initState();
    fetchCoursesById();
  }

  Future<void> fetchCoursesById() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final int? userId = prefs.getInt('user_id');

      if (userId == null) {
        throw Exception('User ID not found in local storage');
      }

      final addedCourseData =
          await CourseService.instance.getCourseByUserId(userId);
      setState(() {
        _addedcourses = addedCourseData ?? [];
      });
    } catch (e) {
      print('Error fetching courses: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Add Materials',
              style: GoogleFonts.openSans(
                  fontSize: 30, fontWeight: FontWeight.bold, color: black),
            ),
            SizedBox(
              height: 20,
            ),
            CustomSearchBar(),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Newmaterial(
                      course_id: widget.course_id,
                      username: widget.username,
                      accessToken: widget.accessToken,
                      refreshToken: widget.refreshToken,
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: darkblue,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'ADD NEW MATERIAL',
                      style: GoogleFonts.openSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: AlwaysScrollableScrollPhysics(),
                child: Row(
                  children: _addedcourses.map((addedcourse) {
                    return AdminAddedCourseViewCard(
                      what_will: addedcourse['what_will'] ?? {},
                      description:
                          addedcourse['description'] ?? 'No Description',
                      course_id: addedcourse['course_id'] ?? 0,
                      image: addedcourse['image'] ?? '',
                      title: addedcourse['title'] ?? 'No Title',
                      category: addedcourse['category'] ?? 'Uncategorized',
                    );
                  }).toList(),
                ))
          ]),
        ),
      ),
    );
  }
}

class AdminAddedCourseViewCard extends StatelessWidget {
  final int course_id;
  final String description;
  final String image;
  final String title;
  final String category;
  final Map<String, dynamic> what_will;

  const AdminAddedCourseViewCard({
    required this.course_id,
    required this.image,
    required this.title,
    required this.category,
    required this.description,
    required this.what_will,
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
          padding: const EdgeInsets.all(10.0),
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

            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  category.toUpperCase(),
                  style: GoogleFonts.openSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: science),
                ),
              ),
              SizedBox(height: 5),
              Text(
                course_id.toString() + ') ' + title,
                overflow: TextOverflow.fade,
                style: GoogleFonts.openSans(
                    fontSize: 15, fontWeight: FontWeight.bold, color: black),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: science,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Add Materials',
                        style: GoogleFonts.openSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: white),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ])),
    );
  }
}
