import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';

class Topcategories extends StatelessWidget {
  const Topcategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Categories',
            style: GoogleFonts.poppins(
                fontSize: 18, fontWeight: FontWeight.w700, color: black),
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: science,
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: ImageFiltered(
                            imageFilter:
                                ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                            child: Image.asset(
                              '/images/science.png',
                              height: 110,
                              width: 110,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SCIENCE',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: it,
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            '/images/it.png',
                            height: 110,
                            width: 110,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'IT',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: science,
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: ImageFiltered(
                            imageFilter:
                                ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                            child: Image.asset(
                              '/images/science.png',
                              height: 110,
                              width: 110,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Science',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: science,
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: ImageFiltered(
                            imageFilter:
                                ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                            child: Image.asset(
                              '/images/science.png',
                              height: 110,
                              width: 110,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Science',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: science,
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: ImageFiltered(
                            imageFilter:
                                ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                            child: Image.asset(
                              '/images/science.png',
                              height: 110,
                              width: 110,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Science',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
