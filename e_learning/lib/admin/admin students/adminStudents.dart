import 'package:e_learning/shared/sideMenuBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unicons/unicons.dart';

import '../../color.dart';
import '../../services/countServices.dart';
import '../admin home/adminDash.dart';
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

class _AdminStudentsState extends State<AdminStudents>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;
  int studentCount = 0;
  int subscriptionRequestCount = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchStudentCount();
    fetchSubscriptionRequestsCount();
  }

  Future<void> fetchStudentCount() async {
    try {
      final response = await CountService.instance.getStudentCount();

      if (response != null) {
        if (response is int) {
          setState(() {
            studentCount = response;
          });
        } else {
          throw Exception('Student count is not an integer');
        }
      } else {
        throw Exception('Response is null');
      }
    } catch (e) {
      print('Error fetching student count: $e');
    }
  }

  Future<void> fetchSubscriptionRequestsCount() async {
    try {
      final response =
          await CountService.instance.getSubscriptionRequestCount();

      if (response != null) {
        if (response is int) {
          setState(() {
            subscriptionRequestCount = response;
          });
        } else {
          throw Exception('Student count is not an integer');
        }
      } else {
        throw Exception('Response is null');
      }
    } catch (e) {
      print('Error fetching student count: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      key: _scaffoldKey,
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        leading: IconButton(
          icon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Iconsax.menu_1, size: 30, color: black),
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: Image.asset(
                        '/logos/logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Students',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: black,
                  ),
                ),
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
                      style: GoogleFonts.poppins(
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
                          studentCount.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
                Tab(
                    child: Row(
                  children: [
                    Text(
                      'Requests',
                      style: GoogleFonts.poppins(
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
                          subscriptionRequestCount.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
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
                  RegisteredStudents(),

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
