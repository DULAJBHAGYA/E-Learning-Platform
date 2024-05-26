import 'package:e_learning/admin/add%20courses/add%20materials/addMaterial.dart';
import 'package:e_learning/admin/add%20courses/addCourses.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../color.dart';
import '../../../services/assignmentServices.dart';
import '../../../shared/searchBar.dart';
import '../add materials/newMaterial.dart';
import 'newAssignment.dart';

class AddAssignment extends StatefulWidget {
  const AddAssignment({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
    required this.material_id,
    required this.course_id, // Receive materialId
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;
  final int material_id;
  final int course_id; // Declare materialId variable

  @override
  _AddAssignmentState createState() => _AddAssignmentState();
}

class _AddAssignmentState extends State<AddAssignment> {
  List<dynamic> _assignments = [];
  late int assignment_id; // Define materialId variable

  @override
  void initState() {
    super.initState();
    fetchResourceById(widget.material_id);
  }

  Future<void> _fetchMaterialId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    assignment_id = prefs.getInt('material_id') ?? 0;
    print('Material ID: $assignment_id');
    fetchResourceById(assignment_id);
  }

  Future<void> fetchResourceById(int material_id) async {
    try {
      final assignmentsData =
          await AssignmentService.instance.getResourceById(material_id);
      setState(() {
        _assignments = assignmentsData ?? [];
      });
    } catch (e) {
      print('Error fetching assignments: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        leading: IconButton(
          icon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Iconsax.arrow_left_2, size: 30, color: black),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddCourses(
                          username: '',
                          accessToken: '',
                          refreshToken: '',
                        )));
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
                  'Materials',
                  style: GoogleFonts.poppins(
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
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Newmaterial(
                      course_id: widget.course_id,
                      username: widget.username,
                      accessToken: widget.accessToken,
                      refreshToken: widget.refreshToken,
                    ),
                  ),
                );
              },
              child: Row(
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
                      'ADD NEW MATERIAL',
                      style: GoogleFonts.openSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: _assignments.map((addedassignment) {
                    return AdminAddedMaterialViewCard(
                      course_id: addedassignment['course_id'] ?? 0,
                      material_id: addedassignment['material_id'] ?? 0,
                      order_number: addedassignment['order_number'] ?? 0,
                      material_file: addedassignment['material_file'] ?? '',
                      title: addedassignment['title'] ?? '',
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

class AdminAddedMaterialViewCard extends StatelessWidget {
  final int course_id;
  final int material_id;
  final String material_file;
  final String title;
  final int order_number;

  const AdminAddedMaterialViewCard({
    required this.course_id,
    required this.order_number,
    required this.material_id,
    required this.material_file,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      height: 100,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$material_id) $title',
                  overflow: TextOverflow.clip,
                  style: GoogleFonts.openSans(
                      fontSize: 15, fontWeight: FontWeight.bold, color: black),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddAssignment(
                          course_id: course_id,
                          material_id: material_id,
                          username: '',
                          accessToken: '',
                          refreshToken: '',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: science,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'Add Assignment',
                      style: GoogleFonts.openSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
