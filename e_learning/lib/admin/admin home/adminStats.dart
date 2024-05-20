import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';
import '../../services/countServices.dart';

class AdminStats extends StatefulWidget {
  const AdminStats({Key? key}) : super(key: key);

  @override
  _AdminStatsState createState() => _AdminStatsState();
}

class _AdminStatsState extends State<AdminStats> {
  int studentCount = 0;

  @override
  void initState() {
    super.initState();
    fetchStudentCount();
  }

  Future<void> fetchStudentCount() async {
  try {
    final response = await CountService.instance.getStudentCount();
    
    if (response != null) {
      if (response.containsKey('student_count')) {
        final studentCountValue = response['student_count'];
        
        if (studentCountValue is int) {
          setState(() {
            studentCount = studentCountValue;
          });
        } else {
          throw Exception('Student count is not an integer');
        }
      } else {
        throw Exception('Response does not contain student count');
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
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
              height: 150,
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: darkblue,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Display the student count dynamically
                    Text(
                      studentCount.toString(),
                      style: GoogleFonts.openSans(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: white,
                      ),
                    ),
                    Text(
                      'Registered Students',
                      style: GoogleFonts.openSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: white),
                    ),
                  ],
                ),
              )),
          SizedBox(width: 5),
          Container(
              height: 150,
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: darkblue,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Stack(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '17',
                            style: GoogleFonts.openSans(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                                color: white),
                          ),
                          Text(
                            'Courses',
                            style: GoogleFonts.openSans(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: white),
                          ),
                        ],
                      ),
                    ])
                  ],
                ),
              )),
        ]),
        SizedBox(
          height: 10,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
              height: 150,
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: darkblue,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '176',
                      style: GoogleFonts.openSans(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: white),
                    ),
                    Text(
                      'Enrolled Students',
                      style: GoogleFonts.openSans(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: white),
                    ),
                  ],
                ),
              )),
          SizedBox(width: 5),
          Container(
              height: 150,
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: darkblue,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '7',
                      style: GoogleFonts.openSans(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: white),
                    ),
                    Text(
                      'Admins',
                      style: GoogleFonts.openSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: white),
                    ),
                  ],
                ),
              )),
        ])
      ]),
    );
  }
}
