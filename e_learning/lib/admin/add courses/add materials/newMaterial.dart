import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:e_learning/admin/add%20courses/add%20materials/addMaterial.dart';
import 'package:e_learning/services/materialServices.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../../../color.dart';

class Newmaterial extends StatefulWidget {
  const Newmaterial({
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
  _NewmaterialState createState() => _NewmaterialState();
}

class _NewmaterialState extends State<Newmaterial> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _ordernumberController = TextEditingController();
  TextEditingController _courseidController = TextEditingController();
  TextEditingController _resourceController = TextEditingController();

  Uint8List? _selectedVideoBytes;
  String? _fileName;

  @override
  void initState() {
    super.initState();
    _courseidController.text = widget.course_id.toString(); // Pre-fill course ID
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp4', 'avi', 'mov'], // Allow only video files
      );

      if (result != null) {
        if (kIsWeb) {
          // For web, get the bytes and create a Uint8List
          Uint8List bytes = await result.files.first.bytes!;
          setState(() {
            _selectedVideoBytes = bytes;
            _fileName = result.files.first.name;
          });
        } else {
          // For mobile, get the file directly
          PlatformFile file = result.files.first;
          setState(() async {
            _selectedVideoBytes = await File(file.path!).readAsBytes();
            _fileName = file.name;
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Selected video: $_fileName'),
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
      'order_number': _ordernumberController.text.trim(),
      'resource': _resourceController.text.trim(),
      'material_file': _selectedVideoBytes != null
          ? MultipartFile.fromBytes(_selectedVideoBytes!, filename: _fileName)
          : null,
    });
  }

  void _showSuccessDialog(int material_id) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('material_id', material_id);
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
              Text("Course material added successfully"),
              SizedBox(height: 10),
              Text("Material ID: $material_id"),
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
          content: Text("Course material adding failed: $errorMessage"),
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
                  'Add Course Material',
                  style: GoogleFonts.openSans(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                GestureDetector(
                  onTap: _pickFile,
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _selectedVideoBytes != null
                        ? Center(
                            child: Text(
                              'Video Selected',
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
                  controller: _ordernumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Order Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Order Number is required';
                    }
                    return null;
                  },
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
                        padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
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
                            final response = await MaterialService.instance.postMaterial(formData, widget.course_id);

                            if (response.containsKey('material_id') && response['material_id'] != null) {
                              final courseId = int.parse(response['material_id'].toString());
                              _showSuccessDialog(courseId);
                            } else {
                              _showErrorDialog("Material ID not found in the response");
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
                        padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
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
