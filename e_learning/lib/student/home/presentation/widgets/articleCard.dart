import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../color.dart';

class ArticleCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final String category;
  final int timeInMinutes;

  const ArticleCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.category,
    required this.timeInMinutes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 300,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Article image with padding and dark blue background
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              child: Container(
                height: 200,
                width: double.infinity,
                color: darkblue, // Set background to dark blue
                child: Image.asset(
                  imagePath,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: darkblue, // Also set error background to dark blue
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.white, // Change icon color to white for better visibility
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          // Article content
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Iconsax.document, size: 12, color: grey,),
                        SizedBox(width: 5),
                        Text(
                          category,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: grey,
                          )
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Iconsax.clock,
                          size: 12,
                          color: grey,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '$timeInMinutes min',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: grey,
                          )
                        )
                      ]

                    )
                  ]
                )
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}