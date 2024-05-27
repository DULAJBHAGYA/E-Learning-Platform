import 'package:e_learning/services/courseServices.dart'; // Import the service for fetching course details
import 'package:e_learning/student/all%20courses/allCourses.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../color.dart';
import '../../services/enrollServices.dart';
import '../../services/requestServices.dart';
import '../course content/courseContent.dart';

class CourseDescription extends StatefulWidget {
  final int course_id;
  final String description;
  final String image;
  final String title;
  final String catagory;
  final Map<String, dynamic> what_will;

  const CourseDescription({
    Key? key,
    required this.course_id,
    required this.description,
    required this.image,
    required this.title,
    required this.catagory,
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
  bool active = false;
  bool pending = false;
  int progress = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchCourseDetails();
    fetchUserById();
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
                        style: GoogleFonts.poppins(
                          fontSize: 25,
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
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                widget.catagory.toUpperCase(),
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: lightblue,
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
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: black,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Iconsax.people, size: 20, color: darkblue),
                                SizedBox(width: 2),
                                Text('120 Students',
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: black)),
                              ],
                            ),
                            SizedBox(width: 15),
                            Row(
                              children: [
                                Icon(Iconsax.clock, size: 20, color: darkblue),
                                SizedBox(width: 2),
                                Text('2.5 Hours',
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: black)),
                              ],
                            ),
                            SizedBox(width: 15),
                            Row(
                              children: [
                                Icon(Iconsax.document,
                                    size: 20, color: darkblue),
                                SizedBox(width: 2),
                                Text('Certificate',
                                    style: GoogleFonts.poppins(
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
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
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
                                fontWeight: FontWeight.w400,
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

  Widget getActionButton() {
    if (!active && !pending) {
      return TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          backgroundColor: white,
          shape: StadiumBorder(
            side: BorderSide(color: darkblue, width: 2),
          ),
        ),
        onPressed: () async {
          try {
            int? user_id = await SharedPreferencesHelper.getUserId();
            if (user_id == null) {
              print('User ID not found in SharedPreferences');
              return;
            }

            await EnrollService.instance.postEnrollment(
              user_id,
              widget.course_id,
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Enroll request sent successfully!'),
                duration: Duration(seconds: 2),
              ),
            );
          } catch (e) {
            print('Enrollment Error: $e');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text('Failed to send enroll request. Please try again.'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: Text(
          'Enroll Now',
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: darkblue,
          ),
        ),
      );
    } else if (!active && pending) {
      return TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          backgroundColor: white,
          shape: StadiumBorder(
            side: BorderSide(color: pendingColor, width: 2),
          ),
        ),
        onPressed: null,
        child: Text(
          'Pending',
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: pendingColor,
          ),
        ),
      );
    } else if (active && !pending) {
      return TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          backgroundColor: white,
          shape: StadiumBorder(
            side: BorderSide(color: darkblue, width: 2),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseContent(course_id: widget.course_id),
            ),
          );
        },
        child: Text(
          'Get Started',
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: darkblue,
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
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
  final bool active;
  final bool pending;

  const AboutCourse({
    required this.what_will,
    required this.active,
    required this.pending,
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
              // Corrected this line
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
