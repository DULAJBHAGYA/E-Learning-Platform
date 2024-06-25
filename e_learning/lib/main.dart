import 'package:flutter/material.dart';

import 'login/login.dart';
import 'on board screens/onBoardingScreens.dart';
import 'student/videos display/ytVideoPlayer.dart';

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