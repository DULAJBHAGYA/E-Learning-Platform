import 'package:e_learning/admin/add%20courses/add%20materials/addMaterial.dart';
import 'package:e_learning/admin/add%20courses/add%20materials/newMaterial.dart';
import 'package:e_learning/admin/add%20courses/add%20resources/newAssignment.dart';
import 'package:e_learning/admin/add%20courses/newCourse.dart';
import 'package:e_learning/color.dart';
import 'package:e_learning/shared/searchBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

import '../../../services/courseServices.dart';
import '../../../services/materialServices.dart';
import '../add resources/addAssignment.dart';

class AddMaterial extends StatefulWidget {
  const AddMaterial({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
    required this.course_id,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;
  final int course_id;

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
      final addedMaterialData =
          await MaterialService.instance.getMaterialByCourseId(widget.course_id);
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
            child: Icon(UniconsLine.arrow_left, size: 30, color: black),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Add Materials',
              style: GoogleFonts.openSans(
                  fontSize: 30, fontWeight: FontWeight.bold, color: black),
            ),
            SizedBox(
              height: 20,
            ),
            CustomSearchBar(),
            SizedBox(
              height: 20,
            ),
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
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: AlwaysScrollableScrollPhysics(),
                child: Row(
                  children: _addedmaterials.map((addedmaterial) {
                    return AdminAddedMaterialViewCard(
                      course_id: addedmaterial['course_id'] ?? 0,
                      material_id: addedmaterial['material_id'] ?? 0,
                      order_number: addedmaterial['order_number'] ?? 0,
                      material_file: addedmaterial['material_file'] ?? '',
                      title: addedmaterial['title'] ?? '',
                    );
                  }).toList(),
                ))
          ]),
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
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: white,
      ),
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(children: [
            //image
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(material_file),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            SizedBox(width: 20),

            
              Column(
                children: [
                  Text(
                     material_id.toString() + ') ' + title,
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
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5),
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
                  ],
                ),
              )
              ],
              ),
            ]
            ),
          
          )
          );
  }
}
