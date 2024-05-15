import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart'; 


class CourseDescription extends StatefulWidget {
  const CourseDescription({Key? key}) : super(key: key);

  @override
  _CourseDescriptionState createState() => _CourseDescriptionState();
}

class _CourseDescriptionState extends State<CourseDescription>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('/images/bg.jpg'),
                              fit: BoxFit.cover)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Icon(
                            EneftyIcons.arrow_left_4_outline,
                            size: 30,
                            color: white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Data Science Basic',
                        style: GoogleFonts.poppins(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: black),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: 150,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: lightblue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Data Science',
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: blue),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(EneftyIcons.people_bold,
                                  size: 20, color: blue),
                              SizedBox(width: 10),
                              Text('120 Students',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: black)),
                            ],
                          ),
                          SizedBox(width: 15),
                          Row(
                            children: [
                              Icon(EneftyIcons.clock_2_bold,
                                  size: 20, color: blue),
                              SizedBox(width: 10),
                              Text('2.5 Hours',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: black)),
                            ],
                          ),
                          SizedBox(width: 15),
                          Row(
                            children: [
                              Icon(EneftyIcons.document_bold,
                                  size: 20, color:blue),
                              SizedBox(width: 10),
                              Text('Certificate',
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: black)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      TabBar(
                        controller: _tabController,
                        tabs: [
                          Tab(
                            child: Text(
                              'About',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: lightgrey,
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Lessons',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: lightgrey,
                              ),
                            ),
                          )
                        ],
                        indicator: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.blue,
                              width: 2,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              // Content of the first tab ('About')
                              AboutCourse(),
                              // Content of the second tab ('Lessons')
                              Text('Lessons',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AboutCourse extends StatelessWidget {
  const AboutCourse({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // About Course
            Container(
              child: Column(
                children: [
                  Text(
                    'About Course',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: black,
                    ),
                  
                  
                  ),

                  SizedBox(height: 10),

            Text(
              'In this introductory course to data science, students will embark on a journey to understand the fundamental concepts, techniques, and tools used in the field of data science. The course aims to equip learners with a solid foundation in data science principles, enabling them to extract insights from data and make informed decisions.',
              textAlign: TextAlign.justify,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: black,
              ),
            ),
                ],
              ),
            
            ),

            SizedBox(height: 20),


             Container(
              child: Column(
                children: [
                  Text(
                    'Prerequisites',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: black,
                    ),
                  
                  
                  ),

                  SizedBox(height: 10),

                 ListView(
                  children: [
                    ListTile(
                        leading: Icon(EneftyIcons.check_outline),
                        title: Text('Basic understanding of mathematics and statistics'),
                      ),
                      ListTile(
                        leading: Icon(EneftyIcons.chrome_outline),
                        title: Text('Familiarity with programming concepts (preferably Python)'),
            ),
                  ],
                 )
                ],
              ),
            
            ),
            
          ],
        ),
      ),
    );
  }
}
