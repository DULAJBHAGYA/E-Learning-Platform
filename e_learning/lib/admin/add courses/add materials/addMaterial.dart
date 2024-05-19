import 'package:e_learning/admin/add%20courses/addCourses.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../color.dart';
import '../../../services/materialServices.dart';
import '../add resources/addResources.dart';
import 'newMaterial.dart';


class AddMaterial extends StatefulWidget {
  const AddMaterial({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
    required this.courseId,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;
  final int courseId; 

  @override
  _AddMaterialState createState() => _AddMaterialState();
}

class _AddMaterialState extends State<AddMaterial> {
  List<dynamic> _materials = [];

  @override
  void initState() {
    super.initState();
    fetchMaterialById(widget.courseId); 
  }

  Future<void> fetchMaterialById(int courseId) async { 
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final materialsData = await MaterialService.instance.getMaterialById(courseId);
      setState(() {
        _materials = materialsData ?? [];
      });
    } catch (e) {
      print('Error fetching materials: $e');
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
                          MaterialPageRoute(builder: (context) => AddCourses(username: '',accessToken: '',refreshToken: '',)),
                        );
      },
    )
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
                          MaterialPageRoute(builder: (context) => NewMaterial(username: '',accessToken: '',refreshToken: '',)),
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
                        'ADD NEW MATERIAL',
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
      children: _materials.map((material) {
        return MaterialsDisplayCard(
          materialId: material['material_id'],
          title: material['title'],
          description: material['description'],
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
  final int materialId;
  final String title;
  final String description;

  const MaterialsDisplayCard({
    required this.materialId,
    required this.title,
    required this.description,
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
                  materialId.toString(),
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
                    '$description',
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddResources(
          username: '', 
          accessToken: '', 
          refreshToken: '', 
          materialId: materialId, 
        ),
      ),
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
    'ADD NEW RESOURCE',
    style: GoogleFonts.openSans(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: white,
    ),
  ),
),

                SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                     
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: red,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text('DELETE MATERIAL', style: GoogleFonts.openSans(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}