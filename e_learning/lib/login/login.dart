import 'package:e_learning/student/home/stdHome.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../color.dart';
import '../register/register.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Align(
                alignment: Alignment.centerLeft, // Align text to the left
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Let\'s Sign you in',
                      style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Welcome back,',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: grey),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'You\'ve been missed!',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email Address',
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: black),
                  ),
                  Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: lightgrey,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'someone@example.com',
                          hintStyle: GoogleFonts.poppins(color: lightgrey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Password',
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: black),
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: lightgrey,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'please enter your password',
                          hintStyle: GoogleFonts.poppins(color: lightgrey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 17,
                        height: 17,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3), // Adjust the border radius as needed
                          color: darkblue, // Set the color to match your background color
                        ),
                        child: Theme(
                          data: ThemeData(
                            unselectedWidgetColor: darkblue, // Set the color for the border and checkmark
                          ),
                          child: Checkbox(
                            value: true, 
                            onChanged: (value) {
                              // Handle onChanged event here
                            },
                            activeColor: Colors.transparent, // Make the checkmark transparent
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Keep me signed in',
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: grey),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20,),

                  SizedBox(
                    width: MediaQuery.of(context).size.width, // Example width
                    height: 50, // Example height
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentHome()));
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(20)),
                        backgroundColor: MaterialStateProperty.all(darkblue),
                        foregroundColor: MaterialStateProperty.all(darkblue),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ), 
                      child: Text(
                        'Sign in',
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),

                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: lightgrey,
                          height: 36, // Adjust the height of the divider
                          thickness: 1, // Adjust the thickness of the divider
                          endIndent: 10, // Adjust the space between the text and the divider
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'or sign in with',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: lightgrey,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: lightgrey,
                          height: 36, // Adjust the height of the divider
                          thickness: 1, // Adjust the thickness of the divider
                          indent: 10, // Adjust the space between the text and the divider
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20,),

                  SizedBox(
                    width: MediaQuery.of(context).size.width, // Example width
                    height: 50, // Example height
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(20)),
                        backgroundColor: MaterialStateProperty.all(lightgrey),
                        foregroundColor: MaterialStateProperty.all(lightgrey),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ), 
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('/images/google.png',
                            width: 25,
                            height: 25,
                          ),
                          const SizedBox(width: 10,),
                          Text(
                            'Continue with Google',
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: grey),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 80,),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  RegisterScreen()));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Create an account',
                            style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: darkblue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
