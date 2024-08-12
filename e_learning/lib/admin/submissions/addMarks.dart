import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../color.dart';
import '../admin home/adminDash.dart';
import 'submissions.dart';

class AddMarks extends StatefulWidget {
  const AddMarks({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
    required this.grade,
    required this.resource,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;
  final int grade;
  final String resource;

  @override
  _AddMarksState createState() => _AddMarksState();
}

void _launchFileViewer(String filePath) {
  launch(filePath);
}

class _AddMarksState extends State<AddMarks> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        drawer: NavDrawer(),
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
                  builder: (context) => Submissions(
                    username: '',
                    accessToken: '',
                    refreshToken: '',
                  ),
                ),
              );
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                              'Add Marks',
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
                Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: white, borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () =>
                                      _launchFileViewer(widget.resource),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: darkblue,
                                        border: Border.all(
                                            color: darkblue, width: 2)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'View Submission'.toUpperCase(),
                                        style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]),
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: white, borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Submit Marks',
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: black),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 2, color: lightgrey),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  prefixIcon: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                      lightgrey, // Change the color here
                                      BlendMode.srcIn,
                                    ),
                                    child: Icon(Iconsax.direct_send),
                                  ),
                                  iconColor: lightgrey,
                                  labelText: 'Insert marks here',
                                  labelStyle: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: lightgrey,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: darkblue,
                                      border: Border.all(
                                          color: darkblue, width: 2)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Submit'.toUpperCase(),
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: white),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]),
                    )),
              ])),
        ));
  }
}
