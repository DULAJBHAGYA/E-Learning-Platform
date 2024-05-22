import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';
import '../../shared/bottomNavBar.dart';

class StudentProfile extends StatelessWidget {
  const StudentProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            child: Column(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'MyProfile',
                        style: GoogleFonts.poppins(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: black),
                      ),
                      Spacer(),
                      Icon(
                        EneftyIcons.login_outline,
                        size: 40,
                        color: black,
                        weight: 5,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage('/images/user.png'),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: lightgrey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(children: [
                          Text(
                            'Dulaj',
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: black),
                          ),
                          Spacer(),
                          Icon(
                            EneftyIcons.edit_outline,
                            size: 20,
                            color: black,
                            weight: 5,
                          ),
                        ])
                      ],
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: lightgrey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(children: [
                          Text(
                            'Upananda',
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: black),
                          ),
                          Spacer(),
                          Icon(
                            EneftyIcons.edit_outline,
                            size: 20,
                            color: black,
                            weight: 5,
                          ),
                        ])
                      ],
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: lightgrey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(children: [
                          Text(
                            'dbhagya',
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: black),
                          ),
                          Spacer(),
                          Icon(
                            EneftyIcons.edit_outline,
                            size: 20,
                            color: black,
                            weight: 5,
                          ),
                        ])
                      ],
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: lightgrey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(children: [
                          Text(
                            'dulajupananda@gmail.com',
                            style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: black),
                          ),
                          Spacer(),
                          Icon(
                            EneftyIcons.edit_outline,
                            size: 20,
                            color: black,
                            weight: 5,
                          ),
                        ])
                      ],
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: lightgrey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(children: [
                          Text(
                            'Change Password',
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: black),
                          ),
                          Spacer(),
                          Icon(
                            EneftyIcons.arrow_right_3_outline,
                            size: 20,
                            color: black,
                            weight: 5,
                          ),
                        ])
                      ],
                    ),
                  ))
            ]),
          )),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
