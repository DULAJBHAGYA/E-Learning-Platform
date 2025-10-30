import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';

class Lessons extends StatelessWidget {
  final List<dynamic> lessons;

  const Lessons({
    required this.lessons,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy data for 12 lessons
    List<Map<String, String>> dummyLessons = [
      {
        'title': 'Introduction to Course',
        'description': 'Learn the basics and get started with the course content.'
      },
      {
        'title': 'Core Concepts',
        'description': 'Understanding the fundamental principles of the subject.'
      },
      {
        'title': 'Practical Applications',
        'description': 'Apply what you\'ve learned in real-world scenarios.'
      },
      {
        'title': 'Advanced Techniques',
        'description': 'Explore advanced methods and best practices.'
      },
      {
        'title': 'Case Studies',
        'description': 'Analyze real examples and their outcomes.'
      },
      {
        'title': 'Hands-on Exercises',
        'description': 'Practice with guided exercises to reinforce learning.'
      },
      {
        'title': 'Troubleshooting',
        'description': 'Learn how to identify and solve common problems.'
      },
      {
        'title': 'Performance Optimization',
        'description': 'Improve efficiency and optimize your work.'
      },
      {
        'title': 'Security Best Practices',
        'description': 'Ensure your work is secure and follows industry standards.'
      },
      {
        'title': 'Testing and Validation',
        'description': 'Verify your work and ensure quality results.'
      },
      {
        'title': 'Deployment Strategies',
        'description': 'Learn how to effectively deploy your solutions.'
      },
      {
        'title': 'Course Wrap-up',
        'description': 'Review key concepts and prepare for next steps.'
      },
    ];

    return Column(
      children: List.generate(12, (index) {
        Map<String, String> lesson = dummyLessons[index];
        return Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${index + 1}. ${lesson['title']!}',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: black,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    lesson['description']!,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: grey,
                    ),
                  ),
                ],
              ),
            ),
            // Horizontal divider line (except for the last item)
            if (index < 11)
              Divider(
                color: lightgrey,
                thickness: .5,
                height: 1,
              ),
          ],
        );
      }),
    );
  }
}