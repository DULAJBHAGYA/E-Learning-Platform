import 'package:e_learning/services/courseServices.dart'; // Import the service for fetching course details
import 'package:e_learning/student/all%20courses/allCourses.dart';
import 'package:e_learning/student/my%20courses/presentation/pages/myCourses.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/gestures.dart'; // Add this import for TapGestureRecognizer

import '../../color.dart';
import '../../services/countServices.dart';
import '../../services/enrollServices.dart';
import '../../services/materialServices.dart';
import '../../services/requestServices.dart';
import '../course content/courseContent.dart';
import 'aboutCourse.dart'; // Import the AboutCourse widget
import 'actionButton.dart'; // Import the ActionButton widget
import 'lessons.dart'; // Import the Lessons widget
import 'myClipper.dart'; // Import the MyClipper class
import 'sharedPreferencesHelper.dart'; // Import the SharedPreferencesHelper class
import 'reviews.dart'; // Import the new Reviews widget

class CourseDescription extends StatefulWidget {
  final int course_id;
  final String description;
  final String image;
  final String title;
  final String catagory;
  final Map<String, dynamic> what_will;
  final String level; // Add level parameter

  const CourseDescription({
    Key? key,
    required this.course_id,
    required this.description,
    required this.image,
    required this.title,
    required this.catagory,
    required this.what_will,
    this.level = 'Beginner', // Add level with default value
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
  int materialCount = 0;
  int subCount = 0;
  List<dynamic> _addedmaterials = [];
  bool _showFullDescription = false; // Track if full description is shown

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left_2, size: 20, color: black),
          onPressed: () {
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
        ),
       
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only( left: 20, right: 20, bottom: 20), // Add padding for the entire screen
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: widget.image.startsWith('http') 
                              ? NetworkImage(widget.image) as ImageProvider<Object>
                              : AssetImage(widget.image) as ImageProvider<Object>,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                    
                  ],
                ),
                // Content after the image
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text(
                        widget.title,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: black,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              // Teacher avatar
                              CircleAvatar(
                                radius: 16,
                                backgroundImage: AssetImage('assets/images/dulaj.jpg'), // Replace with actual teacher image
                                backgroundColor: background2,
                              ),
                              SizedBox(width: 10),
                              // Teacher name
                              Text(
                                'John Doe', // Replace with actual teacher name
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: grey,
                                ),
                              ),
                            ],
                          ),
                          // Rating
                          Row(
                            children: [
                              Icon(Iconsax.magic_star5, color: Colors.amber, size: 20),
                              SizedBox(width: 5),
                              Text(
                                '4.8 (1.2K)', // Replace with actual rating
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Modified description with "See More" link within the text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          !_showFullDescription
                              ? Text.rich(
                                  TextSpan(
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: grey,
                                      letterSpacing: -0.2,
                                    ),
                                    children: [
                                      TextSpan(text: _getTruncatedText(widget.description)),
                                      TextSpan(
                                        text: ' See more',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: const Color.fromARGB(255, 75, 123, 245),
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            setState(() {
                                              _showFullDescription = true;
                                            });
                                          },
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                )
                              : Text(
                                  widget.description,
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: grey,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                          if (_showFullDescription)
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    _showFullDescription = false;
                                  });
                                },
                                child: Text(
                                  'Show less',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: lightgrey,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 20),
                     
                      TabBar(
                        controller: _tabController,
                        tabs: [
                          Tab(
                            child: Text(
                              'Preview',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
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
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: _tabController.index == 1
                                    ? black
                                    : lightgrey,
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Reviews',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: _tabController.index == 2
                                    ? black
                                    : lightgrey,
                              ),
                            ),
                          ),
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
                                          course_id: widget.course_id, // Add course_id parameter
                                        ),
                                        SizedBox(height: 20),
                                        // Remove the separate action button since it's now included in AboutCourse
                                      ],
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Lessons(
                                          lessons: _addedmaterials,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Add the Reviews tab
                                  Reviews(),
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
    return ActionButton(
      active: active,
      pending: pending,
      course_id: widget.course_id,
    );
  }

  // Helper method to get text that fits in approximately 4 lines
  String _getTruncatedText(String text) {
    // This is a simple approximation - in a real implementation you might want to
    // use a more sophisticated approach to measure text
    int maxLength = 200; // Approximate length for 4 lines
    if (text.length <= maxLength) {
      return text;
    }
    // Try to truncate at a word boundary
    String truncated = text.substring(0, maxLength);
    int lastSpace = truncated.lastIndexOf(' ');
    if (lastSpace > 0) {
      truncated = truncated.substring(0, lastSpace);
    }
    return truncated;
  }
}