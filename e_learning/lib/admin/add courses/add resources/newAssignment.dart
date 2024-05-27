import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:e_learning/admin/add%20courses/add%20materials/addMaterial.dart';
import 'package:e_learning/services/assignmentServices.dart';
import 'package:e_learning/services/materialServices.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../../../color.dart';
import 'addAssignment.dart';

class NewAssignment extends StatefulWidget {
  const NewAssignment({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
    required this.course_id,
    required this.material_id,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;
  final int course_id;
  final int material_id;

  @override
  _NewAssignmentState createState() => _NewAssignmentState();
}

class _NewAssignmentState extends State<NewAssignment> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _courseidController = TextEditingController();
  TextEditingController _resourceController = TextEditingController();
  TextEditingController _materialidController = TextEditingController();
  TextEditingController _duedateController = TextEditingController();

  Uint8List? _selectedFileBytes;
  String? _fileName;

  @override
  void initState() {
    super.initState();
    _courseidController.text = widget.course_id.toString();
    _materialidController.text = widget.material_id.toString();
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result != null) {
        if (kIsWeb) {
          Uint8List bytes = await result.files.first.bytes!;
          setState(() {
            _selectedFileBytes = bytes;
            _fileName = result.files.first.name;
          });
        } else {
          PlatformFile file = result.files.first;
          setState(() async {
            _selectedFileBytes = await File(file.path!).readAsBytes();
            _fileName = file.name;
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Selected file: $_fileName'),
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
      'course_id': _courseidController.text.trim(),
      'title': _titleController.text.trim(),
      'due_date': _duedateController.text.trim(),
      'material_id': _materialidController.text.trim(),
      'resource': _resourceController.text.trim(),
      'assignment_file': _selectedFileBytes != null
          ? MultipartFile.fromBytes(_selectedFileBytes!, filename: _fileName)
          : null,
    });
  }

  void _showSuccessDialog(int assignment_id) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('assignment_id', assignment_id);
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
              Text("Assignment added successfully"),
              SizedBox(height: 10),
              Text("Assignment ID: $assignment_id"),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddAssignment(
                      username: widget.username,
                      accessToken: widget.accessToken,
                      refreshToken: widget.refreshToken,
                      course_id: widget.course_id,
                      material_id: widget.material_id,
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
          content: Text("Assignment adding failed: $errorMessage"),
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
                      'Add New Material',
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
                  controller: _courseidController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Course ID'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Course ID is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _materialidController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Material ID'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Material ID is required';
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
                    child: _selectedFileBytes != null
                        ? Center(
                            child: Text(
                              'File Selected - $_fileName',
                              style: GoogleFonts.openSans(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : Icon(
                            Icons.file_upload,
                            color: Colors.grey[800],
                            size: 50,
                          ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _duedateController,
                  decoration: InputDecoration(labelText: 'Due Date'),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _resourceController,
                  decoration: InputDecoration(labelText: 'Resources'),
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
                        padding:
                            MaterialStateProperty.all(EdgeInsets.all(15.0)),
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
                            final response = await AssignmentService.instance
                                .postAssignment(formData, widget.course_id,
                                    widget.material_id);

                            if (response.containsKey('assignment_id') &&
                                response['assignment_id'] != null) {
                              final courseId = int.parse(
                                  response['assignment_id'].toString());
                              _showSuccessDialog(courseId);
                            } else {
                              _showErrorDialog(
                                  "Assignment ID not found in the response");
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
                        padding:
                            MaterialStateProperty.all(EdgeInsets.all(15.0)),
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
