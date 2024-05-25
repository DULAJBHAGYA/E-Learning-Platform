import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../color.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //user profile photo
        // SizedBox(
        //   width: 60,
        //   height: 60,
        //   child: CircleAvatar(
        //     radius: 48,
        //     backgroundImage: AssetImage('/images/user1.jpg'),
        //   ),
        // ),

        SizedBox(width: 10),

        //user name
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: 'Find Your ',
                style: GoogleFonts.poppins(
                    fontSize: 28, fontWeight: FontWeight.bold, color: black),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Best',
                      style: GoogleFonts.poppins(
                          fontSize: 28,
                          color: blue,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  'Online Course',
                  style: GoogleFonts.poppins(
                      fontSize: 28, fontWeight: FontWeight.bold, color: black),
                ),
                SizedBox(
                  width: 10,
                ),
                Image.asset('/images/fireemoji.png', width: 40, height: 40)
              ],
            ),
          ],
        ),

        // Spacer to push notification icon to the right
        Spacer(),

        //notification icon
        Align(
          alignment: Alignment.topRight,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: white,
            ),
            child: SizedBox(
              width: 40,
              height: 40,
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Iconsax.notification_status4,
                      size: 30,
                      color: black,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: darkblue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Center(
                        child: Text(
                          '10',
                          style: GoogleFonts.poppins(
                            color: white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
