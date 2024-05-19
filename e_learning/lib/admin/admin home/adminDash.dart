import 'package:e_learning/color.dart';
import 'package:e_learning/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '../add new admin/admins.dart';
import '../admin courses/adminCourses.dart';
import '../admin students/adminStudents.dart';
import 'adminDashCourses.dart';
import 'adminDashStudents.dart';
import 'adminInfo.dart';
import 'adminStats.dart';

class AdminDash extends StatefulWidget {
  const AdminDash({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;

  @override
  _AdminDashState createState() => _AdminDashState();
}

class _AdminDashState extends State<AdminDash> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,  // Assign the GlobalKey to the Scaffold
      backgroundColor: background,
      drawer: NavDrawer(),  // Adding the NavDrawer
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        leading: IconButton(
          icon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(UniconsLine.bars, size: 30, color: black),
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();  // Opens the drawer using the GlobalKey
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(UniconsLine.bell, size: 30, color: black),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            children: [
              AdminInfo(),
              SizedBox(height: 20,),
              Expanded( // Added Expanded to allow ListView to take up remaining space
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      AdminStats(),
                      SizedBox(height: 20,),  
                      AdminDashStudents(),
                      SizedBox(height: 20,),
                      AdminDashCourses()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('/images/python.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Dashboard'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminDash(username: '', accessToken: '', refreshToken: '')),
              ),
            },
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Courses'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminCourses()),
              ),
            },
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Add Courses'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminCourses()),
              ),
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Students'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminStudents(username: '', accessToken: '', refreshToken: ''),)),
              
            },
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Enrollments'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Admins'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Admins()),
              ),
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Profile'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              ),
            },
          ),
        ],
      ),
    );
  }
}
