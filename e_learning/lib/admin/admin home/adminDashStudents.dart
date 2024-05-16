import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';

class AdminDashStudents extends StatelessWidget {
  const AdminDashStudents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Row(
              children: [
                Text('Students', style: GoogleFonts.openSans(fontSize: 20, fontWeight: FontWeight.bold, color: black),),
                Spacer(),
                Text('View all', style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w600, color: darkblue),),
              ],
            ),
    
            SizedBox(height: 10,),
    
            AdminDashStudentsDisplayCard(),
    
            SizedBox(height: 5,),

            AdminDashStudentsDisplayCard(),

            SizedBox(height: 5,),

            AdminDashStudentsDisplayCard(),
                      ],
                    ),
                  )
    );
  }
}

class AdminDashStudentsDisplayCard extends StatelessWidget {
  const AdminDashStudentsDisplayCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('/images/user1.jpg'),
                ),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dulaj Bhagya', style: GoogleFonts.openSans(fontSize: 20, fontWeight: FontWeight.w700, color: black),),
                    SizedBox(height: 5,),
                    Text('dbhagya', style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w600, color: grey),),
                    SizedBox(height: 5,),
                    Text('dulajupananda@gmail.com', style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w600, color: grey),),
                  ],
                ),
              ],
            ),
          ]
          ),
        )
    );
  }
}

