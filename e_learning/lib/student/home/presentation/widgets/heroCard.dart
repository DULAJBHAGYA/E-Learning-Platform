import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../color.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: darkblue,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            // Left side - Image
            Container(
              width: 180,
              height: 180,
              child: Image.asset(
                'assets/images/heroImage.png',
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  // Fallback widget if image fails to load
                  return Icon(
                    Icons.image_not_supported,
                    color: Colors.white,
                    size: 50,
                  );
                },
              ),
            ),
            // Right side - Text and button
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Learn New Skills',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: black,
                    ),
                  ),
                  Text(
                    'Expand your knowledge with our courses',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () {
                      // Add your button action here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      elevation: 0,
                    ),
                    child: Text(
                      'Get Started',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: white,
                      ),
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