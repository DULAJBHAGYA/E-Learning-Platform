import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../color.dart';
import '../profile/stdProfile.dart';

class FAQsScreen extends StatefulWidget {
  const FAQsScreen({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;

  @override
  _FAQsScreenState createState() => _FAQsScreenState();
}

class _FAQsScreenState extends State<FAQsScreen> {
  // Sample FAQ data
  final List<Map<String, String>> faqs = [
    {
      'question': 'How do I enroll in a course?',
      'answer': 'To enroll in a course, go to the "All Courses" section, browse or search for the course you want, and click the "Enroll" button on the course card.'
    },
    {
      'question': 'How can I access my course materials?',
      'answer': 'Once enrolled in a course, you can access all materials including videos, documents, and assignments through the "My Courses" section.'
    },
    {
      'question': 'How do I submit assignments?',
      'answer': 'Navigate to the specific course in "My Courses", go to the assignments section, and click on the assignment you want to submit. Follow the submission instructions provided.'
    },
    {
      'question': 'How can I track my progress?',
      'answer': 'Your progress is automatically tracked as you complete lessons and assignments. You can view your progress percentage and completed items in each course dashboard.'
    },
    {
      'question': 'What should I do if I forget my password?',
      'answer': 'Click on the "Forgot Password" link on the login screen and follow the instructions to reset your password via email.'
    },
    {
      'question': 'How do I contact support?',
      'answer': 'You can reach our support team through the "Help and Support" section in your profile settings, or by emailing support@elearningplatform.com.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
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
          'FAQs',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: black,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...faqs.map((faq) => _buildFAQItem(faq)).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQItem(Map<String, String> faq) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent, // Remove the default divider
        ),
        child: ExpansionTile(
          tilePadding: EdgeInsets.all(10),
          title: Text(
            faq['question']!,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: black,
            ),
          ),
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: Text(
                faq['answer']!,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  color: grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}