import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';

class AdminDashCourses extends StatelessWidget {
  const AdminDashCourses({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Courses'.toUpperCase(),
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.w700, color: black),
                ),
                Spacer(),
                Text(
                  'View all',
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: darkblue),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            AdminDashCoursessDisplayCard(),
            SizedBox(
              height: 10,
            ),
            AdminDashCoursessDisplayCard(),
            SizedBox(
              height: 10,
            ),
            AdminDashCoursessDisplayCard(),
          ],
        ),
      ),
    );
  }
}

class AdminDashCoursessDisplayCard extends StatelessWidget {
  const AdminDashCoursessDisplayCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(children: [
            //image
            Container(
              height: 95,
              width: 95,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('/images/ai1.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            SizedBox(width: 20),

            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'DATA SCIENCE',
                  style: GoogleFonts.openSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: lightgrey),
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Data Science Advanced',
                style: GoogleFonts.openSans(
                    fontSize: 15, fontWeight: FontWeight.w600, color: black),
              ),
              SizedBox(height: 5),
            ]),

            SizedBox(width: 20),
          ]),
        ));
  }
}
