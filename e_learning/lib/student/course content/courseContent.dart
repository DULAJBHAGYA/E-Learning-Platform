import 'package:e_learning/student/my%20courses/presentation/pages/myCourses.dart';
import 'package:flutter/material.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:shared_preferences/shared_preferences.dart'; // Comment out real service
// import 'package:url_launcher/url_launcher.dart'; // Comment out real service

import '../../color.dart';
// import '../../services/courseServices.dart'; // Comment out real service
// import '../../services/materialServices.dart'; // Comment out real service
// import '../../services/progressServices.dart'; // Comment out real service
import '../submit assignment/submitAssignment.dart';
import '../videos display/videoDisplay.dart';
import '../videos display/ytVideoPlayer.dart';

class CourseContent extends StatefulWidget {
  const CourseContent({
    Key? key,
    required this.course_id,
    required this.progress,
  }) : super(key: key);

  final int course_id;
  final int progress;

  @override
  _CourseContentState createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent> {
  // Mock data for course contents
  List<Map<String, dynamic>> _mockContents = [
    {
      'title': 'Introduction to Flutter',
      'material_file': 'assets/pdfs/intro_flutter.pdf',
      'resource': {
        'resourse_link': {
          'url1': 'https://example.com/flutter_intro',
          'url2': 'https://example.com/flutter_setup',
          'url3': 'https://example.com/flutter_basics',
        }
      },
      'assignments': [
        {
          'title': 'Setup Flutter Environment',
          'file': 'assets/pdfs/flutter_setup_assignment.pdf',
          'assignment_id': 1
        }
      ]
    },
    {
      'title': 'Widgets and Layouts',
      'material_file': 'assets/pdfs/widgets_layouts.pdf',
      'resource': {
        'resourse_link': {
          'url1': 'https://example.com/widgets_overview',
          'url2': 'https://example.com/layout_basics',
          'url3': 'https://example.com/flutter_layouts',
        }
      },
      'assignments': [
        {
          'title': 'Create Basic Layout',
          'file': 'assets/pdfs/layout_assignment.pdf',
          'assignment_id': 2
        }
      ]
    },
    {
      'title': 'State Management',
      'material_file': 'assets/pdfs/state_management.pdf',
      'resource': {
        'resourse_link': {
          'url1': 'https://example.com/state_intro',
          'url2': 'https://example.com/provider_pattern',
          'url3': 'https://example.com/state_best_practices',
        }
      },
      'assignments': [
        {
          'title': 'Implement State Management',
          'file': 'assets/pdfs/state_assignment.pdf',
          'assignment_id': 3
        }
      ]
    },
  ];

  // Mock course details
  late int course_id = 1;
  late String title = 'Introduction to Flutter Development';
  late String image = 'assets/images/flutter.png';
  late String catagory = 'Mobile Development';
  late int progress = 75;

  List<dynamic> _contents = [];

  @override
  void initState() {
    super.initState();
    // Use mock data instead of fetching from API
    _contents = _mockContents;
    course_id = widget.course_id;
    // fetchMaterials();
    // fetchCourseDetails();
    // fetchProgress();
    // updateProgress(false);
  }

  // Comment out the real fetch functions
  /*
  Future<void> fetchMaterials() async {
    try {
      final courseContentData = await MaterialService.instance
          .fetchMaterialssForStudents(widget.course_id);
      setState(() {
        _contents = courseContentData['material'] ?? [];
      });
    } catch (e) {
      print('Error fetching materials: $e');
    }
  }

  Future<void> fetchCourseDetails() async {
    try {
      final response =
          await CourseService.instance.fetchCourseById(widget.course_id);

      setState(() {
        title = response['title'];
        image = response['image'];
        catagory = response['catagory'];
      });
    } catch (e) {
      print('Error fetching course details: $e');
    }
  }

  Future<void> fetchProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final user_id = prefs.getInt('user_id');
      if (user_id != null) {
        final progressData = await ProgressService.instance.gteProgress(
          user_id: user_id,
          course_id: widget.course_id,
        );
        setState(() {
          progress = progressData['progress'];
        });
      }
    } catch (e) {
      print('Error fetching progress: $e');
    }
  }

  Future<void> updateProgress(bool completed) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final user_id = prefs.getInt('user_id');
      if (user_id != null) {
        await ProgressService.instance.editProgress(
          completed: completed,
          course_id: widget.course_id,
          user_id: user_id,
        );
        await fetchProgress();
      }
    } catch (e) {
      print('Error updating progress: $e');
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(EneftyIcons.arrow_left_3_outline, size: 20, color: black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyCourses(),
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20), // Add padding for the entire screen
          child: Column(
            children: [
              CourseContentHeader(
                title: title,
                image: image,
                catagory: catagory,
                progress: progress,
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: _contents.map((content) {
                      final material_file = content['material_file'];
                      final resource = content['resource'];
                      final resourseLink = resource['resourse_link'];
                      final urls = [
                        resourseLink['url1'] as String,
                        resourseLink['url2'] as String,
                        resourseLink['url3'] as String,
                      ];
                      final assignments = content['assignments']
                              ?.map((e) => {
                                    'title': e['title'],
                                    'file': e['file'],
                                    'assignment_id': e['assignment_id']
                                  })
                              .toList() ??
                          [];
                      return LessonDisplayWidget(
                        title: content['title'] as String,
                        urls: urls,
                        assignments: assignments,
                        course_id: widget.course_id,
                        material_file: material_file,
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              if (progress > 98)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: ButtonStyle(),
                        onPressed: () async {
                          // await updateProgress(true);
                        },
                        child: Text(
                          'COMPLETED',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: darkblue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class LessonDisplayWidget extends StatefulWidget {
  final String title;
  final List<String> urls;
  final List assignments;
  final int course_id;
  final String material_file;

  const LessonDisplayWidget({
    required this.title,
    required this.urls,
    required this.assignments,
    required this.course_id,
    required this.material_file,
    Key? key,
  }) : super(key: key);

  @override
  _LessonDisplayWidgetState createState() => _LessonDisplayWidgetState();
}

class _LessonDisplayWidgetState extends State<LessonDisplayWidget> {
  bool isChecked = false;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  // Comment out the real launch function
  /*
  void _launchFileViewer(String filePath) {
    launch(filePath);
  }
  */

  // Mock function to simulate file viewing
  void _launchFileViewer(String filePath) {
    // In a real app, this would launch the file viewer
    print('Launching file: $filePath');
  }

  // Comment out the real progress functions
  /*
  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final progressKey = 'progress_${widget.title}';
    setState(() {
      isChecked = prefs.getBool(progressKey) ?? false;
    });
  }

  Future<void> _updateProgress(bool completed) async {
    final prefs = await SharedPreferences.getInstance();
    final progressKey = 'progress_${widget.title}';
    await prefs.setBool(progressKey, completed);

    try {
      final user_id = prefs.getInt('user_id');
      if (user_id == null || widget.course_id == null) {
        throw Exception('User ID or Course ID not found');
      }

      await ProgressService.instance.editProgress(
        completed: completed,
        course_id: widget.course_id,
        user_id: user_id!,
      );
    } catch (e) {
      print('Error updating progress: $e');
    }
  }
  */

  // Mock progress functions
  Future<void> _loadProgress() async {
    // Simulate loading progress from local storage
    setState(() {
      isChecked = false; // Default to not completed
    });
  }

  Future<void> _updateProgress(bool completed) async {
    // Simulate updating progress
    print('Updating progress for ${widget.title} to $completed');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Lesson header/title
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              widget.title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: black,
              ),
            ),
          ),
          // Horizontal divider
          Divider(
            color: Colors.grey[300],
            thickness: 1,
            height: 1,
          ),
          // Lesson content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Lesson video with play icon and check circle
                if (widget.urls.isNotEmpty && widget.urls.any((url) => url.isNotEmpty)) ...[
                  Text(
                    'Lesson Video',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: black,
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the first video URL
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              YoutubePlayerScreen(url: widget.urls.firstWhere((url) => url.isNotEmpty)),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        // Check circle icon
                        Icon(
                          isChecked ? EneftyIcons.tick_circle_bold : EneftyIcons.tick_circle_outline,
                          color: isChecked ? darkblue : grey,
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        Icon(
                          EneftyIcons.video_play_outline,
                          color: darkblue,
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Play Video',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: black,
                            ),
                          ),
                        ),
                        Icon(
                          EneftyIcons.arrow_right_3_outline,
                          color: grey,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
                // Lesson material with document icon and check circle
                Text(
                  'Lesson Material',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: black,
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () => _launchFileViewer(widget.material_file),
                  child: Row(
                    children: [
                      // Check circle icon
                      Icon(
                        isChecked ? EneftyIcons.tick_circle_bold : EneftyIcons.tick_circle_outline,
                        color: isChecked ? darkblue : grey,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Icon(
                        EneftyIcons.document_outline,
                        color: darkblue,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'View Material',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: black,
                          ),
                        ),
                      ),
                      Icon(
                        EneftyIcons.arrow_right_3_outline,
                        color: grey,
                        size: 16,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Additional resources section with check circles
                if (widget.urls.length > 1 || (widget.urls.length == 1 && widget.urls[0] != widget.urls.firstWhere((url) => url.isNotEmpty, orElse: () => ''))) ...[
                  Text(
                    'Additional Resources',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      for (int i = 0; i < widget.urls.length; i++)
                        if (widget.urls[i].isNotEmpty && (widget.urls.length <= 1 || widget.urls[i] != widget.urls.firstWhere((url) => url.isNotEmpty, orElse: () => ''))) ...[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      YoutubePlayerScreen(url: widget.urls[i]),
                                ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  // Check circle icon
                                  Icon(
                                    isChecked ? EneftyIcons.tick_circle_bold : EneftyIcons.tick_circle_outline,
                                    color: isChecked ? darkblue : grey,
                                    size: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    EneftyIcons.link_2_outline,
                                    color: darkblue,
                                    size: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'Resource ${i + 1}',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: black,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    EneftyIcons.arrow_right_3_outline,
                                    color: grey,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                    ],
                  ),
                  SizedBox(height: 20),
                ],
                // Assignments section with check circles
                if (widget.assignments.isNotEmpty) ...[
                  Text(
                    'Assignments',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      for (var assignment in widget.assignments) ...[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SubmitAssignment(
                                  username: '',
                                  accessToken: '',
                                  refreshToken: '',
                                  course_id: widget.course_id,
                                  assignment_id: assignment['assignment_id'],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                // Check circle icon
                                Icon(
                                  isChecked ? EneftyIcons.tick_circle_bold : EneftyIcons.tick_circle_outline,
                                  color: isChecked ? darkblue : grey,
                                  size: 20,
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  EneftyIcons.document_text_outline,
                                  color: darkblue,
                                  size: 20,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    assignment['title'],
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: black,
                                    ),
                                  ),
                                ),
                                Icon(
                                  EneftyIcons.arrow_right_3_outline,
                                  color: grey,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CourseContentHeader extends StatelessWidget {
  final String title;
  final String image;
  final String catagory;
  final int progress;

  const CourseContentHeader({
    required this.title,
    required this.image,
    required this.catagory,
    required this.progress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.15, // Match CourseDescription height
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(30)), // Match CourseDescription
                ),
              ),
              // Removed the back button from the image
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
                  title,
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
                          backgroundImage: AssetImage('assets/images/dulaj.jpg'),
                          backgroundColor: background2,
                        ),
                        SizedBox(width: 10),
                        // Teacher name
                        Text(
                          'John Doe',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: grey,
                          ),
                        ),
                      ],
                    ),
                    // Progress indicator (moved from CourseDescription rating position)
                    Row(
                      children: [
                        // Replace star icon with circular progress indicator
                        Container(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            value: progress / 100,
                            strokeWidth: 2,
                            backgroundColor: lightgrey,
                            color: darkblue,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '${progress.toString()}%', // Show progress percentage instead of rating
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
                // Category badge (moved to match CourseDescription description position)
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}