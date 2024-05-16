
import 'package:flutter/material.dart';

import 'admin/admin home/adminDash.dart';




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
        '/': (context) =>  AdminDash(),
      },
    );
  }
}
