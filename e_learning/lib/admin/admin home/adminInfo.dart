import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';

class AdminInfo extends StatelessWidget {
  const AdminInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'WELCOME BACK',
                    style: GoogleFonts.openSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: grey,
                    ),
                  ),
                  Text(
                    'Nick Madison',
                    style: GoogleFonts.openSans(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 60,
                height: 60,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('/images/admin.png'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
