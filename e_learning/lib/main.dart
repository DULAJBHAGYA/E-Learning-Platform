import 'package:e_learning/login/login.dart';
import 'package:e_learning/shared/bottomNavBAr.dart';
import 'package:e_learning/splash%20screen/splashscreen.dart';
import 'package:e_learning/student/home/stdHome.dart';
import 'package:e_learning/student/my%20courses/myCourses.dart';
import 'package:flutter/material.dart';

import 'register/register.dart';


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
        '/': (context) => MyCourses(),
      },
    );
  }
}
