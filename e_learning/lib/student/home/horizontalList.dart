import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';
import '../all courses/allCourses.dart';

class HorizontalListview extends StatelessWidget {
  const HorizontalListview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Courses',
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w600, color: black),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StdAllCourses(
                              username: '',
                              refreshToken: '',
                              accessToken: '')));
                },
                child: Text(
                  'See All',
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: grey),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
