
import 'package:e_learning/admin/add%20courses/add%20materials/newMaterial.dart';
import 'package:e_learning/admin/add%20courses/addCourses.dart';
import 'package:e_learning/admin/add%20new%20admin/addAdmin.dart';
import 'package:e_learning/admin/add%20new%20admin/admins.dart';
import 'package:e_learning/admin/admin%20courses/adminCourses.dart';
import 'package:e_learning/admin/admin%20students/adminStudents.dart';
import 'package:e_learning/email%20verified/emailVerified.dart';
import 'package:e_learning/login/login.dart';
import 'package:e_learning/on%20board%20screens/onBoardingScreens.dart';
import 'package:e_learning/register/register.dart';
import 'package:e_learning/splash%20screen/splashscreen.dart';
import 'package:e_learning/student/all%20courses/allCourses.dart';
import 'package:e_learning/student/course%20content/courseContent.dart';
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
        '/': (context) =>  Login(),
      },
    );
  }
}
