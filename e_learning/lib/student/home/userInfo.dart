import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

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
        SizedBox(
          width: 60,
          height: 60,
          child: CircleAvatar( 
            radius: 48,  
            backgroundImage: AssetImage('/images/user1.jpg'),
          ),
        ),
    
        SizedBox(width: 10),
    
        //user name
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello! 👋', style: GoogleFonts.openSans(fontSize: 20, fontWeight: FontWeight.w600, color: black),),
            Text('Dulaj Bhagya', style: GoogleFonts.openSans(fontSize: 20, fontWeight: FontWeight.w700, color: black),),
          ],
        ),
    
        // Spacer to push notification icon to the right
        Spacer(),
    
        //notification icon
        Align(
          alignment: Alignment.topRight,
          child: SizedBox(
            width: 60,
            height: 60,
            child: Icon(UniconsLine.bell, size: 30, color: black,),
          ),
        ),
      ],
    );
  }
}



