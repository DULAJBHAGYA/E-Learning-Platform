import 'package:e_learning/admin/add%20courses/add%20materials/addMaterial.dart';
import 'package:e_learning/admin/add%20courses/addCourses.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../color.dart';
import '../../../services/assignmentServices.dart';
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
      appBar: AppBar(
        backgroundColor: blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddMaterial(username: '', accessToken: '', refreshToken: '', course_id: widget.course_id)),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    height: 60.0,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: background,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: grey),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search in here',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NewAssignment(
                            username: widget.username,
                            accessToken: widget.accessToken,
                            refreshToken: widget.refreshToken,
                            material_id: widget.material_id,
                            course_id: widget.course_id,
                          )),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(blue),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.all(15.0),
                        ),
                      ),
                      child: Text(
                        'ADD NEW ASSIGNMENT',
                        style: GoogleFonts.openSans(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: _assignments.map((resource) {
                          return MaterialsDisplayCard(
                            resourceId: resource['resource_id'],
                            title: resource['title'],
                            type: resource['type'],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MaterialsDisplayCard extends StatelessWidget {
  final int resourceId;
  final String title;
  final String type;

  const MaterialsDisplayCard({
    required this.resourceId,
    required this.title,
    required this.type,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: grey,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  resourceId.toString(),
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.blue,
                  ),
                ),
              ),
              title: Text(
                title,
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$type',
                    style: GoogleFonts.openSans(fontSize: 15),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text('ADD ASSIGNMENT', style: GoogleFonts.openSans(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
                SizedBox(width: 5),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: red,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text('DELETE RESOURCE', style: GoogleFonts.openSans(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
                SizedBox(width: 5),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Iconsax.edit, color: blue),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}