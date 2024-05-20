import 'package:e_learning/services/courseServices.dart'; // Import the service for fetching course details
import 'package:e_learning/student/all%20courses/allCourses.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../color.dart';

class CourseDescription extends StatefulWidget {
  final int course_id;
  final String description;
  final String image;
  final String title;
  final String category;
  final Map<String, dynamic> what_will;

  const CourseDescription({
    Key? key,
    required this.course_id,
    required this.description,
    required this.image,
    required this.title,
    required this.category,
    required this.what_will,
  }) : super(key: key);

  @override
  _CourseDescriptionState createState() => _CourseDescriptionState();
}

class _CourseDescriptionState extends State<CourseDescription>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<String, dynamic>? courseDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchCourseDetails();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> fetchCourseDetails() async {
    try {
      final details = await CourseService.instance
          .fetchCourseById(widget.course_id as String);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const StdAllCourses(
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
                        style: GoogleFonts.nunito(
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
                              color: background2,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                widget.category,
                                style: GoogleFonts.nunito(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: other,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        widget.description,
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(EneftyIcons.people_bold,
                                    size: 20, color: lightgrey),
                                SizedBox(width: 2),
                                Text('120 Students',
                                    style: GoogleFonts.nunito(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: black)),
                              ],
                            ),
                            SizedBox(width: 10),
                            Row(
                              children: [
                                Icon(EneftyIcons.clock_2_bold,
                                    size: 20, color: lightgrey),
                                SizedBox(width: 2),
                                Text('2.5 Hours',
                                    style: GoogleFonts.nunito(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: black)),
                              ],
                            ),
                            SizedBox(width: 10),
                            Row(
                              children: [
                                Icon(EneftyIcons.document_bold,
                                    size: 20, color: lightgrey),
                                SizedBox(width: 2),
                                Text('Certificate',
                                    style: GoogleFonts.nunito(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
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
                              style: GoogleFonts.nunito(
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
                              style: GoogleFonts.nunito(
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
                                      children: [
                                        AboutCourse(
                                          what_will: {
                                            'what_will': widget.what_will
                                          },
                                        ),
                                        SizedBox(height: 20),
                                        TextButton(
                                          onPressed: () {


                                          },
                                          child: Text(
                                            'Enroll Now',
                                            style: GoogleFonts.nunito(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: blue,
                                            ),
                                          ),
                                            
                                        )
                                      ],
                                    ),

                                  ),
                                  SingleChildScrollView(
                                    child:
                                        Lessons(courseDetails: courseDetails),
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
    return false; // Return true if the new instance needs to repaint the path
  }
}

class Lessons extends StatelessWidget {
  final Map<String, dynamic>? courseDetails;

  const Lessons({Key? key, this.courseDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return courseDetails == null
        ? Center(child: Text('No lessons available'))
        : Container(
            child: Column(children: [
              ListView(
                shrinkWrap: true,
                children:
                    List.generate(courseDetails!['content'].length, (index) {
                  return ListTile(
                    leading:
                        Icon(EneftyIcons.chart_success_outline, color: black),
                    title: Text(
                      courseDetails!['content'][index]['title'],
                      style: GoogleFonts.openSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: black),
                    ),
                    subtitle: Text(
                      courseDetails!['content'][index]['description'],
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.openSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: black),
                    ),
                  );
                }),
              )
            ]),
          );
  }
}

class AboutCourse extends StatelessWidget {
  final Map<String, dynamic>? what_will;

  const AboutCourse({
    required this.what_will,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Course',
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  if (what_will != null) ...[
                    if (what_will!['what_will_you_learn'] != null) ...[
                      Text(
                        'What You Will Learn:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      ...(what_will!['what_will_you_learn']
                              as Map<String, dynamic>)
                          .entries
                          .map((entry) {
                        return Text(
                          '${entry.key}: ${entry.value}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        );
                      }),
                      SizedBox(height: 20),
                    ],
                    if (what_will!['what_skil_you_gain'] != null) ...[
                      Text(
                        'Skills You Will Gain:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      ...(what_will!['what_skil_you_gain']
                              as Map<String, dynamic>)
                          .entries
                          .map((entry) {
                        return Text(
                          '${entry.key}: ${entry.value}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        );
                      }),
                      SizedBox(height: 20),
                    ],
                    if (what_will!['who_should_learn'] != null) ...[
                      Text(
                        'Who Should Learn:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      ...(what_will!['who_should_learn']
                              as Map<String, dynamic>)
                          .entries
                          .map((entry) {
                        return Text(
                          '${entry.key}: ${entry.value}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        );
                      }),
                      SizedBox(height: 20),
                    ],
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
