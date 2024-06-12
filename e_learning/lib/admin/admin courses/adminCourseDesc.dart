import 'package:e_learning/services/courseServices.dart'; // Import the service for fetching course details
import 'package:e_learning/student/all%20courses/allCourses.dart';
import 'package:e_learning/student/my%20courses/myCourses.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../color.dart';
import '../../services/countServices.dart';
import '../../services/enrollServices.dart';
import '../../services/materialServices.dart';
import '../../services/requestServices.dart';
import '../edit other courses/editCoursePreview.dart';
import 'adminCourses.dart';

class AdminCourseDescription extends StatefulWidget {
  final int course_id;
  final String description;
  final String image;
  final String title;
  final String catagory;
  final Map<String, dynamic> what_will;

  const AdminCourseDescription({
    Key? key,
    required this.course_id,
    required this.description,
    required this.image,
    required this.title,
    required this.catagory,
    required this.what_will,
  }) : super(key: key);

  @override
  _AdminCourseDescriptionState createState() => _AdminCourseDescriptionState();
}

class _AdminCourseDescriptionState extends State<AdminCourseDescription>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<String, dynamic>? courseDetails;
  bool isLoading = true;
  bool active = false;
  bool pending = false;
  int progress = 0;
  int materialCount = 0;
  int subCount = 0;
  List<dynamic> _addedmaterials = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchCourseDetails();
    fetchUserById();
    fetchMaterialCountByCourseId();
    fetchStudentCountByCourseId();
    getMaterialByCourseId();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> fetchCourseDetails() async {
    try {
      final details =
          await CourseService.instance.fetchCourseById(widget.course_id);
      setState(() {
        courseDetails = details;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching course details: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getMaterialByCourseId() async {
    try {
      final addedMaterialData = await MaterialService.instance
          .getMaterialByCourseId(widget.course_id);
      setState(() {
        _addedmaterials = addedMaterialData ?? [];
      });
    } catch (e) {
      print('Error fetching courses: $e');
    }
  }

  Future<void> fetchMaterialCountByCourseId() async {
    try {
      final response = await CountService.instance
          .getMaterialCountByCourseId(widget.course_id);

      if (response != null) {
        if (response is int) {
          setState(() {
            materialCount = response;
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

  Future<void> fetchStudentCountByCourseId() async {
    try {
      final response = await CountService.instance
          .getStudentCountByCourseId(widget.course_id);

      if (response != null) {
        if (response is int) {
          setState(() {
            subCount = response;
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

  Future<void> fetchUserById() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final user_id = prefs.getInt('user_id');
      final accessToken = prefs.getString('access_token');

      if (user_id != null && accessToken != null) {
        final response = await EnrollService.instance
            .fetchEnrollmentbyUserIdnCourseId(
                user_id, widget.course_id, accessToken);

        setState(() {
          active = response['active'];
          pending = response['pending'];
          progress = response['progress'];
        });
      } else {
        print('User ID or Access Token not found in SharedPreferences');
      }
    } catch (e) {
      print('Error fetching user info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipPath(
                      clipper: MyClipper(),
                      child: Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AdminCourses(
                                    username: '',
                                    accessToken: '',
                                    refreshToken: '',
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Iconsax.arrow_left_2,
                                        size: 20,
                                        color: black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: black,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                widget.catagory.toUpperCase(),
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: darkblue,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.description,
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: black,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(Iconsax.people, size: 15, color: darkblue),
                                SizedBox(width: 2),
                                Text('${subCount.toString()} Students',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: black)),
                              ],
                            ),
                            SizedBox(width: 15),
                            Row(
                              children: [
                                Icon(Iconsax.video_play,
                                    size: 15, color: darkblue),
                                SizedBox(width: 2),
                                Text('${materialCount.toString()} Lessons',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: black)),
                              ],
                            ),
                            SizedBox(width: 15),
                            Row(
                              children: [
                                Icon(Iconsax.document,
                                    size: 15, color: darkblue),
                                SizedBox(width: 2),
                                Text('Certificate',
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: black)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      TabBar(
                        controller: _tabController,
                        tabs: [
                          Tab(
                            child: Text(
                              'About',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: _tabController.index == 0
                                    ? black
                                    : lightgrey,
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Lessons',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: _tabController.index == 1
                                    ? black
                                    : lightgrey,
                              ),
                            ),
                          )
                        ],
                        indicator: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: blue,
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
                      isLoading
                          ? Center(child: CircularProgressIndicator())
                          : Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AboutCourse(
                                          what_will: widget.what_will,
                                          active: active,
                                          pending: pending,
                                        ),
                                        SizedBox(height: 20),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: getActionButton(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Column(
                                      children:
                                          _addedmaterials.map((addedmaterial) {
                                        return Lessons(
                                          course_id:
                                              addedmaterial['course_id'] ?? 0,
                                          material_id:
                                              addedmaterial['material_id'] ?? 0,
                                          order_number:
                                              addedmaterial['order_number'] ??
                                                  0,
                                          material_file:
                                              addedmaterial['material_file'] ??
                                                  '',
                                          title: addedmaterial['title'] ?? '',
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getActionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            backgroundColor: darkblue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditOtherCourse(
                          course_id: widget.course_id,
                          username: '',
                          accessToken: '',
                          refreshToken: '',
                        )));
          },
          child: Text(
            'Edit Course'.toUpperCase(),
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: white,
            ),
          ),
        ),
        SizedBox(width: 10),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            backgroundColor: red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Confirm Deletion'),
                  content: Text('Are you sure you want to delete this course?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('No'),
                    ),
                    TextButton(
                      onPressed: () async {
                        try {
                          await CourseService.instance
                              .deleteCourseById(widget.course_id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Course deleted successfully')),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Failed to delete course: $e')),
                          );
                        }
                      },
                      child: Text('Yes'),
                    ),
                  ],
                );
              },
            );
          },
          child: Text(
            'delete Course'.toUpperCase(),
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: white,
            ),
          ),
        ),
      ],
    );
  }
}

class SharedPreferencesHelper {
  static Future<int?> getUserId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getInt('user_id');
    } catch (e) {
      print('Error fetching user ID from SharedPreferences: $e');
      return null;
    }
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, 0);

    path.lineTo(0, size.height);

    final firstCurve = Offset(0, size.height - 30);
    final lastCurve = Offset(40, size.height - 30);
    path.quadraticBezierTo(
        firstCurve.dx, firstCurve.dy, lastCurve.dx, lastCurve.dy);

    final secondCurve = Offset(size.width - 40, size.height - 30);
    final thirdCurve = Offset(size.width - 40, size.height - 30);
    path.quadraticBezierTo(
        secondCurve.dx, secondCurve.dy, thirdCurve.dx, thirdCurve.dy);

    final lastCurve2 = Offset(size.width, size.height - 30);
    final firstCurve2 = Offset(size.width, size.height);
    path.quadraticBezierTo(
        lastCurve2.dx, lastCurve2.dy, firstCurve2.dx, firstCurve2.dy);
    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class Lessons extends StatelessWidget {
  final int course_id;
  final int material_id;
  final String material_file;
  final String title;
  final int order_number;

  const Lessons({
    required this.course_id,
    required this.order_number,
    required this.material_id,
    required this.material_file,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      height: 50,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$title',
                  overflow: TextOverflow.clip,
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w500, color: black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AboutCourse extends StatelessWidget {
  final Map<String, dynamic>? what_will;
  final bool active;
  final bool pending;

  const AboutCourse({
    required this.what_will,
    required this.active,
    required this.pending,
    Key? key,
  }) : super(key: key);

  String _formatWhatWill(Map<String, dynamic> whatWill) {
    String formattedString = '';

    if (whatWill.containsKey('what_will_you_learn')) {
      formattedString += 'What will you learn:\n';
      whatWill['what_will_you_learn'].forEach((key, value) {
        formattedString += ' - $value\n';
      });
    }

    if (whatWill.containsKey('what_skil_you_gain')) {
      formattedString += '\nWhat skills you will gain:\n';
      whatWill['what_skil_you_gain'].forEach((key, value) {
        formattedString += ' - $value\n';
      });
    }

    if (whatWill.containsKey('who_should_learn')) {
      formattedString += '\nWho should learn:\n';
      whatWill['who_should_learn'].forEach((key, value) {
        formattedString += ' - $value\n';
      });
    }

    return formattedString;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Course',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: black,
                    ),
                  ),
                  SizedBox(height: 10),
                  if (what_will != null)
                    Text(
                      _formatWhatWill(what_will!),
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
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
