import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:e_learning/services/requestServices.dart';
import 'package:e_learning/services/userServices.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../color.dart';
import '../../login/login.dart';
import '../../services/profilePictureServices.dart';
import '../profile/stdProfile.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
    required this.user_id,
    this.first_name,
    this.last_name,
    this.email,
    this.user_name,
    this.picture,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;
  final int user_id;
  final String? first_name;
  final String? last_name;
  final String? email;
  final String? user_name;
  final String? picture;

  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late int user_id;
  late String first_name = '';
  late String last_name = '';
  late String email = '';
  late String user_name = '';
  late String picture = '';

  Uint8List? _selectedImageBytes;
  File? _selectedImage;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    user_id = widget.user_id;
    
    // Use passed data if available, otherwise fetch from API
    if (widget.first_name != null && 
        widget.last_name != null && 
        widget.email != null && 
        widget.user_name != null && 
        widget.picture != null) {
      setState(() {
        first_name = widget.first_name!;
        last_name = widget.last_name!;
        email = widget.email!;
        user_name = widget.user_name!;
        picture = widget.picture!;

        firstNameController.text = first_name;
        lastNameController.text = last_name;
        userNameController.text = user_name;
        emailController.text = email;
      });
    } else {
      fetchUserById();
    }
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
      );

      if (result != null) {
        if (kIsWeb) {
          Uint8List bytes = await result.files.first.bytes!;
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

  FormData _buildFormData() {
    return FormData.fromMap({
      'user_id': widget.user_id,
      'image': _selectedImageBytes != null
          ? MultipartFile.fromBytes(_selectedImageBytes!, filename: 'image.jpg')
          : null,
    });
  }

  Future<void> _handleProfilePictureAction(String action) async {
    switch (action) {
      case 'upload':
        await _pickFile();
        await ProfilePicService.instance.postProfilePicture(_buildFormData());
        break;
      case 'update':
        await _pickFile();
        await ProfilePicService.instance.updateProfilePicture(_buildFormData());
        break;
      case 'delete':
        await ProfilePicService.instance.deleteProfilePicture(widget.user_id);
        break;
    }
  }

  String? _validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your first name';
    }
    return null;
  }

  String? _validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your last name';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    } else if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username';
    }
    return null;
  }

  Future<void> fetchUserById() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final user_id = prefs.getInt('user_id');
      final accessToken = prefs.getString('access_token');

      if (user_id != null && accessToken != null) {
        final response =
            await UserService.instance.fetchUsersById(user_id, accessToken);

        setState(() {
          first_name = response['GetUserIDRow']['first_name'];
          last_name = response['GetUserIDRow']['last_name'];
          user_name = response['GetUserIDRow']['user_name'];
          email = response['GetUserIDRow']['email'];
          picture = response['GetUserIDRow']['picture'];

          firstNameController.text = first_name;
          lastNameController.text = last_name;
          userNameController.text = user_name;
          emailController.text = email;
        });
      } else {
        print('User ID or Access Token not found in SharedPreferences');
      }
    } catch (e) {
      print('Error fetching user info: $e');
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await UserService.instance.updateUser(
          user_id: widget.user_id,
          first_name: firstNameController.text,
          last_name: lastNameController.text,
          user_name: userNameController.text,
          email: emailController.text,
        );

        if (response != null && response['statusCode'] == 200) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Update Successful'),
                content: Text('Your profile has been updated successfully.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Update Failed'),
                content: Text(
                  'An error occurred during profile update. Please try again later.',
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Update Failed'),
              content: Text(
                'An error occurred during profile update. Please try again later.',
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        print('Update failed: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background, // Set the background color
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        leading: IconButton(
          icon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Iconsax.arrow_left_2, size: 20, color: black),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StudentProfile(
                          username: widget.username,
                          accessToken: widget.accessToken,
                          refreshToken: widget.refreshToken,
                        )));
          },
        ),
        title: Text(
          'Edit Profile',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: black,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            Container(
                                child: Column(children: [
                              Center(
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: darkblue,
                                          width: 3,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0), // Space between border and image
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundImage: picture.startsWith('http') 
                                            ? NetworkImage(picture) as ImageProvider
                                            : AssetImage(picture),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          showMenu(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            color: white,
                                            context: context,
                                            position: RelativeRect.fromLTRB(
                                                100, 100, 0, 0),
                                            items: [
                                              PopupMenuItem(
                                                value: 'upload',
                                                child: Text('Upload picture',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: black)),
                                              ),
                                              PopupMenuItem(
                                                value: 'update',
                                                child: Text('Update picture',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: black)),
                                              ),
                                              PopupMenuItem(
                                                value: 'delete',
                                                child: Text('Delete picture',
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: black)),
                                              ),
                                            ],
                                          ).then((value) {
                                            if (value != null) {
                                              _handleProfilePictureAction(
                                                  value);
                                            }
                                          });
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: darkblue,
                                          radius: 18,
                                          child: Icon(
                                            Iconsax.camera,
                                            color: white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ])),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                ),
                                TextFormField(
                                  controller: firstNameController,
                                  validator: _validateFirstName,
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: lightgrey),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: darkblue),
                                    ),
                                    prefixIcon: ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                        lightgrey,
                                        BlendMode.srcIn,
                                      ),
                                      child: Icon(Iconsax.user ,size: 16,),
                                    ),
                                    iconColor: lightgrey,
                                    labelText: 'First Name',
                                    labelStyle: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: lightgrey,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: lastNameController,
                                  validator: _validateLastName,
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: lightgrey),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: darkblue),
                                    ),
                                    prefixIcon: ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                        lightgrey,
                                        BlendMode.srcIn,
                                      ),
                                      child: Icon(Iconsax.user, size: 16,),
                                    ),
                                    iconColor: lightgrey,
                                    labelText: 'Last Name',
                                    labelStyle: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: lightgrey,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: userNameController,
                                  validator: _validateUserName,
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: lightgrey),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: darkblue),
                                    ),
                                    prefixIcon: ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                        lightgrey,
                                        BlendMode.srcIn,
                                      ),
                                      child: Icon(Iconsax.direct_right, size: 16,),
                                    ),
                                    iconColor: lightgrey,
                                    labelText: 'User Name',
                                    labelStyle: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: lightgrey,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: emailController,
                                  validator: _validateEmail,
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: lightgrey),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width:  1, color: darkblue),
                                    ),
                                    prefixIcon: ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                        lightgrey,
                                        BlendMode.srcIn,
                                      ),
                                      child: Icon(Iconsax.sms, size: 16,),
                                    ),
                                    labelText: 'Email',
                                    labelStyle: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: lightgrey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    // Navigate back to profile screen
                                    Navigator.pop(context);
                                  },
                                  style: ButtonStyle(
                                    side: MaterialStateProperty.all<BorderSide>(
                                      BorderSide(
                                        width: 1.0,
                                        color: lightgrey,
                                      ),
                                    ),
                                    padding: MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    ),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all<Color>(
                                        Colors.transparent),
                                  ),
                                  child: Text(
                                    'Cancel',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: lightgrey,
                                    ),
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _submitForm();
                                    }
                                  },
                                  style: ButtonStyle(
                                    side: MaterialStateProperty.all<BorderSide>(
                                      BorderSide(
                                        width: 1.0,
                                        color: darkblue,
                                      ),
                                    ),
                                    padding: MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    ),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all<Color>(
                                        darkblue),
                                  ),
                                  child: Text(
                                    'Save',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ]),
              )
            ],
          ),
        ),
      )),
    );
  }
}
