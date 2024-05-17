
import 'package:e_learning/admin/admin%20courses/adminCourses.dart';
import 'package:e_learning/admin/admin%20students/adminStudents.dart';
import 'package:e_learning/login/login.dart';
import 'package:e_learning/register/register.dart';
import 'package:e_learning/student/all%20courses/allCourses.dart';
import 'package:e_learning/student/my%20courses/myCourses.dart';
import 'package:flutter/material.dart';

import 'admin/admin home/adminDash.dart';
import 'student/course display/courseDescription.dart';
import 'student/home/stdHome.dart';




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
        '/': (context) =>  RegisterScreen(),
      },
    );
  }
}
