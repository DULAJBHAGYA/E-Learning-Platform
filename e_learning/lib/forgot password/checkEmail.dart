import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import '../color.dart';
import '../login/login.dart';
import '../services/emailServices.dart';
import 'resetPassword.dart';

class CheckEmail extends StatefulWidget {
  const CheckEmail({Key? key}) : super(key: key);

  @override
  _CheckEmailState createState() => _CheckEmailState();
}

String? _validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an email';
  } else if (!value.contains('@')) {
    return 'Please enter a valid email';
  }
  return null;
}

class _CheckEmailState extends State<CheckEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  // Function to handle sending the email verification request
  void _sendEmailVerification() async {
    if (_formKey.currentState!.validate()) {
      String email = emailController.text;
      try {
        Map<String, dynamic> response =
            await EmailService.instance.checkEmail(email);
        // Handle the response here, for example:
        // if (response['success']) {
        //   // Email exists, handle accordingly
        // } else {
        //   // Email does not exist, handle accordingly
        // }
      } catch (e) {
        // Handle any errors or exceptions
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left_2, color: black), // Changed the icon
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Forgot Password', // Corrected typo in "PassWord"
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: black,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Enter the email address associated with your account',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: black,
                          ),
                        ),
                        SizedBox(height: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(padding: EdgeInsets.all(10)),
                            Container(
                              child: TextFormField(
                                controller: emailController,
                                validator: _validateEmail,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 2, color: lightgrey),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  prefixIcon: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                      lightgrey,
                                      BlendMode.srcIn,
                                    ),
                                    child: Icon(
                                        Iconsax.message), // Changed the icon
                                  ),
                                  labelText: 'Email',
                                  labelStyle: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: lightgrey,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            OutlinedButton(
                              onPressed: () async {
                                await _sendEmailVerification; // Call the function here
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ResetPassword(email: emailController.text,),
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                elevation:
                                    MaterialStateProperty.all<double>(100.0),
                                side: MaterialStateProperty.all<BorderSide>(
                                  BorderSide(
                                    width: 0.0,
                                    color: darkblue,
                                  ),
                                ),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(25.0),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(darkblue),
                              ),
                              child: Text(
                                'SEND',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
