import 'package:e_learning/admin/add%20courses/addCourses.dart';
import 'package:e_learning/color.dart';
import 'package:e_learning/login/login.dart';
import 'package:e_learning/services/userServices.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

import '../add new admin/admins.dart';
import '../admin courses/adminCourses.dart';
import '../admin profile/adminProfile.dart';
import '../admin students/adminStudents.dart';
import '../enrollments/enrolments.dart';
import '../submissions/submissions.dart';
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
  late String first_name = '';
  late String last_name = '';
  late String picture = '';

  @override
  void initState() {
    super.initState();
    fetchUserById();
  }

  Future<void> fetchUserById() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final user_id = prefs.getInt('user_id');
      final accessToken = prefs.getString('access_token');

      if (user_id != null && accessToken != null) {
        final response =
            await UserService.instance.fetchUsersById(user_id, accessToken);

        setState(() {
          first_name = response['GetUserIDRow']['first_name'];
          last_name = response['GetUserIDRow']['last_name'];
          picture = response['GetUserIDRow']['picture'];
        });

        print('Fetched User: $first_name $last_name');
      } else {
        print('User ID or Access Token not found in SharedPreferences');
      }
    } catch (e) {
      print('Error fetching user info: $e');
    }
  }

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
            padding: const EdgeInsets.all(20.0),
            child: Icon(Iconsax.menu_1, size: 30, color: black),
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Icon(FluentIcons.alert_20_regular, size: 30, color: black),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            children: [
              AdminInfo(
                first_name: first_name,
                last_name: last_name,
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      AdminStats(),
                      SizedBox(
                        height: 20,
                      ),
                      AdminDashStudents(),
                      SizedBox(
                        height: 20,
                      ),
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

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  int _hoverIndex = -1;
  int _selectedIndex = -1;

  void _onEnter(int index) {
    setState(() {
      _hoverIndex = index;
    });
  }

  void _onExit() {
    setState(() {
      _hoverIndex = -1;
    });
  }

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildListTile({
    required int index,
    required IconData icon,
    required String title,
    required Widget destination,
  }) {
    bool isHovered = _hoverIndex == index;
    bool isSelected = _selectedIndex == index;

    return MouseRegion(
      onEnter: (_) => _onEnter(index),
      onExit: (_) => _onExit(),
      child: GestureDetector(
        onTap: () {
          _onTap(index);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: isHovered || isSelected ? darkblue : white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: Icon(
              icon,
              size: 20,
              color: isHovered || isSelected ? white : black,
            ),
            title: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isHovered || isSelected ? white : black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: white,
      child: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: white),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                '/logos/logo.png',
                width: 100,
                height: 80,
              ),
            ),
          ),
          SizedBox(height: 20),
          _buildListTile(
            index: 0,
            icon: Iconsax.home,
            title: 'Dashboard',
            destination:
                AdminDash(username: '', accessToken: '', refreshToken: ''),
          ),
          SizedBox(height: 10),
          _buildListTile(
            index: 1,
            icon: Iconsax.book,
            title: 'Courses',
            destination:
                AdminCourses(username: '', accessToken: '', refreshToken: ''),
          ),
          SizedBox(height: 10),
          _buildListTile(
            index: 2,
            icon: Iconsax.book_saved,
            title: 'Add Courses',
            destination:
                AddCourses(username: '', accessToken: '', refreshToken: ''),
          ),
          SizedBox(height: 10),
          _buildListTile(
            index: 3,
            icon: Iconsax.people,
            title: 'Students',
            destination:
                AdminStudents(username: '', accessToken: '', refreshToken: ''),
          ),
          SizedBox(height: 10),
          _buildListTile(
            index: 4,
            icon: Iconsax.add,
            title: 'Enrollments',
            destination:
                Enrollments(username: '', accessToken: '', refreshToken: ''),
          ),
          SizedBox(height: 10),
          _buildListTile(
              index: 5,
              icon: Iconsax.document,
              title: 'Submissions',
              destination:
                  Submissions(username: '', accessToken: '', refreshToken: '')),
          SizedBox(height: 10),
          _buildListTile(
            index: 6,
            icon: Iconsax.people,
            title: 'Admins',
            destination:
                Admins(username: '', accessToken: '', refreshToken: ''),
          ),
          SizedBox(height: 10),
          _buildListTile(
            index: 7,
            icon: Iconsax.user,
            title: 'Profile',
            destination:
                AdminProfile(username: '', accessToken: '', refreshToken: ''),
          ),
          SizedBox(height: 10),
          _buildListTile(
            index: 8,
            icon: Iconsax.logout,
            title: 'Logout',
            destination: Login(),
          ),
        ],
      ),
    );
  }
}

class AdminInfo extends StatelessWidget {
  final String first_name;
  final String last_name;

  const AdminInfo({
    required this.first_name,
    required this.last_name,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'WELCOME BACK',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: grey,
                    ),
                  ),
                  Text(
                    '$first_name $last_name'.toUpperCase(),
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 60,
                height: 60,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('/images/admin.png'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
