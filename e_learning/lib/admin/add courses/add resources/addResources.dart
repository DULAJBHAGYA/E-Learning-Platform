import 'package:e_learning/admin/add%20courses/addCourses.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../color.dart';
import '../../../services/resourceServices.dart';
import 'newResource.dart';

class AddResources extends StatefulWidget {
  const AddResources({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
    required this.materialId, // Receive materialId
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;
  final int materialId; // Declare materialId variable

  @override
  _AddResourcesState createState() => _AddResourcesState();
}

class _AddResourcesState extends State<AddResources> {
  List<dynamic> _resources = [];
  late int materialId; // Define materialId variable

  @override
void initState() {
  super.initState();
  fetchResourceById(widget.materialId);
}


Future<void> _fetchMaterialId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  materialId = prefs.getInt('material_id') ?? 0;
  print('Material ID: $materialId');
  fetchResourceById(materialId); 
}


  Future<void> fetchResourceById(int materialId) async {
    try {
      final resourcesData =
          await ResourceService.instance.getResourceById(materialId);
      setState(() {
        _resources = resourcesData ?? [];
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
              MaterialPageRoute(builder: (context) => AddCourses(username: '', accessToken: '', refreshToken: '',)),
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
                          MaterialPageRoute(builder: (context) => NewResources()),
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
                        children: _resources.map((resource) {
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddResources(accessToken: '', refreshToken: '', username: '', materialId: int .parse(resourceId.toString()),),                                
                      ),
                    );
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