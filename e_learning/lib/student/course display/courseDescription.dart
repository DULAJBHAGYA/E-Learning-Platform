import 'package:e_learning/student/all%20courses/allCourses.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

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
                    ClipPath(
                      clipper: MyClipper(),
                      child: Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('/images/3dmodeling.png'),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const StdAllCourses()));
                            },
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Iconsax.arrow_left_2,
                                        size: 20,
                                        color: black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '3D Modeling',
                        style: GoogleFonts.nunito(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                        'OTHER',
                          style: GoogleFonts.openSans(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: other),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(EneftyIcons.people_bold,
                                    size: 20, color: lightgrey),
                                SizedBox(width: 2),
                                Text('120 Students',
                                    style: GoogleFonts.nunito(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color:black)),
                              ],
                            ),
                            SizedBox(width: 10),
                            Row(
                              children: [
                                Icon(EneftyIcons.clock_2_bold,
                                    size: 20, color: lightgrey),
                                SizedBox(width: 2),
                                Text('2.5 Hours',
                                    style: GoogleFonts.nunito(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: black)),
                              ],
                            ),
                            SizedBox(width: 10),
                            Row(
                              children: [
                                Icon(EneftyIcons.document_bold,
                                    size: 20, color: lightgrey),
                                SizedBox(width: 2),
                                Text('Certificate',
                                    style: GoogleFonts.nunito(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: black)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      TabBar(
                        controller: _tabController,
                        tabs: [
                          Tab(
                            child: Text(
                              'About',
                              style: GoogleFonts.nunito(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: _tabController.index == 0 ? black : lightgrey,
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Lessons',
                              style: GoogleFonts.nunito(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: _tabController.index == 1 ? black : lightgrey,
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
                        onTap: (index) {
                          setState(() {
                            _tabController.index = index;
                          });
                        },
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

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    // Start from top-left corner
    path.lineTo(0, 0);

    // Draw line to the bottom left corner
    path.lineTo(0, size.height);

    final firstCurve = Offset(0, size.height-30);
    final lastCurve = Offset(40, size.height-30);
    path.quadraticBezierTo(firstCurve.dx, firstCurve.dy, lastCurve.dx, lastCurve.dy);

    final secondCurve = Offset(size.width-40, size.height-30);
    final thirdCurve = Offset(size.width-40, size.height-30);
    path.quadraticBezierTo(secondCurve.dx, secondCurve.dy, thirdCurve.dx, thirdCurve.dy);

    final lastCurve2 = Offset(size.width, size.height-30);
    final firstCurve2 = Offset(size.width, size.height);
    path.quadraticBezierTo(lastCurve2.dx, lastCurve2.dy, firstCurve2.dx, firstCurve2.dy);
    // Draw line to the top-right corner
    path.lineTo(size.width, 0);

    // Close the path to form the shape
    path.close();

    return path;
  }
  
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false; // Return true if the new instance needs to repaint the path
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
                title: Text('Introduction to Data Science', style: GoogleFonts.openSans(fontSize: 18,fontWeight: FontWeight.w600, color: black),),
                subtitle: Text('Students will learn about the role of data science in today\'s world, its applications across various industries, and the skills required to become proficient in the field.', 
                textAlign: TextAlign.justify,
                style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w400, color: black),),
              ),
              SizedBox(height: 10),


              ListTile(
                leading: Icon(EneftyIcons.chart_success_outline, color: black),
                title: Text('Data Exploration and Visualization', style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.w600, color: black),),
                subtitle: Text('This module will cover techniques for exploring and visualizing data, including descriptive statistics, data cleaning, and visualization libraries such as Matplotlib and Seaborn.', 
                textAlign: TextAlign.justify,
                style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w400, color: black),),
              ),

              SizedBox(height: 10),

              ListTile(
                leading: Icon(EneftyIcons.chart_success_outline, color: black),
                title: Text('Statistical Analysis', style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.w600, color: black),),
                subtitle: Text('Students will delve into statistical concepts essential for data analysis, including probability distributions, hypothesis testing, and regression analysis.', 
                textAlign: TextAlign.justify,
                style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w400, color: black),),
              ),

              SizedBox(height: 10),

              ListTile(
                leading: Icon(EneftyIcons.chart_success_outline, color: black),
                title: Text('Machine Learning Basics', style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.w600, color: black),),
                subtitle: Text('An introduction to machine learning algorithms and techniques, including supervised and unsupervised learning, classification, regression, and clustering.', 
                textAlign: TextAlign.justify,
                style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w400, color: black),),
              ),

              SizedBox(height: 10),

              ListTile(
                leading: Icon(EneftyIcons.chart_success_outline, color: black),
                title: Text('Introduction to Python for Data Science', style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.w600, color: black),),
                subtitle: Text('A hands-on introduction to the Python programming language, focusing on its applications in data science, data manipulation with Pandas, and data visualization with Matplotlib and Seaborn.', 
                textAlign: TextAlign.justify,
                style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w400, color: black),),
              ),

              SizedBox(height: 10),

              ListTile(
                leading: Icon(EneftyIcons.chart_success_outline, color: black),
                title: Text('Capstone Project', style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.w600, color: black),),
                subtitle: Text('Students will apply their knowledge and skills acquired throughout the course to complete a real-world data science project. This project will involve data acquisition, preprocessing, analysis, modeling, and presentation of findings.', 
                textAlign: TextAlign.justify,
                style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w400, color: black),),
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
                    style: GoogleFonts.openSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'In this introductory course to data science, students will embark on a journey to understand the fundamental concepts, techniques, and tools used in the field of data science. The course aims to equip learners with a solid foundation in data science principles, enabling them to extract insights from data and make informed decisions.',
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.openSans(
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
                    style: GoogleFonts.openSans(
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
                            'Basic understanding of mathematics and statistics',
                            style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w400, color: black),
                            ),
                      ),
                      ListTile(
                        leading: Icon(EneftyIcons.chrome_outline),
                        title: Text(
                            'Familiarity with programming concepts (preferably Python)', 
                            style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w400, color: black),
                            ),
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
                    style: GoogleFonts.openSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'This course is ideal for beginners with an interest in data science and analytics. It is suitable for students, professionals, and anyone looking to embark on a career in data science or related fields.',
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.openSans(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: darkblue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text('Enroll', style: GoogleFonts.nunito(fontSize: 15, fontWeight: FontWeight.bold, color: white),),
                                ),
                  ],
                ),
              ],
            ),
          ]
        )
      )
        );
      
  }
}
