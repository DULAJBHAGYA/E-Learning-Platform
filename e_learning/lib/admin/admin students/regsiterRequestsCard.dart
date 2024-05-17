import 'package:flutter/material.dart';

import '../../color.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterRequestsCard extends StatelessWidget {
  const RegisterRequestsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: white,
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Image
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('images/user1.jpg'),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dulaj Bhagya',
                  style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold, color: black),
                ),
                SizedBox(height: 5),
                Text(
                  'dbhagya',
                  style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.bold, color: lightgrey),
                ),
                SizedBox(height: 5),
                Text(
                  'dulajupananda@gmail.com',
                  style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.bold, color: lightgrey),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(5), 
                        backgroundColor: white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: darkblue, width: 2)),
                        ),
                      
                      child: Text('Accept', style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.bold, color: darkblue)),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(5), backgroundColor: white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: red, width: 2)),
                      ),
                      child: Text('Decline', style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.bold, color: red)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

