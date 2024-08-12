import 'package:e_learning/admin/add%20courses/addCourses.dart';
import 'package:e_learning/admin/requests/requests.dart';
import 'package:e_learning/color.dart';
import 'package:e_learning/login/login.dart';
import 'package:e_learning/services/userServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/countServices.dart';
import '../add new admin/admins.dart';
import '../admin courses/adminCourses.dart';
import '../admin profile/adminProfile.dart';
import '../admin students/adminStudents.dart';
import '../delete requests/deleteRequests.dart';
import '../enrollments/enrolments.dart';
import '../submissions/submissions.dart';
import 'adminDashCourses.dart';
import 'adminDashStudents.dart';
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
  int deleteRequestCount = 0;

  @override
  void initState() {
    super.initState();
    fetchUserById();
    fetchDeleteRequestCount();
  }

  Future<void> fetchDeleteRequestCount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');

      if (userId != null) {
        final response =
            await CountService.instance.getDeleteRequestByUserId(userId);

        if (response != null) {
          if (response is int) {
            setState(() {
              deleteRequestCount = response;
            });
          } else {
            throw Exception('Course count is not an integer');
          }
        } else {
          throw Exception('Response is null');
        }
      } else {
        throw Exception('User ID is null');
      }
    } catch (e) {
      print('Error fetching ongoing course count: $e');
    }
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
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Icon(Iconsax.menu_1, size: 30, color: black),
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
           
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: white,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DeleteRequests(
                                username: '',
                                accessToken: '',
                                refreshToken: '')));
                  },
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(
                            Iconsax.notification_status4,
                            size: 30,
                            color: black,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: darkblue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Center(
                              child: Text(
                                deleteRequestCount.toString(),
                                style: GoogleFonts.poppins(
                                  color: white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
                picture: picture,
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
                      AdminDashStudents(
                          username: '', refreshToken: '', accessToken: ''),
                      SizedBox(
                        height: 20,
                      ),
                      AdminDashCourses(
                          username: '', refreshToken: '', accessToken: ''),
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
  const NavDrawer({Key? key}) : super(key: key);

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
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: white,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(color: darkblue),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            '/logos/logo.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Edu',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: lightblue,
                            ),
                            children: [
                              TextSpan(
                                text: 'App',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: 9, // Number of items
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return _buildListTile(
                      index: 0,
                      icon: Iconsax.home,
                      title: 'Dashboard',
                      destination: AdminDash(
                          username: '', accessToken: '', refreshToken: ''),
                    );
                  case 1:
                    return _buildListTile(
                      index: 1,
                      icon: Iconsax.book,
                      title: 'Courses',
                      destination: AdminCourses(
                          username: '', accessToken: '', refreshToken: ''),
                    );
                  case 2:
                    return _buildListTile(
                      index: 2,
                      icon: Iconsax.book_saved,
                      title: 'Add Courses',
                      destination: AddCourses(
                          username: '', accessToken: '', refreshToken: ''),
                    );
                  case 3:
                    return _buildListTile(
                      index: 3,
                      icon: Iconsax.people,
                      title: 'Students',
                      destination: AdminStudents(
                          username: '', accessToken: '', refreshToken: ''),
                    );
                  case 4:
                    return _buildListTile(
                      index: 4,
                      icon: Iconsax.add,
                      title: 'Enrollments',
                      destination: Enrollments(
                          username: '', accessToken: '', refreshToken: ''),
                    );
                  case 5:
                    return _buildListTile(
                      index: 5,
                      icon: Iconsax.document,
                      title: 'Submissions',
                      destination: Submissions(
                          username: '', accessToken: '', refreshToken: ''),
                    );
                  case 6:
                    return _buildListTile(
                      index: 6,
                      icon: Iconsax.people,
                      title: 'Admins',
                      destination: Admins(
                          username: '', accessToken: '', refreshToken: ''),
                    );
                  case 7:
                    return _buildListTile(
                      index: 7,
                      icon: Iconsax.user,
                      title: 'Profile',
                      destination: AdminProfile(
                          username: '', accessToken: '', refreshToken: ''),
                    );
                  case 8:
                    return _buildListTile(
                      index: 8,
                      icon: Iconsax.logout,
                      title: 'Logout',
                      destination: Login(),
                    );
                  default:
                    return SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AdminInfo extends StatelessWidget {
  final String first_name;
  final String last_name;
  final String picture;

  const AdminInfo({
    required this.first_name,
    required this.last_name,
    required this.picture,
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
                  backgroundImage: NetworkImage(picture),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
