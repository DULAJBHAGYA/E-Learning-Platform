import 'package:e_learning/admin/add%20courses/addCourses.dart';
import 'package:e_learning/color.dart';
import 'package:e_learning/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
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
      key: _scaffoldKey,  
      backgroundColor: background,
      drawer: NavDrawer(),  
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
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Image.asset(
      '/logos/logo.png', 
      width: 100,
      height: 80,
    ),
  ),
),
          SizedBox(height: 20,),
          ListTile(
            leading: Icon(Iconsax.home),
            title: Text('Dashboard',
            style: GoogleFonts.nunito(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: black,
            ),
            ),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminDash(username: '', accessToken: '', refreshToken: '')),
              ),
            },
          ),
          ListTile(
            leading: Icon(Iconsax.book),
            title: Text('Courses',
            style: GoogleFonts.nunito(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: black,
            ),
            ),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminCourses(username: '', accessToken: '', refreshToken: ''),)
              ),
            },
          ),
          ListTile(
            leading: Icon(Iconsax.book_saved),
            title: Text('Add Courses',
            style: GoogleFonts.nunito(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: black,
            ),
            ),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddCourses(username: '', accessToken: '', refreshToken: ''),),),
            },
          ),
          ListTile(
            leading: Icon(Iconsax.people),
            title: Text('Students',
            style: GoogleFonts.nunito(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: black,
            ),
            ),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminStudents(username: '', accessToken: '', refreshToken: ''),)),
              
            },
          ),
          ListTile(
            leading: Icon(Iconsax.add),
            title: Text('Enrollments',
            style: GoogleFonts.nunito(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: black,
            ),
            ),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Iconsax.people),
            title: Text('Admins',
            style: GoogleFonts.nunito(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: black,
            ),
            ),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Admins(username: '', accessToken: '', refreshToken: ''),)),
            },
          ),
          ListTile(
            leading: Icon(Iconsax.user),
            title: Text('Profile',
            style: GoogleFonts.nunito(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: black,
            ),
            ),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Iconsax.logout),
            title: Text('Logout',
            style: GoogleFonts.nunito(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: black,
              ),
            ),
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
