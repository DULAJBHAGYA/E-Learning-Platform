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
      'title': 'Introduction to Flutter Development',
      'catagory': 'mobile development',
      'description': 'Learn to build beautiful mobile apps with Flutter and Dart.',
      'what_will': {'skill1': 'Build cross-platform apps', 'skill2': 'UI design'},
      'image': 'assets/images/flutter.png',
    },
    {
      'course_id': 2,
      'title': 'Advanced React Patterns',
      'catagory': 'web development',
      'description': 'Master advanced patterns and techniques in React development.',
      'what_will': {'skill1': 'Advanced hooks', 'skill2': 'Performance optimization'},
      'image': 'assets/images/reactCourse.jpg',
    },
    {
      'course_id': 3,
      'title': 'UI/UX Design Fundamentals',
      'catagory': 'design',
      'description': 'Learn the principles of great user interface and experience design.',
      'what_will': {'skill1': 'Design thinking', 'skill2': 'Prototyping'},
      'image': 'assets/images/psCourse.jpg',
    },
    {
      'course_id': 4,
      'title': 'AWS Cloud Solutions',
      'catagory': 'cloud computing',
      'description': 'Master Amazon Web Services and cloud architecture.',
      'what_will': {'skill1': 'Cloud deployment', 'skill2': 'Security best practices'},
      'image': 'assets/images/awsCourse.jpg',
    },
    {
      'course_id': 5,
      'title': 'Python for Data Science',
      'catagory': 'data science',
      'description': 'Learn Python programming for data analysis and visualization.',
      'what_will': {'skill1': 'Data manipulation', 'skill2': 'Machine learning basics'},
      'image': 'assets/images/python.png',
    },
    {
      'course_id': 6,
      'title': 'Cyber Security Essentials',
      'catagory': 'cyber security',
      'description': 'Fundamental concepts and practices in cybersecurity.',
      'what_will': {'skill1': 'Threat detection', 'skill2': 'Network security'},
      'image': 'assets/images/privacy-policy-concept-illustration_114360-7853.png',
    },
  ];

  // Mock categories
  List<String> _mockCategories = [
    'ALL COURSES',
    'Mobile Development',
    'Web Development',
    'Data Science',
    'UI/UX Design',
    'Cloud Computing',
    'Cyber Security',
  ];

  List<dynamic> _courses = [];
  List<dynamic> _filteredCourses = [];
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'ALL COURSES';

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
            (_selectedCategory == 'ALL COURSES' ||
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: background,
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'All Courses',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
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
              SizedBox(height: 20),
              // Custom horizontal list view for categories
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _mockCategories.map((category) {
                          final isSelected = category == _selectedCategory;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: GestureDetector(
                              onTap: () => _selectCategory(category),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected ? darkblue : background2,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  category,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    color: isSelected ? white : black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
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
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}

class CourseViewCard extends StatefulWidget {
  final int course_id;
  final String description;
  final String image;
  final String title;
  final String catagory;
  final Map<String, dynamic> what_will;

  const CourseViewCard({
    required this.course_id,
    required this.image,
    required this.title,
    required this.catagory,
    required this.description,
    required this.what_will,
    Key? key,
  }) : super(key: key);

  @override
  State<CourseViewCard> createState() => _CourseViewCardState();
}

class _CourseViewCardState extends State<CourseViewCard> {
  // Mock material count
  int materialCount = 12;

  @override
  void initState() {
    super.initState();
    // Use mock data instead of fetching from API
    // fetchMaterialCountByCourseId();
  }

  // Comment out the real fetch function
  /*
  Future<void> fetchMaterialCountByCourseId() async {
    try {
      final response = await CountService.instance
          .getMaterialCountByCourseId(widget.course_id);

      if (response != null) {
        if (response is int) {
          setState(() {
            materialCount = response;
          });
        } else {
          throw Exception('Student count is not an integer');
        }
      } else {
        throw Exception('Response is null');
      }
    } catch (e) {
      print('Error fetching student count: $e');
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: white,
      ),
      child: Column(
        children: [
          // image
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              image: DecorationImage(
                // Use AssetImage for local assets instead of NetworkImage
                image: AssetImage(widget.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 0),
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: 20.0,
              top: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: background2,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          widget.catagory.toUpperCase(),
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: lightgrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  widget.title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: black,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Iconsax.video_play, size: 15, color: darkblue),
                        SizedBox(width: 5),
                        Text(
                          '${materialCount.toString()} lessons',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: lightgrey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Row(
                      children: [
                        Icon(Iconsax.document, size: 15, color: darkblue),
                        SizedBox(width: 5),
                        Text(
                          'Certificate',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: lightgrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CourseDescription(
                                course_id: widget.course_id,
                                image: widget.image,
                                title: widget.title,
                                catagory: widget.catagory,
                                description: widget.description,
                                what_will: widget.what_will,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: darkblue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'View Course'.toUpperCase(),
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}