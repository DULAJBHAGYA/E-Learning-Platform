import 'package:flutter/material.dart';

import 'login/login.dart';

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
      routes: {'/': (context) => Login()},
    );
  }
}

// AdminChangePassword(
//               username: '',
//               accessToken: '',
//               refreshToken: '',
//             )