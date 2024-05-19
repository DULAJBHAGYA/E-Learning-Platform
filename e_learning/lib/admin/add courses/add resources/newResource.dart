import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_learning/services/resourceServices.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'addResources.dart';



class NewResources extends StatefulWidget {
  const NewResources({Key? key}) : super(key: key);

  @override
  _NewResourcesState createState() => _NewResourcesState();
}

class _NewResourcesState extends State<NewResources> {
  FilePickerResult? result;
  TextEditingController materialIdController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  Future<File?> _saveFileLocally(PlatformFile file) async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;
    final String fileName = '${DateTime.now().millisecondsSinceEpoch}_${file.name}';
    final String filePath = '$appDocPath/$fileName';

    return File(filePath).writeAsBytes(file.bytes!);
  }

  void _onSave() async {
  if (result != null && result!.files.isNotEmpty) {
    final materialId = int.parse(materialIdController.text); // Parse materialId to int
    final title = titleController.text;
    final file = result!.files.first;
    final type = typeController.text;

    try {
      final formData = FormData.fromMap({
        'material_id': materialId,
        'title': title,
        'file': MultipartFile.fromBytes(
          file.bytes!,
          filename: file.name,
        ), 
        'type': type,
      });

      final response = await ResourceService.instance.postResource(formData, materialId);
      
      _showSuccessDialog(context);
    } catch (e) {
      _showErrorDialog(context, e.toString());
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Add Resources', ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              TextFormField(
                controller: materialIdController,
                decoration: InputDecoration(labelText: 'Material ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Material ID';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: typeController,
                decoration: InputDecoration(labelText: 'type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20), 
              if (result != null && result!.files.isNotEmpty)
                _fileContainer(result!.files.first),
              SizedBox(height: 20),
              FilePickerDemo(
                onFilePicked: (fileResult) {
                  setState(() {
                    result = fileResult;
                  });
                },
                onSave: _onSave,
                onCancel: () {
                  setState(() {
                    result = null;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fileContainer(PlatformFile file) {
    final String extension = file.extension?.toLowerCase() ?? '';

    if (extension == 'pdf') {
      return FutureBuilder<File?>(
        future: _saveFileLocally(file),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data != null) {
            return FutureBuilder<PDFDocument>(
              future: PDFDocument.fromFile(snapshot.data!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Text('Error loading PDF');
                }
              },
            );
          } else {
            return Text('Error saving PDF');
          }
        },
      );
    } else if (['jpg', 'jpeg', 'png', 'gif', 'heic'].contains(extension)) {
      return Image.memory(
        file.bytes!,
        fit: BoxFit.cover,
      );
    } else if (['mp3', 'mp4'].contains(extension)) {
      // Handle audio and video files
      return Text('Audio/Video file: $extension');
    } else if (['doc', 'docx'].contains(extension)) {
      // Handle document files
      return Text('Document file: $extension');
    } else {
      return Text('Unsupported file type: $extension');
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("Course Material added successfully"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                 Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddResources(username: '', accessToken: '', refreshToken: '', materialId: int.parse(materialIdController.text),),));
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Failed"),
          content: Text("Failed to add course material: $errorMessage"),
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

class PDFDocument {
  static fromFile(File file) {}
}

class FilePickerDemo extends StatelessWidget {
  final Function(FilePickerResult?) onFilePicked;
  final VoidCallback? onSave;
  final VoidCallback? onCancel;

  const FilePickerDemo({
    Key? key,
    required this.onFilePicked,
    this.onSave,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            FilePickerResult? result =
                await FilePicker.platform.pickFiles(allowMultiple: false);
            onFilePicked(result);
          },
          child: const Text("CHOOSE FILE"),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: onSave,
              child: const Text("SAVE"),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: onCancel,
              child: const Text("CANCEL"),
            ),
          ],
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: NewResources(),
  ));
}