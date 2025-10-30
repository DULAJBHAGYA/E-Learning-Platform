import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../color.dart';
import 'articleCard.dart'; // Import the new ArticleCard widget
import '../../data/data_sources/top_articles_data_source.dart'; // Import the data source

class TopArticles extends StatefulWidget {
  const TopArticles({Key? key}) : super(key: key);

  @override
  _TopArticlesState createState() => _TopArticlesState();
}

class _TopArticlesState extends State<TopArticles> {
  late List<TopArticle> articles;

  @override
  void initState() {
    super.initState();
    // Load articles from the data source
    articles = TopArticlesDataSource.getTopArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Articles for You',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: black,
            ),
          ),
          SizedBox(height: 15),
          // Article cards
          SizedBox(
            height: 320,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return ArticleCard(
                  title: articles[index].title,
                  description: 'Learn the basics in just ${articles[index].timeInMinutes} minutes',
                  imagePath: articles[index].image,
                  category: articles[index].category,
                  timeInMinutes: articles[index].timeInMinutes,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}