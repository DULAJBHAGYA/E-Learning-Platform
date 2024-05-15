
import 'package:e_learning/student/course%20display/courseDescription.dart';
import 'package:flutter/material.dart';

import 'student/profile/stdProfile.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'U-Learn',
      initialRoute: '/',
      routes: {
        '/': (context) => CourseDescription(),
      },
    );
  }
}
