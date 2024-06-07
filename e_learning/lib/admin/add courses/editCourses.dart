import 'dart:typed_data';
import 'package:e_learning/admin/add%20courses/addCourses.dart';
import 'package:e_learning/services/courseServices.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'dart:convert'; // Import for JSON encoding/decoding
import 'dart:io';
import '../../color.dart';

class EditCourse extends StatefulWidget {
  const EditCourse({
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
  _EditCourseState createState() => _EditCourseState();
}

class _EditCourseState extends State<EditCourse> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _useridController = TextEditingController();
  TextEditingController _aboutCourseController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();

  int? user_id;
  String? _imageUrl;
  Uint8List? _selectedImageBytes;
  List<String> _typeOptions = ['Science', 'Math', 'IT', 'Language', 'Other'];
  String? _selectedType;

  @override
  void initState() {
    super.initState();
    _loadCourseDetails();
  }

  Future<void> _loadCourseDetails() async {
    try {
      final courseDetails =
          await CourseService.instance.fetchCourseById(widget.course_id);

      setState(() {
        _titleController.text = courseDetails['title'] ?? '';
        _descriptionController.text = courseDetails['description'] ?? '';
        _useridController.text = courseDetails['user_id'].toString();
        _categoryController.text = courseDetails['catagory'] ?? '';
        _aboutCourseController.text =
            jsonEncode(courseDetails['what_will'] ?? {});
        _imageUrl = courseDetails['image'] ?? '';
      });
    } catch (e) {
      print('Error loading course details: $e');
    }
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
          setState(() async {
            _selectedImageBytes = await File(file.path!).readAsBytes();
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
      'catagory': _categoryController.text.trim(),
      'image': _selectedImageBytes != null
          ? MultipartFile.fromBytes(_selectedImageBytes!, filename: 'image.jpg')
          : null,
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
                      accessToken: widget.accessToken,
                      refreshToken: widget.refreshToken,
                      username: widget.username,
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
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Form(
              key: _formKey,
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
                        'Edit Course',
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
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
                  Stack(
                    children: [
                      Container(
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
                            : (_imageUrl != null && _imageUrl!.isNotEmpty)
                                ? Image.network(
                                    _imageUrl!,
                                    fit: BoxFit.cover,
                                  )
                                : Icon(
                                    Icons.image,
                                    color: Colors.grey[800],
                                    size: 50,
                                  ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: GestureDetector(
                          onTap: _pickFile,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Title'),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _categoryController,
                    decoration: InputDecoration(labelText: 'Category'),
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
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            FormData formData = _buildFormData();

                            try {
                              final response = await CourseService.instance
                                  .editCourse(formData, widget.course_id);

                              if (response != null &&
                                  response.containsKey('id')) {
                                _showSuccessDialog(response['id']);
                              } else {
                                _showErrorDialog('Course editing failed.');
                              }
                            } catch (e) {
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
      ),
    );
  }
}
