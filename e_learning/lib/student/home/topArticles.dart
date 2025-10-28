import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';

class TopArticles extends StatefulWidget {
  const TopArticles({Key? key}) : super(key: key);

  @override
  _TopArticlesState createState() => _TopArticlesState();
}

class _TopArticlesState extends State<TopArticles> {
  // Sample articles data - in a real app this would come from an API
  final List<Map<String, String>> articles = [
    {
      'title': 'Introduction to Flutter',
      'description': 'Learn the basics of Flutter development',
      'image': 'assets/images/flutter.png',
    },
    {
      'title': 'Advanced Dart Programming',
      'description': 'Master advanced concepts in Dart',
      'image': 'assets/images/dulaj.jpg',
    },
    {
      'title': 'UI/UX Design Principles',
      'description': 'Essential design principles for mobile apps',
      'image': 'assets/images/ai1.jpg',
    },
    {
      'title': 'Backend Development with .NET',
      'description': 'Build robust APIs using .NET Core',
      'image': 'assets/images/goCourse.png',
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Articles for You',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: black,
            ),
          ),
          SizedBox(height: 15),
          // Article cards
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return ArticleCard(
                  title: articles[index]['title']!,
                  description: articles[index]['description']!,
                  imagePath: articles[index]['image']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ArticleCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const ArticleCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Article image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              imagePath,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 100,
                  color: Colors.grey[300]!,
                  child: Icon(
                    Icons.image_not_supported,
                    color: Colors.grey[600],
                  ),
                );
              },
            ),
          ),
          // Article content
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}