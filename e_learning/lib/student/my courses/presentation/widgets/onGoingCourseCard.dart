import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../color.dart';
import '../../../course content/courseContent.dart';

class OnGoingCourseCard extends StatelessWidget {
  final String image;
  final String title;
  final String catagory;
  final int progress;
  final int course_id;

  const OnGoingCourseCard({
    required this.image,
    required this.title,
    required this.catagory,
    required this.progress,
    required this.course_id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseContent(
              course_id: course_id,
              progress: progress,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image without padding
            Container(
              height: 110,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  // Use AssetImage for local assets instead of NetworkImage
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
            // Content with padding
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category in uppercase
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      catagory.toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: lightgrey,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 5),
                  
                  // Title
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: black,
                    ),
                  ),
                  
                  SizedBox(height: 10),
                  
                  // Instructor info and progress - each on separate lines
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Instructor info in one line
                      Row(
                        children: [
                          // Instructor avatar
                          CircleAvatar(
                            radius: 12,
                            backgroundImage: AssetImage('assets/images/dulaj.jpg'), // Replace with actual instructor image
                            backgroundColor: background2,
                          ),
                          SizedBox(width: 10),
                          // Instructor name
                          Text(
                            'John Doe', // Replace with actual instructor name
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      // Progress info on separate line
                      Row(
                        children: [
                          // Completed lessons count
                          RichText(
                            text: TextSpan(
                              style: GoogleFonts.plusJakartaSans(
                              ),
                              children: [
                                TextSpan(
                                  text: 'Lessons   ',
                                  style: TextStyle(fontWeight: FontWeight.w500, color: lightgrey, fontSize: 12), // lighter
                                ),
                                TextSpan(
                                  text: '7',
                                  style: TextStyle(fontWeight: FontWeight.w600, color: grey, fontSize: 14), // bolder
                                ),
                                TextSpan(
                                  text: '/12',
                                  style: TextStyle(fontWeight: FontWeight.w500, color: lightgrey, fontSize: 12), // lighter
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          // Progress circle
                          CircularPercentIndicator(
                            radius: 10.0,
                            lineWidth: 2.0,
                            progressColor: darkblue,
                            animation: true,
                            percent: progress / 100,
                          ),
                          SizedBox(width: 5),
                          // Progress percentage text to the right of the circle
                          Text(
                            '${progress.toString()}%',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                              color: darkblue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}