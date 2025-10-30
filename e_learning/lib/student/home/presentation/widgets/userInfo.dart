import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../color.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // User name section
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
  text: TextSpan(
    style: GoogleFonts.plusJakartaSans(
      fontSize: 24,
      color: black,
    ),
    children: [
            TextSpan(
              text: 'Hello, ',
              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600), // lighter
            ),
            TextSpan(
              text: 'Dulaj!',
              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800), // bolder
            ),
          ],
        ),
      ),
            Text(
              'Explore the best courses with us',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: grey,
              ),
            ),
           
          ],
        ),

        // Spacer to push profile image to the right
        Spacer(),

        // User profile photo with online status indicator
        Stack(
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: CircleAvatar(
                radius: 48,
                backgroundImage: AssetImage('assets/images/dulaj.jpg'),
                backgroundColor: Colors.grey[300],
              ),
            ),
            // Online status indicator
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}