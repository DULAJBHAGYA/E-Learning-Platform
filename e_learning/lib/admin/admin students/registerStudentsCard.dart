import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';

class RegisterdStudentsCard extends StatelessWidget {
  final String user_name;
  final String first_name;
  final String last_name;
  final String email;

  const RegisterdStudentsCard({
    required this.user_name,
    required this.first_name,
    required this.last_name,
    required this.email,
    Key? key,
  }) : super(key: key);

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
                  '$first_name + $last_name',
                  style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.bold, color: black),
                ),
                SizedBox(height: 5),
                Text(
                  '$user_name',
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
