import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';
import 'actionButton.dart'; // Import the ActionButton widget

class AboutCourse extends StatelessWidget {
  final Map<String, dynamic>? what_will;
  final bool active;
  final bool pending;
  final int course_id; // Add course_id parameter

  const AboutCourse({
    required this.what_will,
    required this.active,
    required this.pending,
    required this.course_id, // Add course_id to constructor
    Key? key,
  }) : super(key: key);

  String _formatWhatWill(Map<String, dynamic> whatWill) {
    String formattedString = '';

    if (whatWill.containsKey('what_will_you_learn')) {
      formattedString += 'What will you learn:\n';
      whatWill['what_will_you_learn'].forEach((key, value) {
        formattedString += ' • $value\n';
      });
    }

    if (whatWill.containsKey('what_skil_you_gain')) {
      formattedString += '\nWhat skills you will gain:\n';
      whatWill['what_skil_you_gain'].forEach((key, value) {
        formattedString += ' • $value\n';
      });
    }

    if (whatWill.containsKey('who_should_learn')) {
      formattedString += '\nWho should learn:\n';
      whatWill['who_should_learn'].forEach((key, value) {
        formattedString += ' • $value\n';
      });
    }

    return formattedString;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: background2,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About This Course',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: black,
                    ),
                  ),
                  SizedBox(height: 15),
                  if (what_will != null)
                    Text(
                      _formatWhatWill(what_will!),
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: black,
                      ),
                    ),
                  SizedBox(height: 20),
                  // Add a stylish enrollment section
                  Container(
                    decoration: BoxDecoration(
                      color: blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ready to start learning?',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: black,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Enroll now to get full access to all course materials and track your progress.',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: grey,
                          ),
                        ),
                        SizedBox(height: 15),
                        // Add enrollment buttons
                        Align(
                          alignment: Alignment.centerRight,
                          child: ActionButton(
                            active: active,
                            pending: pending,
                            course_id: course_id,
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
      ),
    );
  }
}