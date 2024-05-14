import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_learning/shared/bottomNavBar.dart'; // Adjust the import path as per your project structure
import 'package:percent_indicator/percent_indicator.dart';

import '../../color.dart';

class MyCourses extends StatefulWidget {
  const MyCourses({Key? key}) : super(key: key);

  @override
  _MyCoursesState createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'MyCourses',
              style: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: black,
              ),
            ),
            SizedBox(height: 20),
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  child: Row(
                      children: [
                        Text(
                          'Ongoing',
                          style: GoogleFonts.poppins(
                            fontSize: 15, 
                            fontWeight: FontWeight.w500, 
                            color: lightgrey, 
                          ),
                        ),
                        SizedBox(width: 10), 
                        Container(
                          width: 20, 
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: lightgrey, 
                          ),
                          child: Center(
                            child: Text(
                              '5',
                              style: GoogleFonts.poppins(
                                color: white, 
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )

                ),


                Tab(
                  child: Row(
                      children: [
                        Text(
                          'Completed',
                          style: GoogleFonts.poppins(
                            fontSize: 15, 
                            fontWeight: FontWeight.w500, 
                            color: lightgrey, 
                          ),
                        ),
                        SizedBox(width: 10), 
                        Container(
                          width: 20, 
                          height: 20, 
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: lightgrey, 
                          ),
                          child: Center(
                            child: Text(
                              '10', 
                              style: GoogleFonts.poppins(
                                color: white, 
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )

                ),
              ],
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: darkblue, 
                    width: 2, 
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Content of the first tab ('Ongoing')
                  OnGoingCourses(),


                  // Content of the second tab ('Completed')
                  CompletedCourses(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class CompletedCourses extends StatelessWidget {
  const CompletedCourses({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
          height: 170,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                //image
                Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('/images/mlbasic.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                  
                SizedBox(width: 20),
                  
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: lightblue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('Machine Learning', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: darkblue),),
                    ),
                  
                    SizedBox(height: 5),
                  
                    Text('Machine Learning \nBasic', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: black),),
                  
                    SizedBox(height: 5),
                  
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: darkblue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('Review Course', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: white),),
                    ),
                  ]
                ),
              
              ]
            ),
          )
        ),
    
        SizedBox(height: 20),
    
        Container(
          height: 170,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                //image
                Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('/images/mlbasic.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                  
                SizedBox(width: 20),
                  
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: lightblue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('Machine Learning', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: darkblue),),
                    ),
                  
                    SizedBox(height: 5),
                  
                    Text('Machine Learning \nBasic', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: black),),
                  
                    SizedBox(height: 5),
                  
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: darkblue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('View Details', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: white),),
                    ),
                  ]
                ),
              
              ]
            ),
          )
        ),
    
        ]
      ),
    );
  }
}

class OnGoingCourses extends StatelessWidget {
  const OnGoingCourses({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: background,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              //image
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('/images/dsadvanced.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
                
              SizedBox(width: 20),
                
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('Data Science', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: grey),),
                  ),
                
                  SizedBox(height: 5),
                
                  Text('Data Science \nAdvanced', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: black),),
                
                  SizedBox(height: 5),
                
                  
                ]
              ),
    
              SizedBox(width: 20),
    
              CircularPercentIndicator(
                radius: 40.0,
                lineWidth: 8.0,
                progressColor: darkblue,
                animation: true,
                percent: 0.7,
                center: new Text(
                  "70.0%",
                  style:
                      GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 15.0),
                ),
              )
            
            ]
          ),
        )
      ),

      SizedBox(height: 20),

      Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: background,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              //image
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('/images/dsadvanced.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
                
              SizedBox(width: 20),
                
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('Machine Learning', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: grey),),
                  ),
                
                  SizedBox(height: 5),
                
                  Text('ML \nAdvanced', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: black),),
                
                  SizedBox(height: 5),
                
                  
                ]
              ),
    
              SizedBox(width: 20),
    
              CircularPercentIndicator(
                radius: 40.0,
                lineWidth: 8.0,
                progressColor: darkblue,
                animation: true,
                percent: 0.2,
                center: new Text(
                  "20.0%",
                  style:
                      GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 15.0),
                ),
              )
            
            ]
          ),
        )
      ),
      
      SizedBox(height: 20),

      Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: background,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              //image
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('/images/dsadvanced.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
                
              SizedBox(width: 20),
                
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('Artifical Intelligence', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: grey),),
                  ),
                
                  SizedBox(height: 5),
                
                  Text('Natural Lang. \nProcessing', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: black),),
                
                  SizedBox(height: 5),
                
                  
                ]
              ),
    
              SizedBox(width: 10),
    
              CircularPercentIndicator(
                radius: 40.0,
                lineWidth: 8.0,
                progressColor: darkblue,
                animation: true,
                percent: 0.4,
                center: new Text(
                  "40.0%",
                  style:
                      GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 15.0),
                ),
              )
            
            ]
          ),
        )
      ),

        ],
      ),
    );
  }
}
