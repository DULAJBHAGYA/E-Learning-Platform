import 'package:e_learning/services/courseServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../color.dart';
import '../../services/adminRequestServices.dart';
import '../admin home/adminDash.dart';

class DeleteRequests extends StatefulWidget {
  const DeleteRequests({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;

  @override
  _DeleteRequestsState createState() => _DeleteRequestsState();
}

class _DeleteRequestsState extends State<DeleteRequests>
    with SingleTickerProviderStateMixin {
  List<dynamic> _deleteRequests = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    fetchDeleteRequests();
  }

  Future<void> fetchDeleteRequests() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final int? user_id = prefs.getInt('user_id');

      if (user_id != null) {
        final delRequestData =
            await AdminRequestsService.instance.fetchAllAdminRequests(user_id);
        setState(() {
          _deleteRequests = delRequestData ?? [];
        });
      } else {
        print('Error: user_id is null');
      }
    } catch (e) {
      print('Error fetching delete requests: $e');
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
            padding: const EdgeInsets.all(10.0),
            child: Icon(Iconsax.arrow_left_2, size: 30, color: black),
          ),
          onPressed: () {
            Navigator.pop(context);
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
                  'Delete Requests',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: _deleteRequests.map((delrequests) {
                    return DeleteRequestCard(
                      course_id: delrequests['course_id'] ?? 0,
                      request_id: delrequests['request_id'] ?? 0,
                      user_name: delrequests['user_name'] ?? '',
                      first_name: delrequests['first_name'] ?? '',
                      last_name: delrequests['last_name'] ?? '',
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

class DeleteRequestCard extends StatefulWidget {
  final int course_id;
  final String user_name;
  final String first_name;
  final String last_name;
  final int request_id;

  const DeleteRequestCard({
    required this.course_id,
    required this.user_name,
    required this.first_name,
    required this.last_name,
    required this.request_id,
    Key? key,
  }) : super(key: key);

  @override
  State<DeleteRequestCard> createState() => _DeleteRequestCardState();
}

class _DeleteRequestCardState extends State<DeleteRequestCard> {
  String? courseTitle;

  @override
  void initState() {
    super.initState();
    fetchCourseDetails();
  }

  Future<void> fetchCourseDetails() async {
    try {
      final details =
          await CourseService.instance.fetchCourseById(widget.course_id);
      setState(() {
        courseTitle = details['title'];
      });
    } catch (e) {
      print('Error fetching course details: $e');
      setState(() {
        courseTitle = 'Unknown Course';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: white,
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (courseTitle != null)
            Text(
              '${widget.user_name} asks to delete $courseTitle?',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w400, color: black),
            )
          else
            CircularProgressIndicator(),
          Row(
            children: [
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Add your accept logic here
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(3),
                  backgroundColor: darkblue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('ACCEPT',
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: white)),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // Add your decline logic here
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(3),
                  backgroundColor: red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('DECLINE',
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
