import 'dart:typed_data';

import 'package:e_learning/admin/add%20courses/addCourses.dart';
import 'package:e_learning/services/courseServices.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'dart:io'; 
import '../../color.dart';

class NewCourse extends StatefulWidget {
  const NewCourse({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;

  @override
  _NewCourseState createState() => _NewCourseState();
}

class _NewCourseState extends State<NewCourse> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _useridController = TextEditingController();
  TextEditingController _aboutCourseController = TextEditingController();

 int? user_id;
  File? _selectedImage;
  Uint8List? _selectedImageBytes;
  List<String> _typeOptions = ['Science', 'Math', 'IT', 'Language', 'Other'];
  String? _selectedType;

  @override
  void initState() {
    super.initState();
    _fetchUserId();
  }

  void _fetchUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id = prefs.getInt('user_id');
    });
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'], // Allow only image files
      );

      if (result != null) {
        if (kIsWeb) {
          // For web, get the bytes and create a Uint8List
          Uint8List bytes = await result.files.first.bytes!;
          setState(() {
            _selectedImageBytes = bytes;
          });
        } else {
          // For mobile, get the file directly
          PlatformFile file = result.files.first;
          setState(() {
            _selectedImage = File(file.path!);
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Selected image: ${result.files.first.name}'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        print('No file selected.');
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }



  FormData _buildFormData() {
  return FormData.fromMap({
    'user_id': _useridController.text.trim(),
    'title': _titleController.text.trim(),
    'description': _descriptionController.text.trim(),
    'what_will': _aboutCourseController.text.trim(),
    'category': _selectedType!, 
    'image': _selectedImageBytes != null ? MultipartFile.fromBytes(_selectedImageBytes!, filename: 'image.jpg') : null,
  });
}

  void _showSuccessDialog(int courseId) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('course_id', courseId); 
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Course preview added successfully"),
              SizedBox(height: 10),
              Text("Course ID: $courseId"),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddCourses(
                      accessToken: '',
                      refreshToken: '',
                      username: '',
                    ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Course Preview',
                  style: GoogleFonts.openSans(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  controller: _useridController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'User ID'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'User ID is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: _pickFile,
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _selectedImageBytes != null
                        ? Image.memory(
                            _selectedImageBytes!,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.file_upload,
                            color: Colors.grey[800],
                            size: 50,
                          ),
                  ),
                ),
                // Display the file path
                SizedBox(height: 20),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectedType,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedType = newValue;
                    });
                  },
                  items: _typeOptions.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Category'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Category is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: null,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _aboutCourseController,
                  decoration: InputDecoration(labelText: 'About Course'),
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
                        padding: MaterialStateProperty.all(EdgeInsets.all(15.0),
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
                            final FormData formData = _buildFormData();

                            final response = await CourseService.instance.postCourse(formData, user_id!);

                            if (response.containsKey('course_id') && response['course_id'] != null) {
                              final courseId = int.parse(response['course_id'].toString());
                              _showSuccessDialog(courseId);
                            } else {
                              _showErrorDialog("Course ID not found in the response");
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
      ),
    );
  }
}

