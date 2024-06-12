import 'package:e_learning/change%20password/studentChangePassword.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../color.dart';
import '../../edit profile/editProfile.dart';
import '../../login/login.dart';
import '../../services/userServices.dart';
import '../../shared/bottomNavBar.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;

  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  late String first_name = '';
  late String last_name = '';
  late String email = '';
  late String user_name = '';
  late int user_id;
  late String picture = '';

  @override
  void initState() {
    super.initState();
    fetchUserById();
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
          user_name = response['GetUserIDRow']['user_name'];
          email = response['GetUserIDRow']['email'];
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

  Future<void> clearAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('access_token');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                                  'My Profile',
                                  style: GoogleFonts.poppins(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: CircleAvatar(
                                radius: 120,
                                backgroundImage: NetworkImage('$picture'),
                              ),
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('$user_name',
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        color: black,
                                        fontWeight: FontWeight.w600)),
                                SizedBox(width: 20),
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    '$email',
                                    overflow: TextOverflow.clip,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: lightgrey,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$first_name',
                          style: GoogleFonts.poppins(
                            fontSize: 30,
                            color: black,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          '$last_name',
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            color: lightgrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Profile',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: black,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();
                        final user_id = prefs.getInt('user_id');

                        if (user_id != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfile(
                                username: widget.username,
                                accessToken: widget.accessToken,
                                refreshToken: widget.refreshToken,
                                user_id: user_id,
                              ),
                            ),
                          );
                        } else {
                          print('User ID not found in SharedPreferences');
                        }
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: background,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: background2,
                                            shape: BoxShape.circle,
                                          ),
                                          padding: EdgeInsets.all(5),
                                          child: Icon(
                                            Iconsax.user,
                                            color: black,
                                            size: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Manage Profile',
                                      style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: black),
                                    ),
                                    Spacer(),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Align(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(
                                            Iconsax.arrow_right_3,
                                            size: 20,
                                            color: black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Settings',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: black,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: background,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: background2,
                                          shape: BoxShape.circle,
                                        ),
                                        padding: EdgeInsets.all(5),
                                        child: Icon(
                                          Iconsax.notification_status4,
                                          color: black,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Notifications',
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: black),
                                  ),
                                  Spacer(),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Align(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Icon(
                                          Iconsax.arrow_right_3,
                                          size: 20,
                                          color: black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();
                        final user_id = prefs.getInt('user_id');

                        if (user_id != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Studentchangepassword(
                                username: widget.username,
                                accessToken: widget.accessToken,
                                refreshToken: widget.refreshToken,
                                user_id: user_id,
                              ),
                            ),
                          );
                        } else {
                          // Handle the case where user_id is null
                          print('User ID not found in SharedPreferences');
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: background,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: background2,
                                          shape: BoxShape.circle,
                                        ),
                                        padding: EdgeInsets.all(5),
                                        child: Icon(
                                          Iconsax.password_check,
                                          color: black,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Change Password',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: black,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Align(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Icon(
                                          Iconsax.arrow_right_3,
                                          size: 20,
                                          color: black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await clearAccessToken();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: darkblue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, right: 10, left: 10),
                            child: Text(
                              'SIGN OUT',
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
            )),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
