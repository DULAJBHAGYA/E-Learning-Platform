import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../color.dart';
import '../profile/stdProfile.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
            child: Icon(Icons.arrow_back, size: 20, color: black),
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
          'About',
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
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Logo
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/logos/logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // App Name and Version
              Center(
                child: Text(
                  'EduApp E-Learning Platform',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: black,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Version 1.0.0',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: lightgrey,
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Description
              Text(
                'About Our Platform',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: black,
                ),
              ),
              Text(
                'Our E-Learning Platform is designed to provide students with a comprehensive and engaging learning experience. We offer a wide range of courses taught by expert instructors to help you achieve your educational goals.',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: lightgrey,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 10),
              // Features
              Text(
                'Key Features',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: black,
                ),
              ),
              _buildFeatureItem('Access to 100+ courses across various subjects'),
              _buildFeatureItem('Learn at your own pace with 24/7 access'),
              _buildFeatureItem('Interactive video lessons and quizzes'),
              _buildFeatureItem('Download content for offline learning'),
              _buildFeatureItem('Track your progress with detailed analytics'),
              _buildFeatureItem('Connect with instructors and fellow students'),
              SizedBox(height: 10),
              // Contact Info
              Text(
                'Contact Us',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: black,
                ),
              ),
              _buildContactItem(Iconsax.sms, 'support@elearningplatform.com'),
              _buildContactItem(Iconsax.call, '+94 76 123 4567'),
              _buildContactItem(Iconsax.location, '123 Education Street, Kandy'),
              SizedBox(height: 30),
              // Copyright
              Center(
                child: Text(
                  '© 2025 EduApp E-Learning Platform. All rights reserved.',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: lightgrey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Iconsax.tick_circle,
            color: darkblue,
            size: 16,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              feature,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: lightgrey,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(
            icon,
            color: darkblue,
            size: 16,
          ),
          SizedBox(width: 10),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: lightgrey,
            ),
          ),
        ],
      ),
    );
  }
}