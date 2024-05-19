import 'package:e_learning/services/materialServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../color.dart';
import 'addMaterial.dart';

class NewMaterial extends StatefulWidget {
  const NewMaterial({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;

  @override
  _NewMaterialState createState() => _NewMaterialState();
}

class _NewMaterialState extends State<NewMaterial> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _courseidController = TextEditingController();

  int? course_id;
  

  @override
  void initState() {
    super.initState();
    _fetchUserId(); 
  }

  void _fetchUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      course_id = prefs.getInt('course_id'); 
    });
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Course Material',
                style: GoogleFonts.openSans(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(

                controller: _courseidController,
                keyboardType:
                    TextInputType.number, 
                decoration: InputDecoration(labelText: 'Course ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Course ID is required';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: null, 
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(blue),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.all(15.0),
                      ),
                    ),
                    child: Text(
                      'CANCEL',
                      style: GoogleFonts.openSans(
                        color: white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                                 ElevatedButton(
  onPressed: () async {
    if (_formKey.currentState!.validate()) {
      try {
        final title = _titleController.text.trim();
        final description = _descriptionController.text.trim();
        final courseIDText = _courseidController.text.trim();
        
        if (courseIDText.isNotEmpty) {
          final courseId = int.parse(courseIDText); 
          
          final response = await MaterialService.instance.postMaterial(
            title,
            description,
            courseId, 
          );
          
          _showSuccessDialog(courseId, response['id']);
        } else {
          _showErrorDialog('Course ID is required');
        }
      } catch (e) {
        print('Error: $e');
        _showErrorDialog(e.toString());
      }
    }
  },
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(blue),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
    padding: MaterialStateProperty.all(
      EdgeInsets.all(15.0),
    ),
  ),
  child: Text(
    'SAVE',
    style: GoogleFonts.openSans(
      color: white,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    ),
  ),
),


                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

void _showSuccessDialog(int courseId, dynamic response) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('material_id', response['material_id']); // Assuming 'material_id' is the key in the response
  print('Response: $response');
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Success"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Course Material added successfully"),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AddMaterial(username: '', accessToken: '', refreshToken: '', courseId: int.parse(courseId.toString()),)
                ),
              );
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}



  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Failed"),
          content: Text("Course preview adding failed {$errorMessage}"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}