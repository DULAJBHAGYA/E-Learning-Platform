import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';

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
                'Recommended Courses',
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.w700, color: black),
              ),
              Spacer(),
              Text(
                'See All',
                style: GoogleFonts.poppins(
                    fontSize: 15, fontWeight: FontWeight.w400, color: darkblue),
              ),
            ],
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: background2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'ALL COURSES',
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: lightgrey),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: background2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'IT',
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: lightgrey),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: background2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'SCIENCE',
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: lightgrey),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: background2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'MATH',
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: lightgrey),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: background2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'LANGUAGE',
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: lightgrey),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: background2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'OTHER',
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: lightgrey),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
