import 'package:e_learning/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminInfo extends StatelessWidget {
  final String first_name;
  final String last_name;
  final String picture;

  const AdminInfo({
    required this.first_name,
    required this.last_name,
    required this.picture,
    Key? key,
  }) : super(key: key);

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
                    'Hello,',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: grey,
                    ),
                  ),
                  Text(
                    '$first_name $last_name',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: black,
                    ),
                  ),
                  Text(
                    'Have a great day at work!',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: grey,
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: picture.isNotEmpty
                          ? NetworkImage(picture)
                          : AssetImage('assets/images/user.png') as ImageProvider,
                      backgroundColor: background2,
                    ),
                  ),
                  // Notification count circle
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: darkblue,
                        shape: BoxShape.circle,
                        border: Border.all(color: white, width: 2),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 20,
                        minHeight: 20,
                      ),
                      child: Center(
                        child: Text(
                          '3', // This should be replaced with actual notification count
                          style: GoogleFonts.poppins(
                            color: white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}