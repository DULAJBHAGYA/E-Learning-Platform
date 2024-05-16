import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

import '../../color.dart';
import '../../shared/bottomNavBar.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: Column(
            children: [
              //user info
              UserInfo(),


              SizedBox(height: 30),

              //count details
              UserStats(),

              SizedBox(height: 30),

               //course filter
              HorizontalListview(),

              SizedBox(height: 30),

              CourseList(),
            ],
          ),
        ),
      
      ),

      bottomNavigationBar: BottomNavBar(),  
    );                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
  }
}

class UserStats extends StatelessWidget {
  const UserStats({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
    
              children: [
                
                Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: lightblue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text('10', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: black),),
                        Text('Courses', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: black),),
                      ],
                    ),    
                  )
                )  ,
    
                SizedBox(width: 10),
    
                Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: darkblue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text('10', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: white),),
                        Text('Registered \nCourses', textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: white),),
                      ],
                    ),    
                  )
                )  ,
    
                SizedBox(width: 10),
    
                Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: lightblue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text('10', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: black),),
                        Text('Ongoing \nCourses', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: black),),
                      ],
                    ),    
                  )
                )  
    
    
              ],
            ),
          ],    
    )
    ),
    
    
    );
  }
}

class CourseList extends StatelessWidget {
  const CourseList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView( // Wrap with SingleChildScrollView
        child: Column(
          children: [
            Container(
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
                          image: AssetImage('/images/aibasic.png'),
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
                          child: Text('Artificial Intelligence', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: darkblue),),
                        ),
    
                        SizedBox(height: 5),
    
                        Text('Artificial Intelligence \nBasic', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: black),),
    
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
    
            SizedBox(height: 10),
    
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
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: lightblue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text('Data Science', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: darkblue),),
                        ),
    
                        SizedBox(height: 5),
    
                        Text('Data Science \nAdvanced', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: black),),
    
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
    
            SizedBox(height: 10),
    
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
                          image: AssetImage('/images/csintermediate.png'),
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
                          child: Text('Cyber Security', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: darkblue),),
                        ),
    
                        SizedBox(height: 5),
    
                        Text('Cyber Security \nIntermediate', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold, color: black),),
    
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
    
            SizedBox(height: 10),
    
    
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
    
    
    
    
          ],
        ),
      ),
    );
  }
}


class HorizontalListview extends StatelessWidget {
  const HorizontalListview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Popular Courses', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: black),),

                Spacer(),

                Text('See All', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: darkblue),),
              ],
            ),
    
            SizedBox(height:10),
    
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: darkblue, width: 2),
                    ),
                    child: Text('All Courses 🔥', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: darkblue),),
                  ),
    
                  SizedBox(width: 10),
    
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: darkblue, width: 2),
                    ),
                    child: Text('Data Science 📈', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: darkblue),),
                  ),
    
                  SizedBox(width: 10),
    
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: darkblue, width: 2),
                    ),
                    child: Text('Machine Learning 👨‍💻', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: darkblue),),
                  ),
    
                  SizedBox(width: 10),
    
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: darkblue, width: 2),
                    ),
                    child: Text('Artificial Intelligence 🤖', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: darkblue),),
                  ),
    
                  SizedBox(width: 10),
    
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: darkblue, width: 2),
                    ),
                    child: Text('Cyber Security 🔒', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600, color: darkblue),),
                  ),
                  
                ],
              )
            )
          ],
        ),
      );
  }
}


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
            backgroundImage: AssetImage('/images/user.png'),
          ),
        ),
    
        SizedBox(width: 10),
    
        //user name
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello! 👋', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w400, color: black),),
            Text('Dulaj Bhagya', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: black),),
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
            child: Icon(EneftyIcons.notification_bing_outline, size: 25, color: black,),
          ),
        ),
      ],
    );
  }
}



class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width:MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: grey, width: 1),
      ),
      child: Row(
        children: [
          Icon(UniconsLine.search, size: 20, color: lightgrey,),
          SizedBox(width: 10),
          Text('search courses here', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: lightgrey),),
        ],
      ),
    );
  }
}
