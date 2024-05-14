import 'package:flutter/material.dart';

import '../../shared/bottomNavBar.dart';

class StudentProfile extends StatelessWidget {
  const StudentProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('Profile'),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}