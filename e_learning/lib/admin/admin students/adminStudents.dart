import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_learning/shared/bottomNavBar.dart'; // Adjust the import path as per your project structure
import 'package:percent_indicator/percent_indicator.dart';

import '../../color.dart';

class AdminStudents extends StatefulWidget {
  const AdminStudents({Key? key}) : super(key: key);

  @override
  _AdminStudentsState createState() => _AdminStudentsState();
}

class _AdminStudentsState extends State<AdminStudents> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Students',
              style: GoogleFonts.openSans(
                fontSize: 30,
                fontWeight: FontWeight.bold,
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
                          'All Students',
                          style: GoogleFonts.openSans(
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
                              '45',
                              style: GoogleFonts.openSans(
                                fontSize:12,
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
                          'Requests',
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
                              '13', 
                              style: GoogleFonts.poppins(
                                fontSize:12,
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
                  RegiseredStudentsCard(),


                  // Content of the second tab ('Completed')
                  CompletedCourses(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class CompletedCourses extends StatelessWidget {
  const CompletedCourses({Key? key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: white,
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Image
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage('images/user.png'),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dulaj Bhagya',
                        style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'dbhagya',
                        style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'dulajupananda@gmail.com',
                        style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Spacer(),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10), 
                              backgroundColor: white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: darkblue, width: 2)),
                              ),
                            
                            child: Text('Accept', style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w400, color: darkblue)),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10), backgroundColor: white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),
                              side: BorderSide(color: red, width: 2)),
                            ),
                            child: Text('Decline', style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w400, color: red)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RegiseredStudentsCard extends StatelessWidget {
  const RegiseredStudentsCard({
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
