import 'package:e_learning/student/my%20courses/myCourses.dart';
import 'package:flutter/material.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../color.dart';
import '../../services/courseServices.dart';
import '../../services/materialServices.dart';

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

  @override
  void initState() {
    super.initState();
    fetchMaterials();
    fetchCourseDetails();
  }

  Future<void> fetchMaterials() async {
    try {
      final courseContentData = await MaterialService.instance
          .fetchMaterialssForStudents(widget.course_id);
      setState(() {
        _contents = courseContentData['material'] ?? [];
      });
    } catch (e) {
      print('Error fetching courses: $e');
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
              progress: widget.progress,
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
                      return LessonDisplayWidget(
                        title: content['title'] as String,
                        urls: urls,
                      );
                    }).toList(),
                  ),
                ),
              ),
            )
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
              Flexible(
                  child: Text(
                'Quiz 1',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: black,
                ),
              )),
              Spacer(),
              Spacer(),
              Spacer(),
              Spacer(),
              Align(
                  alignment: Alignment.centerRight,
                  child: Icon(EneftyIcons.message_question_bold,
                      color: it, size: 40)),
            ],
          ),
        ));
  }
}

class LessonDisplayWidget extends StatefulWidget {
  final String title;
  final List<String> urls;

  const LessonDisplayWidget({
    required this.title,
    required this.urls,
    Key? key,
  }) : super(key: key);

  @override
  _LessonDisplayWidgetState createState() => _LessonDisplayWidgetState();
}

class _LessonDisplayWidgetState extends State<LessonDisplayWidget> {
  bool _isChecked = false;

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ExpansionTile(
        title: Text(
          widget.title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        children: [
          for (int i = 0; i < widget.urls.length; i++)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  _launchURL(widget.urls[i]);
                },
                child: Text(
                  widget.urls[i],
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.blue,
                    decoration: i == widget.urls.length - 1
                        ? TextDecoration.none
                        : TextDecoration.underline,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CheckboxListTile(
                  title: Text(
                    'Done',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value ?? false;
                    });
                  },
                ),
              ),
            ],
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
          Stack(children: [
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
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyCourses()));
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
          ]),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Column(
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(
                      title,
                      overflow: TextOverflow.fade,
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: black),
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
                            color: darkblue),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: [
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
                          color: lightgrey),
                    ),
                  ])
                ],
              ),
              Spacer(),
              CircularPercentIndicator(
                radius: 45.0,
                lineWidth: 8.0,
                progressColor: blue,
                animation: true,
                percent: progress / 100,
                center: new Text(
                  '${progress.toString()}%',
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w900, fontSize: 15.0),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
