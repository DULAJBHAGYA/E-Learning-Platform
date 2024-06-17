import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import '../../color.dart';
import '../../services/assignmentServices.dart';
import '../../services/submissionServices.dart';

class SubmitAssignment extends StatefulWidget {
  const SubmitAssignment({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
    required this.course_id,
    required this.assignment_id,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;
  final int course_id;
  final int assignment_id;

  @override
  _SubmitAssignmentState createState() => _SubmitAssignmentState();
}

class _SubmitAssignmentState extends State<SubmitAssignment> {
  final _formKey = GlobalKey<FormState>();
  late String title = '';
  late String assignment_file = '';
  late String due_date = '';
  late String resource = '';
  late int submission_id = 0;
  late int grade = 0;

  File? _selectedFile;
  Uint8List? _selectedFileBytes;
  String? _selectedFileName;

  @override
  void initState() {
    super.initState();
    fetchAssignmentDetails();
    fetchSubmissionDetails();
  }

  Future<void> fetchAssignmentDetails() async {
    try {
      if (widget.course_id != null && widget.assignment_id != null) {
        final response =
            await AssignmentService.instance.fetchAssignmentDetails(
          widget.course_id,
          widget.assignment_id,
        );

        setState(() {
          title = response['title'];
          assignment_file = response['assignment_file'];
          due_date = response['due_date'];
        });
      } else {
        print('Access Token not found in SharedPreferences');
      }
    } catch (e) {
      print('Error fetching assignment info: $e');
    }
  }

  Future<void> fetchSubmissionDetails() async {
    try {
      if (widget.course_id != null && widget.assignment_id != null) {
        final response =
            await SubmissionService.instance.fetchSubmissionDetails(
          widget.course_id,
          widget.assignment_id,
        );

        setState(() {
          submission_id = response['submission_id'];
          resource = response['resource'];
          grade = response['grade'];
        });
      } else {
        print('Access Token not found in SharedPreferences');
      }
    } catch (e) {
      print('Error fetching assignment info: $e');
    }
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
      );

      if (result != null) {
        if (kIsWeb) {
          Uint8List bytes = result.files.first.bytes!;
          setState(() {
            _selectedFileBytes = bytes;
            _selectedFileName = result.files.first.name;
          });
        } else {
          PlatformFile file = result.files.first;
          setState(() {
            _selectedFile = File(file.path!);
            _selectedFileName = file.name;
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Selected file: ${result.files.first.name}'),
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
    if (_selectedFileBytes != null) {
      return FormData.fromMap({
        'file': MultipartFile.fromBytes(
          _selectedFileBytes!,
          filename: _selectedFileName,
        ),
      });
    } else if (_selectedFile != null) {
      return FormData.fromMap({
        'file': MultipartFile.fromFileSync(
          _selectedFile!.path,
          filename: _selectedFileName,
        ),
      });
    } else {
      return FormData();
    }
  }

  Future<void> _submitAssignment() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? user_id = prefs.getInt('user_id');

      if (user_id == null) {
        throw Exception('User ID not found');
      }

      FormData file = _buildFormData();

      final response = await SubmissionService.instance.postSubmission(
        file,
        widget.assignment_id,
        user_id,
      );

      _showSuccessDialog(widget.course_id);
    } catch (e) {
      print('Error submitting assignment: $e');
      _showErrorDialog(e.toString());
    }
  }

  Future<void> _editSubmission() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? user_id = prefs.getInt('user_id');

      if (user_id == null) {
        throw Exception('User ID not found');
      }

      FormData file = _buildFormData();

      final response = await SubmissionService.instance.editSubmission(
        file,
        user_id,
        widget.assignment_id,
      );

      _showSuccessDialog(widget.course_id);
    } catch (e) {
      print('Error editing submission: $e');
      _showErrorDialog(e.toString());
    }
  }

  Future<void> _deleteSubmission() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? user_id = prefs.getInt('user_id');

      if (user_id == null) {
        throw Exception('User ID not found');
      }

      await SubmissionService.instance.deleteSubmission(
        user_id,
        widget.assignment_id,
      );

      setState(() {
        _selectedFile = null;
        _selectedFileBytes = null;
        _selectedFileName = null;
      });

      _showSuccessDialog(widget.course_id, isDelete: true);
    } catch (e) {
      print('Error deleting submission: $e');
      _showErrorDialog(e.toString());
    }
  }

  void _showSuccessDialog(int courseId, {bool isDelete = false}) {
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
              Text(isDelete
                  ? "Assignment deleted successfully"
                  : "Assignment submitted successfully"),
              SizedBox(height: 10),
              Text("Course ID: $courseId"),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
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
          content: Text("Assignment submission failed: $errorMessage"),
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

  void _launchFileViewer(String filePath) {
    launch(filePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        leading: IconButton(
          icon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Iconsax.arrow_left_2, size: 30, color: black),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
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
                'Submit Assignment',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: black,
                ),
              ),
            ]),
            SizedBox(height: 20),
            Text(
              '$title',
              style: GoogleFonts.poppins(
                color: black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => _launchFileViewer(assignment_file),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: darkblue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'VIEW ASSIGNMENT',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Due Date: $due_date',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Upload Answers',
                  style: GoogleFonts.poppins(
                    color: black,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Spacer(),
                PopupMenuButton<String>(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: white,
                  icon: Icon(Icons.more_horiz, color: black, size: 20),
                  onSelected: (value) {
                    if (value == 'Edit Submission') {
                      _pickFile();
                    } else if (value == 'Delete Submission') {
                      _deleteSubmission();
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return {'Edit Submission', 'Delete Submission'}
                        .map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice,
                            style: GoogleFonts.poppins(
                                color: black,
                                fontSize: 15,
                                fontWeight: FontWeight.w400)),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: _pickFile,
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _selectedFileBytes != null || _selectedFile != null
                    ? Center(
                        child: Text(
                          _selectedFileName ?? 'File selected',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: black),
                        ),
                      )
                    : Icon(
                        Icons.file_upload,
                        color: lightgrey,
                        size: 50,
                      ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _selectedFileBytes != null || _selectedFile != null
                      ? _submitAssignment
                      : _editSubmission,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(darkblue),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.all(10.0),
                    ),
                  ),
                  child: Text(
                    'SUBMIT',
                    style: GoogleFonts.poppins(
                      color: white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: white, width: 2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'Marks',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: lightgrey,
                      ),
                    ),
                    SizedBox(width: 40),
                    Text(
                      '$grade'.toString(),
                      style: GoogleFonts.openSans(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
