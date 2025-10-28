import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:e_learning/admin/add%20courses/add%20materials/addMaterial.dart';
import 'package:e_learning/services/materialServices.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Import for JSON encoding/decoding
import 'dart:io';
import '../../../color.dart';

class EditMaterial extends StatefulWidget {
  const EditMaterial({
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
  _EditMaterialState createState() => _EditMaterialState();
}

class _EditMaterialState extends State<EditMaterial> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _ordernumberController = TextEditingController();
  TextEditingController _courseidController = TextEditingController();
  TextEditingController _resourceController = TextEditingController();

  String? _fileName;
  Uint8List? _selectedImageBytes;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _courseidController.text = widget.course_id.toString();
    _fetchMaterialData();
  }

  Future<void> _fetchMaterialData() async {
    try {
      final materialData = await MaterialService.instance
          .fetchMaterialByCourseIdnMaterialId(
              widget.course_id, widget.material_id);

      if (materialData != null) {
        setState(() {
          _titleController.text = materialData['title'];
          _ordernumberController.text = materialData['order_number'].toString();
          _resourceController.text = jsonEncode(materialData['resource'] ?? {});

          // Extract file name from material_file URL
          final materialFileUrl = materialData['material_file'];
          if (materialFileUrl != null) {
            _fileName = materialFileUrl.split('/').last;
          }

          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching material data: $e');
      setState(() {
        _isLoading = false;
      });
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
          Uint8List bytes = await result.files.first.bytes!;
          setState(() {
            _selectedImageBytes = bytes;
            _fileName = result.files.first.name;
          });
        } else {
          PlatformFile file = result.files.first;
          setState(() async {
            _selectedImageBytes = await File(file.path!).readAsBytes();
            _fileName = file.name;
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
      'course_id': _courseidController.text.trim(),
      'title': _titleController.text.trim(),
      'order_number': _ordernumberController.text.trim(),
      'resource': _resourceController.text.trim(),
      'material': _selectedImageBytes != null
          ? MultipartFile.fromBytes(_selectedImageBytes!, filename: 'image.jpg')
          : null,
      'material_file': _selectedImageBytes == null ? _fileName : null,
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
              Text("Course material updated successfully"),
              SizedBox(height: 10),
              Text("Material ID: $material_id"),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddMaterial(
                              username: widget.username,
                              accessToken: widget.accessToken,
                              refreshToken: widget.refreshToken,
                              course_id: widget.course_id,
                              title: '',
                            )));
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
          content: Text("Course material updating failed: $errorMessage"),
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
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
                                  'assets/logos/logo.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Edit Material',
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
                                : _fileName != null
                                    ? Center(
                                        child: Text(
                                          _fileName!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
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
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(darkblue),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.all(10.0)),
                            ),
                            child: Text('CANCEL',
                                style: GoogleFonts.poppins(
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                          ),
                          SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                FormData formData = _buildFormData();

                                try {
                                  final response = await MaterialService
                                      .instance
                                      .editMaterial(
                                    formData,
                                    widget.material_id,
                                  );

                                  if (response != null &&
                                      response['status'] == 'success') {
                                    _showSuccessDialog(widget.material_id);
                                  } else {
                                    _showErrorDialog(
                                        'Material editing failed.');
                                  }
                                } catch (e) {
                                  _showErrorDialog(e.toString());
                                }
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(darkblue),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.all(10.0)),
                            ),
                            child: Text(
                              'SAVE',
                              style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
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
