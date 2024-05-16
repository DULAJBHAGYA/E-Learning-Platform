import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

import '../../color.dart';


class AdminStats extends StatelessWidget {
  const AdminStats({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
    
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width*0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: darkblue,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                     

                      Text('233', style: GoogleFonts.openSans(fontSize: 30, fontWeight: FontWeight.bold, color: white),),
                      Text('Registered Students', style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w700, color: white),),
                    ],
                  ),    
                )
              )  ,
    
              SizedBox(width: 5),
    
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width*0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: darkblue,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                     

                      Text('17', style: GoogleFonts.openSans(fontSize: 30, fontWeight: FontWeight.bold, color: white),),
                      Text('Courses', style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w700, color: white),),
                    ],
                  ),    
                )
              )  ,
              
            ]
          ),
    
          SizedBox(height: 10,),
    
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width*0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: darkblue,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                     

                      Text('176', style: GoogleFonts.openSans(fontSize: 30, fontWeight: FontWeight.bold, color: white),),
                      Text('Enrolled Students', style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w700, color: white),),
                    ],
                  ),    
                )
              )  ,
    
              SizedBox(width: 5),
    
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width*0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: darkblue,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('7', style: GoogleFonts.openSans(fontSize: 30, fontWeight: FontWeight.bold, color: white),),
                      Text('Admins', style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w700, color: white),),
                    ],
                  ),    
                )
              )  ,
              
            ]
          )
        ]
      ),
    );
  }
}

