import 'package:e_learning/admin/add%20courses/addCourses.dart';
import 'package:e_learning/admin/requests/requests.dart';
import 'package:e_learning/color.dart';
import 'package:e_learning/login/login.dart';
import 'package:e_learning/services/userServices.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

import '../../services/countServices.dart';
import '../add new admin/admins.dart';
import '../admin courses/adminCourses.dart';
import '../admin profile/adminProfile.dart';
import '../admin students/adminStudents.dart';
import '../delete requests/deleteRequests.dart';
import '../enrollments/enrolments.dart';
import '../submissions/submissions.dart';
import 'adminDashCourses.dart';
import 'adminDashStudents.dart';
import 'adminInfo.dart';
import 'adminStats.dart';
import 'navDrawer.dart';

class AdminDash extends StatefulWidget {
  const AdminDash({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;

  @override
  _AdminDashState createState() => _AdminDashState();
}

class _AdminDashState extends State<AdminDash> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late String first_name = '';
  late String last_name = '';
  late String picture = '';
  int deleteRequestCount = 0;

  @override
  void initState() {
    super.initState();
    fetchUserById();
    fetchDeleteRequestCount();
  }

  Future<void> fetchDeleteRequestCount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');

      if (userId != null) {
        final response =
            await CountService.instance.getDeleteRequestByUserId(userId);

        if (response != null) {
          if (response is int) {
            setState(() {
              deleteRequestCount = response;
            });
          } else {
            throw Exception('Course count is not an integer');
          }
        } else {
          throw Exception('Response is null');
        }
      } else {
        throw Exception('User ID is null');
      }
    } catch (e) {
      print('Error fetching ongoing course count: $e');
    }
  }

  Future<void> fetchUserById() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final user_id = prefs.getInt('user_id');
      final accessToken = prefs.getString('access_token');

      if (user_id != null && accessToken != null) {
        final response =
            await UserService.instance.fetchUsersById(user_id, accessToken);

        setState(() {
          first_name = response['GetUserIDRow']['first_name'];
          last_name = response['GetUserIDRow']['last_name'];
          picture = response['GetUserIDRow']['picture'];
        });

        print('Fetched User: $first_name $last_name');
      } else {
        print('User ID or Access Token not found in SharedPreferences');
      }
    } catch (e) {
      print('Error fetching user info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: background,
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        leading: IconButton(
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Icon(Iconsax.menu_1, size: 20, color: black),
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Requests(
                              username: '',
                              accessToken: '',
                              refreshToken: '',
                            )));
              },
              child: SizedBox(
                width: 40,
                height: 40,
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Iconsax.notification,
                        size: 20,
                        color: black,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: darkblue,
                          shape: BoxShape.circle,
                        ),
                        constraints: BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Center(
                          child: Text(
                            deleteRequestCount.toString(), // This will show the notification count
                            style: GoogleFonts.poppins(
                              color: white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            children: [
              AdminInfo(
                first_name: first_name,
                last_name: last_name,
                picture: picture,
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      AdminStats(),
                      SizedBox(
                        height: 20,
                      ),
                      AdminDashStudents(
                          username: '', refreshToken: '', accessToken: ''),
                      SizedBox(
                        height: 20,
                      ),
                      AdminDashCourses(
                          username: '', refreshToken: '', accessToken: ''),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
