import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../color.dart';
import '../../services/submissionServices.dart';
import '../admin home/adminDash.dart';
import 'addMarks.dart';

class Submissions extends StatefulWidget {
  const Submissions({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;

  @override
  _SubmissionsState createState() => _SubmissionsState();
}

class _SubmissionsState extends State<Submissions>
    with SingleTickerProviderStateMixin {
  List<dynamic> _submissions = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getSubmissionsByAdminId();
  }

  Future<void> getSubmissionsByAdminId() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final int? userId = prefs.getInt('user_id');

      if (userId != null) {
        final submissionData =
            await SubmissionService.instance.getSubmissionsByAdminId(userId);
        setState(() {
          _submissions = submissionData ?? [];
        });
      } else {
        print('Error: User ID is null');
      }
    } catch (e) {
      print('Error fetching submissions: $e');
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
                  'Submissions',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: _submissions.map((submission) {
                    return AdminSubmissionView(
                      submission_id: submission['submission_id'] ?? {},
                      assignment_id: submission['assignment_id'] ?? 0,
                      grade: submission['grade'] ?? 0,
                      resource: submission['resource'] ?? '',
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

class AdminSubmissionView extends StatelessWidget {
  final int submission_id;
  final int assignment_id;
  final int grade;
  final String resource;

  const AdminSubmissionView({
    required this.submission_id,
    required this.assignment_id,
    required this.grade,
    required this.resource,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddMarks(
                    username: '',
                    accessToken: '',
                    refreshToken: '',
                    grade: grade,
                    resource: resource,)));
      },
      child: Container(
        margin: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Submission ID : $submission_id',
                  style: GoogleFonts.poppins(
                      color: black, fontSize: 15, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text('Course Name',
                  style: GoogleFonts.poppins(
                      color: black, fontSize: 15, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text('Assignment ID : $assignment_id',
                  style: GoogleFonts.poppins(
                      color: black, fontSize: 15, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
