import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:e_learning/shared/bottomNavBar.dart'; // Adjust the import path as per your project structure
import 'package:percent_indicator/percent_indicator.dart';

import '../../color.dart';
import 'completedCourses.dart';

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
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'MyCourses',
              style: GoogleFonts.nunito(
                fontSize: 28,
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
                      'Ongoing',
                      style: GoogleFonts.nunito(
                        fontSize: 15, 
                        fontWeight: FontWeight.w500, 
                        color: _tabController.index == 0 ? darkblue : lightgrey, 
                      ),
                    ),
                    SizedBox(width: 10), 
                    Container(
                      width: 20, 
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: _tabController.index == 0 ? darkblue : lightgrey,  
                      ),
                      child: Center(
                        child: Text(
                          '5',
                          style: GoogleFonts.nunito(
                            fontSize:15,
                            color: white, 
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Tab(
                child: Row(
                  children: [
                    Text(
                      'Completed',
                      style: GoogleFonts.nunito(
                        fontSize: 15, 
                        fontWeight: FontWeight.w500, 
                        color: _tabController.index == 1 ? darkblue : lightgrey, 
                      ),
                    ),
                    SizedBox(width: 10), 
                    Container(
                      width: 20, 
                      height: 20, 
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: _tabController.index == 1 ? darkblue : lightgrey, 
                      ),
                      child: Center(
                        child: Text(
                          '10', 
                          style: GoogleFonts.nunito(
                            fontSize:15,
                            color: white, 
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
            onTap: (index) {
              setState(() {
                _tabController.index = index;
              });
            },
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
          color: white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              //image
              Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('/images/python.png'),
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
                  
                
                
                  Text('Python \nProgramming', style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w700, color: black),),

                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: background2,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text('IT', overflow: TextOverflow.clip, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.bold, color: lightgrey),),
                  ),

                
                  SizedBox(height: 5),
                
                  
                ]
              ),
    
              Spacer(),
    
              CircularPercentIndicator(
                radius: 40.0,
                lineWidth: 8.0,
                progressColor: it,
                animation: true,
                percent: 0.7,
                center: new Text(
                  "70.0%",
                  style:
                      GoogleFonts.nunito(fontWeight: FontWeight.w900, fontSize: 15.0),
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
          color: white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              //image
              Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('/images/physics.jpg'),
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
                  
                
                
                  Text('Physics', style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w700, color: black),),

                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: background2,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text('SCIENCE', overflow: TextOverflow.clip, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.bold, color: lightgrey),),
                  ),

                
                  SizedBox(height: 5),
                
                  
                ]
              ),
    
              Spacer(),
    
              CircularPercentIndicator(
                radius: 40.0,
                lineWidth: 8.0,
                progressColor: science,
                animation: true,
                percent: 0.7,
                center: new Text(
                  "34.0%",
                  style:
                      GoogleFonts.nunito(fontWeight: FontWeight.w900, fontSize: 15.0),
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
          color: white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              //image
              Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('/images/geometry.jpg'),
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
                  
                
                
                  Text('Geometric \nAnalysis', style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w700, color: black),),

                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: background2,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text('MATHS', overflow: TextOverflow.clip, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.bold, color: lightgrey),),
                  ),

                
                  SizedBox(height: 5),
                
                  
                ]
              ),
    
              Spacer(),    
              CircularPercentIndicator(
                radius: 40.0,
                lineWidth: 8.0,
                progressColor: maths,
                animation: true,
                percent: 0.7,
                center: new Text(
                  "89.0%",
                  style:
                      GoogleFonts.nunito(fontWeight: FontWeight.w900, fontSize: 15.0),
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
          color: white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              //image
              Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('/images/german.jpg'),
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
                  
                
                
                  Text('German \nLanguage', style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w700, color: black),),

                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: background2,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text('LANGUAGE', overflow: TextOverflow.clip, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.bold, color: lightgrey),),
                  ),

                
                  SizedBox(height: 5),
                
                  
                ]
              ),
    
              Spacer(),
    
              CircularPercentIndicator(
                radius: 40.0,
                lineWidth: 8.0,
                progressColor: language,
                animation: true,
                percent: 0.7,
                center: new Text(
                  "12.0%",
                  style:
                      GoogleFonts.nunito(fontWeight: FontWeight.w900, fontSize: 15.0),
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
          color: white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              //image
              Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('/images/3dmodeling.png'),
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
                  
                
                
                  Text('3D Modeling', style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w700, color: black),),

                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: background2,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text('OTHER', overflow: TextOverflow.clip, style: GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.bold, color: lightgrey),),
                  ),

                
                  SizedBox(height: 5),
                
                  
                ]
              ),
    
              Spacer(),
    
              CircularPercentIndicator(
                radius: 40.0,
                lineWidth: 8.0,
                progressColor: other,
                animation: true,
                percent: 0.7,
                center: new Text(
                  "94.0%",
                  style:
                      GoogleFonts.nunito(fontWeight: FontWeight.w900, fontSize: 15.0),
                ),
              )
            
            ]
          ),
        )
      ),

      SizedBox(height: 20),
      

        ],
      ),
    );
  }
}
