import 'package:e_learning/color.dart';
import 'package:e_learning/shared/searchBar.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCourses extends StatefulWidget {
  const AddCourses({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;

  @override
  _AddCoursesState createState() => _AddCoursesState();
}

class _AddCoursesState extends State<AddCourses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('AddCourses', 
              style: GoogleFonts.openSans(fontSize: 30, fontWeight: FontWeight.bold, color: black),
              ),

              SizedBox(height: 20,),

              CustomSearchBar(),

              SizedBox(height: 20,),

              Row(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       Container(
                         alignment: Alignment.center,
                         padding: EdgeInsets.all(5),
                         decoration: BoxDecoration(
                           color: darkblue,
                           borderRadius: BorderRadius.circular(5),
                         ),
                         child: Text(
                           'ADD NEW COURSE',
                           style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w700, color: white),
                         ),
                       ),
                     ],
                   ),

                   SizedBox(height: 20,),

                   SingleChildScrollView(
                     scrollDirection: Axis.vertical,
                     child: Row(
                       children: [
                                        
                        Container(
                          height: 150,
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
                                  height: 100,
                                  width: 100,
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
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: lightblue,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text('MACHINE LEARNING', style: GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.w600, color: darkblue),),
                                    ),
                                  
                                    SizedBox(height: 5),
                                  
                                    Text('Machine Learning Basic', overflow: TextOverflow.visible, style: GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.bold, color: black),),
                                  
                                    SizedBox(height: 5),
                                  
                                    
                              
                              ]
                            ),
                              ]
                          )
                        ),
                        )
                       ],
                   )

                   )

            ]
          ),
        ),
      ),
    );
  }
}