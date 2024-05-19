import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

import '../../color.dart';
import 'registerStudents.dart';
import 'registerrequests.dart';

class AdminStudents extends StatefulWidget {
  const AdminStudents({
Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;
  
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
            Row(
              children: [
                Text(
                  'Students',
                  style: GoogleFonts.nunito(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: black,
                  ),
                ),
                Spacer(),
                Icon(UniconsLine.bars, size: 30, color: black,),
              ],
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
                              '45',
                              style: GoogleFonts.nunito(
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
                              '13', 
                              style: GoogleFonts.nunito(
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
                  // Content of the first tab ('Registered Students')
                  RegiseredStudents(),


                  // Content of the second tab ('Registered Requests')
                  RegisterRequests(),
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



