import 'package:e_learning/shared/searchBar.dart';
import 'package:e_learning/student/course%20display/courseDescription.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../color.dart';
// import '../../services/categoryServices.dart'; // Comment out real service
// import '../../services/countServices.dart'; // Comment out real service
// import '../../services/courseServices.dart'; // Comment out real service
import '../../shared/bottomNavBAr.dart';
import 'courseViewCard.dart'; // Import the new CourseViewCard widget
import 'categoryList.dart'; // Import the new CategoryList widget

class StdAllCourses extends StatefulWidget {
  const StdAllCourses({
    Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;

  @override
  _StdAllCoursesState createState() => _StdAllCoursesState();
}

class _StdAllCoursesState extends State<StdAllCourses> {
  // Mock data for courses
  List<Map<String, dynamic>> _mockCourses = [
    {
      'course_id': 1,
      'title': 'Flutter Mobile Development',
      'catagory': 'Mobile Development',
      'description': 'This Flutter course teaches you how to build beautiful, fast, and cross-platform mobile applications for both Android and iOS. You will learn about Flutter’s widget-based architecture, state management, UI design, and how to connect your app to backend services, while building real-world projects to strengthen your skills.',
      'what_will': {'skill1': 'Build cross-platform apps', 'skill2': 'UI design'},
      'image': 'assets/images/flutter.png',
      'duration': '34hr 30min',
      'level': 'Basic'
    },
    {
      'course_id': 2,
      'title': 'Advanced React Patterns',
      'catagory': 'Web Development',
      'description': 'Master advanced patterns and techniques in React development.',
      'what_will': {'skill1': 'Advanced hooks', 'skill2': 'Performance optimization'},
      'image': 'assets/images/reactCourse.jpg',
      'duration': '39hrs 10min',
      'level': 'Intermediate'
    },
    {
      'course_id': 3,
      'title': 'UI/UX Design Fundamentals',
      'catagory': 'UI/UX Design',
      'description': 'Learn the principles of great user interface and experience design.',
      'what_will': {'skill1': 'Design thinking', 'skill2': 'Prototyping'},
      'image': 'assets/images/psCourse.jpg',
      'duration': '40hrs 10min',
      'level': 'Basic'
    },
    {
      'course_id': 4,
      'title': 'AWS Cloud Solutions',
      'catagory': 'Cloud Computing',
      'description': 'Master Amazon Web Services and cloud architecture.',
      'what_will': {'skill1': 'Cloud deployment', 'skill2': 'Security best practices'},
      'image': 'assets/images/awsCourse.jpg',
      'duration': '42hrs 10min',
      'level': 'Intermediate'
    },
    {
      'course_id': 5,
      'title': 'Python for Data Science',
      'catagory': 'Data Science',
      'description': 'Learn Python programming for data analysis and visualization.',
      'what_will': {'skill1': 'Data manipulation', 'skill2': 'Machine learning basics'},
      'image': 'assets/images/python.png',
      'duration': '25hrs 10min',
      'level': 'Intermediate'
    },
    {
      'course_id': 6,
      'title': 'Cyber Security Essentials',
      'catagory': 'Cyber Security',
      'description': 'Fundamental concepts and practices in cybersecurity.',
      'what_will': {'skill1': 'Threat detection', 'skill2': 'Network security'},
      'image': 'assets/images/privacy-policy-concept-illustration_114360-7853.png',
      'duration': '35hrs 10min',
      'level': 'Intermediate'
    },
  ];

  // Mock categories
  List<String> _mockCategories = [
    'All Courses',
    'Mobile Development',
    'Web Development',
    'Data Analytics',
    'Game Development',
    'Artificial Intelligence',
    'Blockchain',
    'Machine Learning',
    'Quality Assurance',
    'Data Science',
    'UI/UX Design',
    'Cloud Computing',
    'Cyber Security',
  ];

  List<dynamic> _courses = [];
  List<dynamic> _filteredCourses = [];
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All Courses';

  @override
  void initState() {
    super.initState();
    // Use mock data instead of fetching from API
    _courses = _mockCourses;
    _filteredCourses = _mockCourses;
    _searchController.addListener(_filterCourses);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterCourses);
    _searchController.dispose();
    super.dispose();
  }

  // Comment out the real fetch function
  /*
  Future<void> fetchCourses() async {
    try {
      final courseData = await CourseService.instance.fetchAllCourses();
      setState(() {
        _courses = courseData ?? [];
        _filterCourses();
      });
    } catch (e) {
      print('Error fetching courses: $e');
    }
  }
  */

  void _filterCourses() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCourses = _courses.where((course) {
        final title = course['title'].toLowerCase();
        final category = course['catagory'].toLowerCase();
        return title.contains(query) &&
            (_selectedCategory.toLowerCase() == 'all courses' ||
                category == _selectedCategory.toLowerCase());
      }).toList();
    });
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _filterCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Stack(
          children: [
              Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Courses',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  CustomSearchBar(
                    controller: _searchController,
                    onChanged: (value) => _filterCourses(),
                  ),
                  SizedBox(height: 10),
                  // Custom horizontal list view for categories
                  CategoryList(
                    categories: _mockCategories,
                    selectedCategory: _selectedCategory,
                    onCategorySelected: _selectCategory,
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: _filteredCourses.map((course) {
                          return CourseViewCard(
                            what_will: course['what_will'] ?? {},
                            description: course['description'] ?? 'No Description',
                            course_id: course['course_id'] ?? 0,
                            image: course['image'] ?? 'assets/images/flutter.png', // Use mock image
                            title: course['title'] ?? 'No Title',
                            catagory: course['catagory'] ?? 'Uncategorized',
                            duration: course['duration'] ?? 'N/A', // Add duration parameter
                            level: course['level'] ?? 'Beginner',
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Bottom Navigation Bar
            Positioned(
              bottom: 10,
              left: MediaQuery.of(context).size.width * 0.04,
              right: MediaQuery.of(context).size.width * 0.04,
              child: BottomNavBar(),
            ),
          ],
        ),
      ),
    );
  }
}
