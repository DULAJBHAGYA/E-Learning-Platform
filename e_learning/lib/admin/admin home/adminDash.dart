import 'package:e_learning/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import 'adminDashCourses.dart';
import 'adminDashStudents.dart';
import 'adminInfo.dart';
import 'adminStats.dart';

class AdminDash extends StatelessWidget {
  const AdminDash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(UniconsLine.bars, size: 30, color: black,),
                        Spacer(),
                        Icon(UniconsLine.bell, size: 30, color: black,),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              AdminInfo(),
              SizedBox(height: 20,),
              Expanded( // Added Expanded to allow ListView to take up remaining space
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      AdminStats(),
                      SizedBox(height: 20,),  
                      AdminDashStudents(),
                      SizedBox(height: 20,),
                      AdminDashCourses()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

