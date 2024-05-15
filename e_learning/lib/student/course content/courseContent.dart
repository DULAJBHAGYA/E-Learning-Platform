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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CourseContentHeader(),
            SizedBox(height: 40),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    LessonDisplayWidget(),
                    SizedBox(height: 20),
                    QuizDisplayWidget(),
                    SizedBox(height: 20),
                    LessonDisplayWidget(),
                    SizedBox(height: 20),
                    LessonDisplayWidget(),
                    SizedBox(height: 20),
                    LessonDisplayWidget(),
                    SizedBox(height: 20),
                    QuizDisplayWidget(),
                    SizedBox(height: 20),
                    LessonDisplayWidget(),
                    SizedBox(height: 20),
                    LessonDisplayWidget(),
                    SizedBox(height: 20),
                    LessonDisplayWidget(),
                    SizedBox(height: 20),
                    QuizDisplayWidget(),
                  ],
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
        color: darkblue,
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
                  color: white,
                ),
    )
    
              ),
    
              Spacer(),
              Spacer(),
              Spacer(),
              Spacer(),
    
              Align(
                alignment: Alignment.centerRight,
                child: Icon(EneftyIcons.message_question_bold, color: white, size: 40)),
    
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
      color: darkblue,
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
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: white,
              ),
              overflow: TextOverflow.clip,
            ),
          ),
    
          Spacer(),
    
          
        Icon(EneftyIcons.play_circle_bold, color: white, size: 40),
    
              
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
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MyCourses()));
            },
            child: Icon(
              EneftyIcons.arrow_left_4_outline,
              color: black,
              size: 30,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Column(
              children: [
                Text(
                  'Data Science Basic',
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: black),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: lightblue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Data Science',
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: darkblue),
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
              progressColor: darkblue,
              animation: true,
              percent: 0.7,
              center: new Text(
                "70.0%",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700, fontSize: 15.0),
              ),
            )
          ]),
        ],
      ),
    );
  }
}
