import 'package:e_learning/admin/add%20courses/add%20materials/addMaterial.dart';
import 'package:e_learning/admin/add%20courses/newCourse.dart';
import 'package:e_learning/color.dart';
import 'package:e_learning/shared/searchBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

import '../../services/courseServices.dart';
import '../admin home/adminDash.dart';

class AddCourses extends StatefulWidget {
  const AddCourses({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;

  @override
  _AddCoursesState createState() => _AddCoursesState();
}

class _AddCoursesState extends State<AddCourses> {
  List<dynamic> _addedcourses = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        leading: IconButton(
          icon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Iconsax.menu_1, size: 30, color: black),
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset(
                      '/logos/logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                'Add Courses',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: black,
                ),
              ),
            ],
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
                      builder: (context) => NewCourse(
                            username: widget.username,
                            accessToken: widget.accessToken,
                            refreshToken: widget.refreshToken,
                          )));
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
                    'ADD NEW COURSE',
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
                    description: addedcourse['description'] ?? 'No Description',
                    course_id: addedcourse['course_id'] ?? 0,
                    image: addedcourse['image'] ?? '',
                    title: addedcourse['title'] ?? 'No Title',
                    category: addedcourse['category'] ?? 'Uncategorized',
                  );
                }).toList(),
              ))
        ]),
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
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: white,
      ),
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(children: [
            //image
            Container(
              height: 120,
              width: 120,
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
              SizedBox(
                  width: 200,
                  child: Text(
                    course_id.toString() + ') ' + title,
                    overflow: TextOverflow.clip,
                    style: GoogleFonts.openSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: black),
                  )),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddMaterial(
                                username: '',
                                accessToken: '',
                                refreshToken: '',
                                course_id: course_id,
                              )));
                },
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
