import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';

class RegisterdStudentsCard extends StatelessWidget {
  const RegisterdStudentsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: white,
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Image
          CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('images/user1.jpg'),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dulaj Bhagya',
                  style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.bold, color: black),
                ),
                SizedBox(height: 5),
                Text(
                  'dbhagya',
                  style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.bold, color:lightgrey),
                ),
                
                
              ],
            ),
          ),
          Spacer(),
          Icon(Icons.more_vert, color: black, size: 20),
        ],
      ),
    );
  }
}
