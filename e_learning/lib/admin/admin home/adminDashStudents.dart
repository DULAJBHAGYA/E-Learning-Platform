import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';
import '../../services/studentServicecs.dart';
import '../admin students/adminStudents.dart';

class AdminDashStudents extends StatefulWidget {
  const AdminDashStudents({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;

  @override
  _AdminDashStudentsState createState() => _AdminDashStudentsState();
}

class _AdminDashStudentsState extends State<AdminDashStudents> {
  List<dynamic> _students = [];

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    try {
      final studentData = await StudentService.instance.fetchAllStudents();
      setState(() {
        _students = studentData ?? [];
      });
    } catch (e) {
      print('Error fetching students: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Students'.toUpperCase(),
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: black),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminStudents(
                                    username: widget.username,
                                    accessToken: widget.accessToken,
                                    refreshToken: widget.refreshToken,
                                  )));
                    },
                    child: Text(
                      'View all',
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: darkblue),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: _students.take(3).map((student) {
                  return AdminDashStudentsDisplayCard(
                    user_name: student['user_name'] ?? 'N/A',
                    email: student['email'] ?? 'N/A',
                    first_name: student['first_name'] ?? 'N/A',
                    last_name: student['last_name'] ?? 'N/A',
                  );
                }).toList(),
              )
            ],
          ),
        ));
  }
}

class AdminDashStudentsDisplayCard extends StatelessWidget {
  final String email;
  final String first_name;
  final String last_name;
  final String user_name;

  const AdminDashStudentsDisplayCard({
    required this.user_name,
    required this.email,
    required this.first_name,
    required this.last_name,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('/images/user1.jpg'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$first_name $last_name',
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: black),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '$user_name',
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: grey),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '$email',
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
        ));
  }
}
