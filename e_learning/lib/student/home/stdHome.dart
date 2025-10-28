import 'package:flutter/material.dart';

import '../../color.dart';
import '../../shared/bottomNavBar.dart';
import '../../shared/searchBar.dart';
import 'heroCard.dart';
import 'userInfo.dart';
import 'topArticles.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;

  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    // Handle search functionality
    print('Search query: $query');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 243, 246),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: 20,
              ),
              child: Column(
                children: [
                  //user info
                  UserInfo(),
                  SizedBox(height: 20),
                  //search bar
                  CustomSearchBar(controller: _searchController, onChanged: _onSearchChanged),
                  SizedBox(height: 20),
                  // Hero Card
                  HeroCard(),
                  SizedBox(height: 20),
                  // Top Articles
                  TopArticles(),
                  SizedBox(height: 10),
                  // Spacer to push content to top
                  Spacer(),
                ],
              ),
            ),
            // Floated Bottom Navigation Bar
            Positioned(
              bottom: 10,
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
              child: BottomNavBar(), // Removed the wrapper Container
            ),
          ],
        ),
      ),
    );
  }
}