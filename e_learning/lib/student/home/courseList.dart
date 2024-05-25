import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';

class CourseList extends StatelessWidget {
  const CourseList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        // Wrap with SingleChildScrollView
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    //image
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('/images/python.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    SizedBox(width: 20),

                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'IT',
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: lightgrey),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Python Programming',
                            overflow: TextOverflow.fade,
                            style: GoogleFonts.nunito(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: black),
                          ),
                          SizedBox(height: 5),
                        ]),
                  ]),
                )),
            SizedBox(height: 10),
            Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    //image
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('/images/3dmodeling.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    SizedBox(width: 20),

                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'OTHER',
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: lightgrey),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '3D Modeling',
                            overflow: TextOverflow.fade,
                            style: GoogleFonts.nunito(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: black),
                          ),
                          SizedBox(height: 5),
                        ]),
                  ]),
                )),
            SizedBox(height: 10),
            Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(children: [
                    //image
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('/images/geometry.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    SizedBox(width: 20),

                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'MATH',
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: lightgrey),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Geometry',
                            overflow: TextOverflow.fade,
                            style: GoogleFonts.nunito(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: black),
                          ),
                          SizedBox(height: 5),
                        ]),
                  ]),
                )),
          ],
        ),
      ),
    );
  }
}
