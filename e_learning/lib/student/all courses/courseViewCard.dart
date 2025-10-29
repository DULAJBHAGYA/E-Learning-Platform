import 'package:e_learning/student/course%20display/courseDescription.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../color.dart';

class CourseViewCard extends StatefulWidget {
  final int course_id;
  final String description;
  final String image;
  final String title;
  final String catagory;
  final Map<String, dynamic> what_will;
  final String duration; // Add duration parameter
  final String level;

  const CourseViewCard({
    required this.course_id,
    required this.image,
    required this.title,
    required this.catagory,
    required this.description,
    required this.what_will,
    required this.duration, // Add duration to constructor
    required this.level,
    Key? key,
  }) : super(key: key);

  @override
  State<CourseViewCard> createState() => _CourseViewCardState();
}

class _CourseViewCardState extends State<CourseViewCard> {
  // Mock material count
  int materialCount = 12;

  @override
  void initState() {
    super.initState();
    // Use mock data instead of fetching from API
    // fetchMaterialCountByCourseId();
  }

  // Comment out the real fetch function
  /*
  Future<void> fetchMaterialCountByCourseId() async {
    try {
      final response = await CountService.instance
          .getMaterialCountByCourseId(widget.course_id);

      if (response != null) {
        if (response is int) {
          setState(() {
            materialCount = response;
          });
        } else {
          throw Exception('Student count is not an integer');
        }
      } else {
        throw Exception('Response is null');
      }
    } catch (e) {
      print('Error fetching student count: $e');
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDescription(
              course_id: widget.course_id,
              image: widget.image,
              title: widget.title,
              catagory: widget.catagory,
              description: widget.description,
              what_will: widget.what_will,
              level: widget.level, // Pass the level parameter
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: white,
        ),
        child: Column(
          children: [
            // image
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 0), // adjust as needed
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  image: DecorationImage(
                    image: AssetImage(widget.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: 20.0,
                top: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            widget.catagory.toUpperCase(),
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: lightgrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: black,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Level: ${widget.level}',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: black,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(Iconsax.video_play, size: 12, color: black),
                          SizedBox(width: 5),
                          Text(
                            '${materialCount.toString()} Lessons',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      Row(
                        children: [
                          Icon(Iconsax.shield_tick, size: 12, color: black),
                          SizedBox(width: 5),
                          Text(
                            'Certificate',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      Row(
                        children: [
                          Icon(Iconsax.clock, size: 12, color: black),
                          SizedBox(width: 5),
                          Text(
                            widget.duration,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: black,
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
      ),
    );
  }
}