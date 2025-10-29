import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';

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

  String _formatWhatWill(Map<String, dynamic> whatWill) {
    String formattedString = '';

    if (whatWill.containsKey('what_will_you_learn')) {
      formattedString += 'What will you learn:\n';
      whatWill['what_will_you_learn'].forEach((key, value) {
        formattedString += ' - $value\n';
      });
    }

    if (whatWill.containsKey('what_skil_you_gain')) {
      formattedString += '\nWhat skills you will gain:\n';
      whatWill['what_skil_you_gain'].forEach((key, value) {
        formattedString += ' - $value\n';
      });
    }

    if (whatWill.containsKey('who_should_learn')) {
      formattedString += '\nWho should learn:\n';
      whatWill['who_should_learn'].forEach((key, value) {
        formattedString += ' - $value\n';
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Course',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: black,
                    ),
                  ),
                  SizedBox(height: 10),
                  if (what_will != null)
                    Text(
                      _formatWhatWill(what_will!),
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: black,
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