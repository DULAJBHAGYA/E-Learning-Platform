import 'dart:convert';
import 'dart:typed_data';
import 'package:e_learning/admin/add%20courses/addCourses.dart';
import 'package:e_learning/services/courseServices.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
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
  TextEditingController _aboutCourseLearnController1 = TextEditingController();
  TextEditingController _aboutCourseLearnController2 = TextEditingController();
  TextEditingController _aboutCourseLearnController3 = TextEditingController();
  TextEditingController _aboutCourseSkillController1 = TextEditingController();
  TextEditingController _aboutCourseSkillController2 = TextEditingController();
  TextEditingController _aboutCourseSkillController3 = TextEditingController();
  TextEditingController _aboutCourseWhoController1 = TextEditingController();
  TextEditingController _aboutCourseWhoController2 = TextEditingController();
  TextEditingController _aboutCourseWhoController3 = TextEditingController();
  TextEditingController _categoryController = TextEditingController();

  int? user_id;
  File? _selectedImage;
  Uint8List? _selectedImageBytes;

  void _fetchUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id = prefs.getInt('user_id');
      _useridController.text = user_id?.toString() ?? '';
    });
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
      );

      if (result != null) {
        if (kIsWeb) {
          Uint8List bytes = result.files.first.bytes!;
          setState(() {
            _selectedImageBytes = bytes;
          });
        } else {
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

  @override
  void initState() {
    super.initState();
    _fetchUserId();
  }

  FormData _buildFormData() {
    Map<String, dynamic> what_will = {
      "what_will_you_learn": {
        "subject1": _aboutCourseLearnController1.text.trim(),
        "subject2": _aboutCourseLearnController2.text.trim(),
        "subject3": _aboutCourseLearnController3.text.trim(),
      },
      "what_skil_you_gain": {
        "skil1": _aboutCourseSkillController1.text.trim(),
        "skil2": _aboutCourseSkillController2.text.trim(),
        "skil3": _aboutCourseSkillController3.text.trim(),
      },
      "who_should_learn": {
        "person1": _aboutCourseWhoController1.text.trim(),
        "person2": _aboutCourseWhoController2.text.trim(),
        "person3": _aboutCourseWhoController3.text.trim(),
      }
    };

    String what_will_json = jsonEncode(what_will);

    return FormData.fromMap({
      'user_id': _useridController.text.trim(),
      'title': _titleController.text.trim(),
      'description': _descriptionController.text.trim(),
      'catagory': _categoryController.text.trim(),
      'image': _selectedImageBytes != null
          ? MultipartFile.fromBytes(_selectedImageBytes!, filename: 'image.jpg')
          : null,
      'what_will': what_will_json,
    });
  }

  Future<void> _saveCategoryAndCourse() async {
    try {
      final FormData formData = _buildFormData();

      final response =
          await CourseService.instance.postCourse(formData, user_id!);

      if (response != null &&
          response.containsKey('course_id') &&
          response['course_id'] != null) {
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

  void _showSuccessDialog(int courseId) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('course_id', courseId);
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Success",
            style: GoogleFonts.poppins(
                fontSize: 15, color: black, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Course preview added successfully",
                style: GoogleFonts.poppins(
                    fontSize: 15, color: black, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 10),
              Text(
                "Course ID: $courseId",
                style: GoogleFonts.poppins(
                    fontSize: 15, color: black, fontWeight: FontWeight.w400),
              ),
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
              child: Text(
                'OK',
                style: GoogleFonts.poppins(
                    fontSize: 15, color: black, fontWeight: FontWeight.w400),
              ),
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
          title: Text(
            "Failed",
            style: GoogleFonts.poppins(
                fontSize: 15, color: black, fontWeight: FontWeight.bold),
          ),
          content: Text(
            "Course preview adding failed {$errorMessage}",
            style: GoogleFonts.poppins(
                fontSize: 15, color: black, fontWeight: FontWeight.w400),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: GoogleFonts.poppins(
                    fontSize: 15, color: black, fontWeight: FontWeight.w400),
              ),
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
                        'Add New Course',
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
                    decoration: InputDecoration(
                        labelText: 'User ID',
                        labelStyle: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: black,
                        )),
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
                        color: white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _selectedImageBytes != null
                          ? Image.memory(
                              _selectedImageBytes!,
                              fit: BoxFit.cover,
                            )
                          : Icon(
                              Iconsax.camera,
                              color: lightgrey,
                              size: 50,
                            ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: black,
                        )),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _categoryController,
                    decoration: InputDecoration(
                        labelText: 'Category',
                        labelStyle: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: black,
                        )),
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
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: black,
                      ),
                    ),
                    maxLines: null,
                  ),
                  SizedBox(height: 20),
                  Text('About Course',
                      style: GoogleFonts.poppins(
                          color: black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  SizedBox(height: 20),
                  Text('What will you learn',
                      style: GoogleFonts.poppins(
                          color: black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _aboutCourseLearnController1,
                    decoration: InputDecoration(
                      labelText: 'What will you learn 1',
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: black,
                      ),
                    ),
                    maxLines: null,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _aboutCourseLearnController2,
                    decoration: InputDecoration(
                      labelText: 'What will you learn 2',
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: black,
                      ),
                    ),
                    maxLines: null,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _aboutCourseLearnController3,
                    decoration: InputDecoration(
                      labelText: 'What will you learn 3',
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: black,
                      ),
                    ),
                    maxLines: null,
                  ),
                  SizedBox(height: 20),
                  Text('Skills Gained',
                      style: GoogleFonts.poppins(
                          color: black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _aboutCourseSkillController1,
                    decoration: InputDecoration(
                      labelText: 'Skills Gained 1',
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: black,
                      ),
                    ),
                    maxLines: null,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _aboutCourseSkillController2,
                    decoration: InputDecoration(
                      labelText: 'Skills Gained 2',
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: black,
                      ),
                    ),
                    maxLines: null,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _aboutCourseSkillController3,
                    decoration: InputDecoration(
                      labelText: 'Skills Gained 3',
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: black,
                      ),
                    ),
                    maxLines: null,
                  ),
                  SizedBox(height: 20),
                  Text('Who should learn',
                      style: GoogleFonts.poppins(
                          color: black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _aboutCourseWhoController1,
                    decoration: InputDecoration(
                      labelText: 'Who should learn this course 1',
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: black,
                      ),
                    ),
                    maxLines: null,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _aboutCourseWhoController2,
                    decoration: InputDecoration(
                      labelText: 'Who should learn this course 2',
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: black,
                      ),
                    ),
                    maxLines: null,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _aboutCourseWhoController3,
                    decoration: InputDecoration(
                      labelText: 'Who should learn this course 3',
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: black,
                      ),
                    ),
                    maxLines: null,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _saveCategoryAndCourse();
                          }
                        },
                        child: Text(
                          'SAVE',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: darkblue,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'CANCEL',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: darkblue,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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
