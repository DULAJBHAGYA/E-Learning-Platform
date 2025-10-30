class TopArticle {
  final String title;
  final String category;
  final int timeInMinutes;
  final String image;

  TopArticle({
    required this.title,
    required this.category,
    required this.timeInMinutes,
    required this.image,
  });

  // Convert from JSON
  factory TopArticle.fromJson(Map<String, dynamic> json) {
    return TopArticle(
      title: json['title'],
      category: json['category'],
      timeInMinutes: json['timeInMinutes'],
      image: json['image'],
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'timeInMinutes': timeInMinutes,
      'image': image,
    };
  }
}

class TopArticlesDataSource {
  // Sample data for top articles with time between 2 and 10 minutes and image paths
  static List<Map<String, dynamic>> getTopArticlesData() {
    return [
      {
        'title': 'Mastering MongoDB: Unleashing the Power of a Document Database',
        'category': 'Database',
        'timeInMinutes': 8,
        'image': 'assets/images/mongodb.png',
      },
      {
        'title': 'Advanced Dart Programming Techniques',
        'category': 'Programming',
        'timeInMinutes': 8,
        'image': 'assets/images/dulaj.jpg',
      },
      {
        'title': 'UI/UX Design Principles for Mobile Apps',
        'category': 'Design',
        'timeInMinutes': 6,
        'image': 'assets/images/ai1.jpg',
      },
      {
        'title': 'Backend Development with .NET Core',
        'category': 'Backend',
        'timeInMinutes': 9,
        'image': 'assets/images/goCourse.png',
      },
      {
        'title': 'Introduction to Machine Learning',
        'category': 'AI',
        'timeInMinutes': 10,
        'image': 'assets/images/mlbasic.png',
      },
      {
        'title': 'Cloud Computing with AWS',
        'category': 'Cloud',
        'timeInMinutes': 7,
        'image': 'assets/images/awsCourse.jpg',
      },
    ];
  }

  // Get top articles as TopArticle objects
  static List<TopArticle> getTopArticles() {
    return getTopArticlesData()
        .map((articleData) => TopArticle.fromJson(articleData))
        .toList();
  }
}