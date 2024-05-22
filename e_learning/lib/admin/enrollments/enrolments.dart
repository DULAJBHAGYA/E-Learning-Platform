import 'package:e_learning/services/courseServices.dart';
import 'package:e_learning/shared/searchBar.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';

import '../../color.dart';
import '../../services/enrollServices.dart';
import '../admin home/adminDash.dart';

class Enrollments extends StatefulWidget {
  const Enrollments({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;

  @override
  _EnrollmentsState createState() => _EnrollmentsState();
}

class _EnrollmentsState extends State<Enrollments>
    with SingleTickerProviderStateMixin {
  List<dynamic> _enrollments = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    fetchEnrollments();
  }

  Future<void> fetchEnrollments() async {
    try {
      final enrollData = await EnrollService.instance.fetchAllEnrollments();
      setState(() {
        _enrollments = enrollData ?? [];
      });
    } catch (e) {
      print('Error fetching courses: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the key to the Scaffold
      backgroundColor: background,
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        leading: IconButton(
          icon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(UniconsLine.bars, size: 30, color: black),
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
                Text(
                  'Enrollments',
                  style: GoogleFonts.nunito(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            CustomSearchBar(),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: _enrollments.map((enrollment) {
                    return EnrollmentCard(
                      course_id: enrollment['course_id'] ?? 0,
                      user_id: enrollment['user_id'] ?? 0,
                      title: enrollment['title'] ?? '',
                      first_name: enrollment['first_name'] ?? '',
                      last_name: enrollment['last_name'] ?? '',
                      image: enrollment['image'] ?? '',
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EnrollmentCard extends StatelessWidget {
  final int course_id;
  final String title;
  final String first_name;
  final String last_name;
  final String image;
  final int user_id;

  const EnrollmentCard({
    required this.course_id,
    required this.image,
    required this.title,
    required this.first_name,
    required this.last_name,
    required this.user_id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: white,
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Image
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(image),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  first_name + ' ' + last_name,
                  style: GoogleFonts.nunito(
                      fontSize: 18, fontWeight: FontWeight.bold, color: black),
                ),
                SizedBox(height: 10),
                Text(
                  title,
                  style: GoogleFonts.nunito(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: black),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(5),
                        backgroundColor: white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: darkblue, width: 2)),
                      ),
                      child: Text('Accept',
                          style: GoogleFonts.nunito(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: darkblue)),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(5),
                        backgroundColor: white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: red, width: 2)),
                      ),
                      child: Text('Decline',
                          style: GoogleFonts.nunito(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: red)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
