import 'package:e_learning/student/my%20courses/myCourses.dart';
import 'package:flutter/material.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../color.dart';
import '../../services/courseServices.dart';
import '../../services/materialServices.dart';
import '../../services/progressServices.dart';
import '../submit assignment/submitAssignment.dart';
import '../videos display/videoDisplay.dart';

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
  List<dynamic> _contents = [];
  late int course_id;
  late String title = '';
  late String image = '';
  late String catagory = '';
  late int progress = widget.progress;

  @override
  void initState() {
    super.initState();
    fetchMaterials();
    fetchCourseDetails();
    fetchProgress();
    updateProgress(false);
  }

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
                                    'file': e['assignment_file'],
                                    'assignment_id': e['assignment_id']
                                  })
                              .toList() ??
                          [];
                      return LessonDisplayWidget(
                        title: content['title'] as String,
                        urls: urls,
                        assignments: assignments,
                        course_id: widget.course_id,
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
                        await updateProgress(true);
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

class QuizDisplayWidget extends StatelessWidget {
  const QuizDisplayWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Text(
                'Quiz 1',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: black,
                ),
              )),
              Spacer(),
              Icon(EneftyIcons.message_question_bold, color: it, size: 40),
            ],
          ),
        ));
  }
}

class LessonDisplayWidget extends StatefulWidget {
  final String title;
  final List<String> urls;
  final List<dynamic> assignments;
  final int course_id;

  const LessonDisplayWidget({
    required this.title,
    required this.urls,
    required this.assignments,
    required this.course_id,
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
                  for (var url in widget.urls)
                    if (url.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VideoDisplay(url: url),
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
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 40,
                        ),
                      );
                    },
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
                  progressColor: blue,
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
