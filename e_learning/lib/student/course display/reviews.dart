import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../color.dart';

class Reviews extends StatelessWidget {
  const Reviews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample reviews data - in a real app this would come from an API
    final List<Map<String, dynamic>> reviews = [
      {
        'name': 'Alex Johnson',
        'rating': 5,
        'date': '2023-10-15',
        'comment': 'This course was incredibly helpful! I learned so much and the instructor explained everything clearly.',
        'avatar': 'assets/images/dulaj.jpg',
      },
      {
        'name': 'Sarah Williams',
        'rating': 4,
        'date': '2023-09-22',
        'comment': 'Great content and well-structured. The practical examples were particularly useful.',
        'avatar': 'assets/images/flutter.png',
      },
      {
        'name': 'Michael Chen',
        'rating': 5,
        'date': '2023-08-30',
        'comment': 'Excellent course! The instructor\'s teaching style makes complex topics easy to understand.',
        'avatar': 'assets/images/ai1.jpg',
      },
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overall rating summary
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: background2,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '4.8',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: black,
                        ),
                      ),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < 4 ? Iconsax.star1 : Iconsax.star5,
                            color: index < 4 ? Colors.amber : Colors.grey,
                            size: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Course Rating',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: grey,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '1223',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: black,
                        ),
                      ),
                      Text(
                        'Reviews',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Individual reviews
            Text(
              'All Reviews',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: black,
              ),
            ),
            SizedBox(height: 10),
            Column(
              children: reviews.map((review) {
                return Container(
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: background2,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Reviewer info
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(review['avatar']),
                            backgroundColor: background,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  review['name'],
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: black,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Row(
                                  children: [
                                    ...List.generate(
                                      5,
                                      (index) => Icon(
                                        index < review['rating']
                                            ? Iconsax.star1
                                            : Iconsax.star5,
                                        color: index < review['rating']
                                            ? Colors.amber
                                            : Colors.grey,
                                        size: 14,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      review['date'],
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // Review comment
                      Text(
                        review['comment'],
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: grey,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}