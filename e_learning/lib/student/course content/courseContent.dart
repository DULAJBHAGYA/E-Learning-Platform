import 'package:e_learning/student/my%20courses/myCourses.dart';
import 'package:flutter/material.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../color.dart';

class CourseContent extends StatelessWidget {
  const CourseContent({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            CourseContentHeader(),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      LessonDisplayWidget(),
                      SizedBox(height: 5),
                      QuizDisplayWidget(),
                      SizedBox(height: 5),
                      LessonDisplayWidget(),
                      SizedBox(height: 5),
                      LessonDisplayWidget(),
                      SizedBox(height: 5),
                      LessonDisplayWidget(),
                      SizedBox(height: 5),
                      QuizDisplayWidget(),
                      SizedBox(height: 5),
                      LessonDisplayWidget(),
                      SizedBox(height: 5),
                      LessonDisplayWidget(),
                      SizedBox(height: 5),
                      LessonDisplayWidget(),
                      SizedBox(height: 5),
                      QuizDisplayWidget(),
                    ],
                  ),
                ),
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
            Flexible(
              child: Text(
                'Quiz 1',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: black,
                ),
    )
    
              ),
    
              Spacer(),
              Spacer(),
              Spacer(),
              Spacer(),
    
              Align(
                alignment: Alignment.centerRight,
                child: Icon(EneftyIcons.message_question_bold, color: it, size: 40)),
    
                      ],
                    ),
                  )
                );
  }
}

class LessonDisplayWidget extends StatelessWidget {
  const LessonDisplayWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
    width: MediaQuery.of(context).size.width,
    height: 100,
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
              'Introduction to Data Science',
              style: GoogleFonts.nunito(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: black,
              ),
            ),
          ),
    
          Spacer(),
    
          
        Icon(EneftyIcons.play_circle_bold, color: it, size: 30),
    
              
            ],
          ),
        
      
    ),
   );
  }
}

class CourseContentHeader extends StatelessWidget {
  const CourseContentHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                child: Image.asset(
                  'images/python.png',
                  fit: BoxFit.cover,
                ),
              ),

              GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MyCourses()));
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
            ]
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start, 
              children: [
              Column(
                children: [
                  Text(
                    'Pyhton Programming',
                    style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'IT',
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: it),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    Icon(
                      EneftyIcons.video_play_outline,
                      color: lightgrey,
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
                progressColor: it,
                animation: true,
                percent: 0.7,
                center: new Text(
                  "70.0%",
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
