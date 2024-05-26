import 'package:e_learning/admin/admin%20profile/adminProfile.dart';
import 'package:e_learning/services/passwordService.dart';
import 'package:e_learning/student/profile/stdProfile.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../color.dart';
import '../../login/login.dart';
import '../../services/userServices.dart';
import '../../shared/bottomNavBar.dart';

class Studentchangepassword extends StatefulWidget {
  const Studentchangepassword(
      {Key? key,
      required this.username,
      required this.accessToken,
      required this.refreshToken,
      required this.user_id})
      : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;
  final int user_id;

  @override
  _StudentchangepasswordState createState() => _StudentchangepasswordState();
}

class _StudentchangepasswordState extends State<Studentchangepassword> {
  late String email = '';
  late String hashed_password = '';

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    } else if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await Passwordservice.instance.editPassword(
          user_id: widget.user_id,
          email: emailController.text,
          hashed_password: passwordController.text,
        );

        if (response != null && response['statusCode'] == 200) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Password Change Successful'),
                content: Text('You have successfully changed your password.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentProfile(
                                  username: '',
                                  accessToken: '',
                                  refreshToken: '',
                                )),
                      );
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          // Handle other response status codes, if needed
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Password Change Unsuccessful'),
                content: Text('An error occurred. Please try again later.'),
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
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Password Change Failed'),
              content: Text(
                'An error occurred during password change. Please try again later.',
              ),
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
        print('Password change failed: $e');
      }
    }
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AdminProfile(
                          username: '',
                          accessToken: '',
                          refreshToken: '',
                        )));
          },
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                            'Change Password',
                            style: GoogleFonts.poppins(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    validator: _validateEmail,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: lightgrey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      prefixIcon: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          lightgrey,
                          BlendMode.srcIn,
                        ),
                        child: Icon(Iconsax.sms),
                      ),
                      labelText: 'Email',
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: lightgrey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    validator: _validatePassword,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: lightgrey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      prefixIcon: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          lightgrey,
                          BlendMode.srcIn,
                        ),
                        child: Icon(Iconsax.password_check),
                      ),
                      labelText: 'Password',
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: lightgrey,
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            lightgrey,
                            BlendMode.srcIn,
                          ),
                          child: Icon(_obscurePassword
                              ? Iconsax.eye_slash
                              : Iconsax.eye),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    validator: _validateConfirmPassword,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: lightgrey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      prefixIcon: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          lightgrey,
                          BlendMode.srcIn,
                        ),
                        child: Icon(Iconsax.password_check),
                      ),
                      labelText: 'Confirm Password',
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: lightgrey,
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            lightgrey,
                            BlendMode.srcIn,
                          ),
                          child: Icon(_obscureConfirmPassword
                              ? Iconsax.eye_slash
                              : Iconsax.eye),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: OutlinedButton(
                      onPressed: _submitForm,
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(100.0),
                        side: MaterialStateProperty.all<BorderSide>(
                          BorderSide(
                            width: 0.0,
                            color: darkblue,
                          ),
                        ),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(25.0),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(darkblue),
                      ),
                      child: Text(
                        'CHANGE PASSWORD',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ]),
          )),
    );
  }
}
