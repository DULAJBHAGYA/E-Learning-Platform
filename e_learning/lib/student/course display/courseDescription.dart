import 'package:e_learning/student/all%20courses/allCourses.dart';
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
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const StdAllCourses()));
                            },
                            child: Icon(
                              EneftyIcons.arrow_left_4_outline,
                              size: 30,
                              color: Colors.white,
                            ),
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
                                      color:black)),
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
                                  size: 20, color: blue),
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
                              color: blue,
                              width: 2,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            // Content of the first tab ('About')
                            SingleChildScrollView(child: AboutCourse()),
                            // Content of the second tab ('Lessons')
                            SingleChildScrollView(
                              child: Lessons(),
                            ),
                          ],
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

class Lessons extends StatelessWidget {
  const Lessons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                leading: Icon(EneftyIcons.chart_success_outline, color: black),
                title: Text('Introduction to Data Science', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, color: black),),
                subtitle: Text('Students will learn about the role of data science in today\'s world, its applications across various industries, and the skills required to become proficient in the field.', 
                textAlign: TextAlign.justify,
                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, color: black),),
              ),
              SizedBox(height: 10),


              ListTile(
                leading: Icon(EneftyIcons.chart_success_outline, color: black),
                title: Text('Data Exploration and Visualization', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, color: black),),
                subtitle: Text('This module will cover techniques for exploring and visualizing data, including descriptive statistics, data cleaning, and visualization libraries such as Matplotlib and Seaborn.', 
                textAlign: TextAlign.justify,
                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, color: black),),
              ),

              SizedBox(height: 10),

              ListTile(
                leading: Icon(EneftyIcons.chart_success_outline, color: black),
                title: Text('Statistical Analysis', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, color: black),),
                subtitle: Text('Students will delve into statistical concepts essential for data analysis, including probability distributions, hypothesis testing, and regression analysis.', 
                textAlign: TextAlign.justify,
                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, color: black),),
              ),

              SizedBox(height: 10),

              ListTile(
                leading: Icon(EneftyIcons.chart_success_outline, color: black),
                title: Text('Machine Learning Basics', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, color: black),),
                subtitle: Text('An introduction to machine learning algorithms and techniques, including supervised and unsupervised learning, classification, regression, and clustering.', 
                textAlign: TextAlign.justify,
                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, color: black),),
              ),

              SizedBox(height: 10),

              ListTile(
                leading: Icon(EneftyIcons.chart_success_outline, color: black),
                title: Text('Introduction to Python for Data Science', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, color: black),),
                subtitle: Text('A hands-on introduction to the Python programming language, focusing on its applications in data science, data manipulation with Pandas, and data visualization with Matplotlib and Seaborn.', 
                textAlign: TextAlign.justify,
                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, color: black),),
              ),

              SizedBox(height: 10),

              ListTile(
                leading: Icon(EneftyIcons.chart_success_outline, color: black),
                title: Text('Capstone Project', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, color: black),),
                subtitle: Text('Students will apply their knowledge and skills acquired throughout the course to complete a real-world data science project. This project will involve data acquisition, preprocessing, analysis, modeling, and presentation of findings.', 
                textAlign: TextAlign.justify,
                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, color: black),),
              ),
            ],
          )
        ]
      ),
    );
  }
}

class AboutCourse extends StatelessWidget {
  const AboutCourse({Key? key}) : super(key: key);

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
                crossAxisAlignment: CrossAxisAlignment.start,
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

            // Prerequisites
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ListTile(
                        leading: Icon(EneftyIcons.check_outline),
                        title: Text(
                            'Basic understanding of mathematics and statistics'),
                      ),
                      ListTile(
                        leading: Icon(EneftyIcons.chrome_outline),
                        title: Text(
                            'Familiarity with programming concepts (preferably Python)'),
                      ),
                    ],
                  )
                ],
              ),
            ),

            SizedBox(height: 20),

            // Who can take this course
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Who can take this course',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'This course is ideal for beginners with an interest in data science and analytics. It is suitable for students, professionals, and anyone looking to embark on a career in data science or related fields.',
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

            //enroll button
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: darkblue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text('Enroll', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: white),),
                            ),
              ],
            ),
          ]
        )
      )
        );
      
  }
}
