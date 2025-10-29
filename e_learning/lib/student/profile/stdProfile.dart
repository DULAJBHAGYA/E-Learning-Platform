import 'package:e_learning/change%20password/studentChangePassword.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
// import 'package:shared_preferences/shared_preferences.dart'; // Comment out real service

import '../../color.dart';
import '../../login/login.dart';
// import '../../services/userServices.dart'; // Comment out real service
import '../../shared/bottomNavBar.dart';
import '../edit_profile/editProfile.dart'; // Updated import path
import '../FAQs/faqs.dart'; // Import FAQs screen
import '../About/about.dart'; // Import About screen

class StudentProfile extends StatefulWidget {
  const StudentProfile({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;

  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  // Mock user data
  String first_name = 'John';
  String last_name = 'Doe';
  String email = 'johndoe@icoud.com';
  String user_name = 'johndoe';
  int user_id = 12345;
  String picture = 'assets/images/dulaj.jpg';
  
  // Dark mode toggle state
  bool isDarkMode = false;
  
  // Tapped item state
  String tappedItem = '';

  @override
  void initState() {
    super.initState();
    // Use mock data instead of fetching from API
    // fetchUserById();
  }

  // Comment out the real fetch function
  /*
  Future<void> fetchUserById() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final user_id = prefs.getInt('user_id');
      final accessToken = prefs.getString('access_token');

      if (user_id != null && accessToken != null) {
        final response =
            await UserService.instance.fetchUsersById(user_id, accessToken);

        setState(() {
          first_name = response['GetUserIDRow']['first_name'];
          last_name = response['GetUserIDRow']['last_name'];
          user_name = response['GetUserIDRow']['user_name'];
          email = response['GetUserIDRow']['email'];
          picture = response['GetUserIDRow']['picture'];
        });

        print('Fetched User: $first_name $last_name');
      } else {
        print('User ID or Access Token not found in SharedPreferences');
      }
    } catch (e) {
      print('Error fetching user info: $e');
    }
  }
  */

  Future<void> clearAccessToken() async {
    // Comment out real implementation
    // final prefs = await SharedPreferences.getInstance();
    // prefs.remove('access_token');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    // Centered user info section without edit icon
                    Center(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 80,
                            height: 80,
                            child: CircleAvatar(
                              radius: 120,
                              backgroundImage: AssetImage(picture),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '$first_name $last_name',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              color: black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            email,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              color: grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Profile section
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Profile',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          color: black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTapDown: (_) {
                        setState(() {
                          tappedItem = 'manage_profile';
                        });
                      },
                      onTapUp: (_) {
                        setState(() {
                          tappedItem = '';
                        });
                      },
                      onTapCancel: () {
                        setState(() {
                          tappedItem = '';
                        });
                      },
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfile(
                              username: widget.username,
                              accessToken: widget.accessToken,
                              refreshToken: widget.refreshToken,
                              user_id: user_id,
                              first_name: first_name,
                              last_name: last_name,
                              email: email,
                              user_name: user_name,
                              picture: picture,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: tappedItem == 'manage_profile' ? blue : background,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: darkblue,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Iconsax.user,
                                  color: black,
                                  size: 12,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Manage Profile',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: black,
                                ),
                              ),
                              Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(
                                    Iconsax.arrow_right_3,
                                    size: 12,
                                    color: black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Preferences section
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Prefferences',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          color: black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Dark Mode Toggle
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: background,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: darkblue,
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Iconsax.moon, // Moon icon for dark mode
                                color: black,
                                size: 12,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Dark Mode',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: black,
                              ),
                            ),
                            Spacer(),
                            // Toggle switch for dark mode
                            Switch(
                              value: isDarkMode,
                              onChanged: (value) {
                                setState(() {
                                  isDarkMode = value;
                                });
                              },
                              activeColor: darkblue,
                              inactiveThumbColor: Colors.grey,
                              inactiveTrackColor: Colors.grey.withOpacity(0.3),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTapDown: (_) {
                        setState(() {
                          tappedItem = 'notifications';
                        });
                      },
                      onTapUp: (_) {
                        setState(() {
                          tappedItem = '';
                        });
                      },
                      onTapCancel: () {
                        setState(() {
                          tappedItem = '';
                        });
                      },
                      onTap: () {
                        // Navigate to notifications page
                        // You'll need to implement this navigation based on your app structure
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: tappedItem == 'notifications' ? blue : background,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: darkblue,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Iconsax.notification,
                                  color: black,
                                  size: 12,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Notifications',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: black,
                                ),
                              ),
                              Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(
                                    Iconsax.arrow_right_3,
                                    size: 12,
                                    color: black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // FAQ Section
                    GestureDetector(
                      onTapDown: (_) {
                        setState(() {
                          tappedItem = 'faqs';
                        });
                      },
                      onTapUp: (_) {
                        setState(() {
                          tappedItem = '';
                        });
                      },
                      onTapCancel: () {
                        setState(() {
                          tappedItem = '';
                        });
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FAQsScreen(
                              username: widget.username,
                              accessToken: widget.accessToken,
                              refreshToken: widget.refreshToken,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: tappedItem == 'faqs' ? blue : background,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: darkblue,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Iconsax.message_question, // FAQ icon
                                  color: black,
                                  size: 12,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'FAQs',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: black,
                                ),
                              ),
                              Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(
                                    Iconsax.arrow_right_3,
                                    size: 12,
                                    color: black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // About Section
                    GestureDetector(
                      onTapDown: (_) {
                        setState(() {
                          tappedItem = 'about';
                        });
                      },
                      onTapUp: (_) {
                        setState(() {
                          tappedItem = '';
                        });
                      },
                      onTapCancel: () {
                        setState(() {
                          tappedItem = '';
                        });
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AboutScreen(
                              username: widget.username,
                              accessToken: widget.accessToken,
                              refreshToken: widget.refreshToken,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: tappedItem == 'about' ? blue : background,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: darkblue,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Iconsax.info_circle, // About icon
                                  color: black,
                                  size: 12,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'About',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: black,
                                ),
                              ),
                              Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(
                                    Iconsax.arrow_right_3,
                                    size: 12,
                                    color: black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Security and Privacy section
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Security and Privacy',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          color: black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTapDown: (_) {
                        setState(() {
                          tappedItem = 'change_password';
                        });
                      },
                      onTapUp: (_) {
                        setState(() {
                          tappedItem = '';
                        });
                      },
                      onTapCancel: () {
                        setState(() {
                          tappedItem = '';
                        });
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Studentchangepassword(
                              username: widget.username,
                              accessToken: widget.accessToken,
                              refreshToken: widget.refreshToken,
                              user_id: user_id,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: tappedItem == 'change_password' ? blue : background,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: darkblue,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Iconsax.security_safe,
                                  color: black,
                                  size: 12,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Change Password',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: black,
                                ),
                              ),
                              Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(
                                    Iconsax.arrow_right_3,
                                    size: 12,
                                    color: black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTapDown: (_) {
                        setState(() {
                          tappedItem = 'security';
                        });
                      },
                      onTapUp: (_) {
                        setState(() {
                          tappedItem = '';
                        });
                      },
                      onTapCancel: () {
                        setState(() {
                          tappedItem = '';
                        });
                      },
                      onTap: () {
                        // Handle security tap
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: tappedItem == 'security' ? blue : background,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: darkblue,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Iconsax.lock,
                                  color: black,
                                  size: 12,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Security',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: black,
                                ),
                              ),
                              Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(
                                    Iconsax.arrow_right_3,
                                    size: 12,
                                    color: black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTapDown: (_) {
                        setState(() {
                          tappedItem = 'terms';
                        });
                      },
                      onTapUp: (_) {
                        setState(() {
                          tappedItem = '';
                        });
                      },
                      onTapCancel: () {
                        setState(() {
                          tappedItem = '';
                        });
                      },
                      onTap: () {
                        // Handle terms & conditions tap
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: tappedItem == 'terms' ? blue : background,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: darkblue,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Iconsax.document_normal,
                                  color: black,
                                  size: 12,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Terms & Conditions',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: black,
                                ),
                              ),
                              Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(
                                    Iconsax.arrow_right_3,
                                    size: 12,
                                    color: black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTapDown: (_) {
                        setState(() {
                          tappedItem = 'help';
                        });
                      },
                      onTapUp: (_) {
                        setState(() {
                          tappedItem = '';
                        });
                      },
                      onTapCancel: () {
                        setState(() {
                          tappedItem = '';
                        });
                      },
                      onTap: () {
                        // Handle help and support tap
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: tappedItem == 'help' ? blue : background,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: darkblue,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Iconsax.headphone,
                                  color: black,
                                  size: 12,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Help and Support',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: black,
                                ),
                              ),
                              Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(
                                    Iconsax.arrow_right_3,
                                    size: 12,
                                    color: black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Horizontal line divider
                    Divider(
                      color: lightgrey.withOpacity(0.5),
                      thickness: 1,
                      height: 30,
                    ),
                    // Sign Out
                    GestureDetector(
                      onTapDown: (_) {
                        setState(() {
                          tappedItem = 'sign_out';
                        });
                      },
                      onTapUp: (_) {
                        setState(() {
                          tappedItem = '';
                        });
                      },
                      onTapCancel: () {
                        setState(() {
                          tappedItem = '';
                        });
                      },
                      onTap: () async {
                        await clearAccessToken();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: tappedItem == 'sign_out' ? background2 : background,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Iconsax.logout,
                                  color: black,
                                  size: 12,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Sign Out',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: black,
                                ),
                              ),
                              
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Delete Account
                    GestureDetector(
                      onTapDown: (_) {
                        setState(() {
                          tappedItem = 'delete_account';
                        });
                      },
                      onTapUp: (_) {
                        setState(() {
                          tappedItem = '';
                        });
                      },
                      onTapCancel: () {
                        setState(() {
                          tappedItem = '';
                        });
                      },
                      onTap: () {
                        // Handle delete account tap
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: tappedItem == 'delete_account' ? background2 : background,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Iconsax.trash,
                                  color: red,
                                  size: 12,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Delete Account',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: red,
                                ),
                              ),
                             
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 80), // Add spacing for bottom nav bar
                  ],
                ),
              ),
            ),
            // Bottom Navigation Bar
            Positioned(
              bottom: 10,
              left: MediaQuery.of(context).size.width * 0.04,
              right: MediaQuery.of(context).size.width * 0.04,
              child: BottomNavBar(),
            ),
          ],
        ),
      ),
    );
  }
}