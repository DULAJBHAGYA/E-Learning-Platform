import 'package:e_learning/admin/add%20courses/add%20materials/newMaterial.dart';
import 'package:e_learning/admin/add%20courses/addCourses.dart';
import 'package:e_learning/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../services/materialServices.dart';
import '../add resources/addAssignment.dart';
import 'editMaterials.dart';

class AddMaterial extends StatefulWidget {
  const AddMaterial({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
    required this.course_id,
    required this.title,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;
  final int course_id;
  final String title;

  @override
  _AddmaterialState createState() => _AddmaterialState();
}

class _AddmaterialState extends State<AddMaterial> {
  List<dynamic> _addedmaterials = [];

  @override
  void initState() {
    super.initState();
    getMaterialByCourseId();
  }

  Future<void> getMaterialByCourseId() async {
    try {
      final addedMaterialData = await MaterialService.instance
          .getMaterialByCourseId(widget.course_id);
      setState(() {
        _addedmaterials = addedMaterialData ?? [];
      });
    } catch (e) {
      print('Error fetching courses: $e');
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
            Text(
              widget.title.toUpperCase(),
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold, color: black),
            ),
            SizedBox(height: 10),
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
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
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
                  children: _addedmaterials.map((addedmaterial) {
                    return AdminAddedMaterialViewCard(
                      course_id: addedmaterial['course_id'] ?? 0,
                      material_id: addedmaterial['material_id'] ?? 0,
                      order_number: addedmaterial['order_number'] ?? 0,
                      material_file: addedmaterial['material_file'] ?? '',
                      title: addedmaterial['title'] ?? '',
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

class AdminAddedMaterialViewCard extends StatefulWidget {
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
  State<AdminAddedMaterialViewCard> createState() =>
      _AdminAddedMaterialViewCardState();
}

void _launchFileViewer(String filePath) {
  launch(filePath);
}

class _AdminAddedMaterialViewCardState
    extends State<AdminAddedMaterialViewCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: white,
      ),
      child: GestureDetector(
        onTap: () => _launchFileViewer(widget.material_file),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${widget.title}',
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: black,
                            ),
                          ),
                        ),
                        PopupMenuButton<String>(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: white,
                          icon: Icon(Icons.more_vert),
                          onSelected: (value) async {
                            switch (value) {
                              case 'Edit Material':
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditMaterial(
                                            course_id: widget.course_id,
                                            material_id: widget.material_id,
                                            username: '',
                                            accessToken: '',
                                            refreshToken: '')));
                                break;
                              case 'Delete Material':
                                bool confirmed = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Confirm Deletion',
                                        style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            color: black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      content: Text(
                                        'Are you sure you want to delete this material?',
                                        style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            color: black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: Text(
                                            'No',
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                color: black,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: Text(
                                            'Yes',
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                color: black,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                if (confirmed) {
                                  try {
                                    await MaterialService.instance
                                        .deleteMaterial(widget.course_id,
                                            widget.material_id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                        'Material deleted successfully',
                                        style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            color: white,
                                            fontWeight: FontWeight.w400),
                                      )),
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                        'Failed to delete material: $e',
                                        style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            color: black,
                                            fontWeight: FontWeight.w400),
                                      )),
                                    );
                                  }
                                }
                                break;
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return {'Edit Material', 'Delete Material'}
                                .map((String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Text(
                                  choice,
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: black),
                                ),
                              );
                            }).toList();
                          },
                        ),
                      ],
                    ),
                    Spacer(),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddAssignment(
                              username: '',
                              accessToken: '',
                              refreshToken: '',
                              material_id: widget.material_id,
                              course_id: widget.course_id,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: darkblue,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                'Add Assignments'.toUpperCase(),
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
