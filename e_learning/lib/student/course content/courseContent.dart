import 'package:e_learning/student/my%20courses/myCourses.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            CourseContentHeader(
              title: title,
              image: image,
              catagory: catagory,
              progress: progress,
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
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
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ExpansionPanelList(
        dividerColor: white,
        expandIconColor: black,
        elevation: 1,
        expandedHeaderPadding: EdgeInsets.all(0),
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        children: [
          ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(
                  widget.title,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: black,
                  ),
                ),
              );
            },
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => _launchFileViewer(widget.material_file),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: darkblue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              'VIEW MATERIAL',
                              style: GoogleFonts.poppins(
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        )),
                  ),
                  for (var url in widget.urls)
                    if (url.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    YoutubePlayerScreen(url: url),
                              ),
                            );
                          },
                          child: Text(
                            url,
                            style: GoogleFonts.poppins(
                              color: darkblue,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                  for (var assignment in widget.assignments)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
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
                        child: Text(
                          assignment['title'],
                          style: GoogleFonts.poppins(
                            color: black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) async {
                          setState(() {
                            isChecked = value!;
                          });
                          await _updateProgress(isChecked);
                        },
                      ),
                      Text(
                        'Done',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            isExpanded: _isExpanded,
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
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                decoration: BoxDecoration(
                  color: it,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyCourses()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      EneftyIcons.arrow_left_3_outline,
                      color: black,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        title,
                        overflow: TextOverflow.fade,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          catagory.toUpperCase(),
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: darkblue,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          EneftyIcons.video_play_outline,
                          color: blue,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Sessions 4/6',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: lightgrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                CircularPercentIndicator(
                  radius: 45.0,
                  lineWidth: 8.0,
                  progressColor: darkblue,
                  animation: true,
                  percent: progress / 100,
                  center: Text(
                    '${progress.toString()}%',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}