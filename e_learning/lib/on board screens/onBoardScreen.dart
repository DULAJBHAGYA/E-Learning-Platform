import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardData> _onboardData = [
    OnboardData('assets/image1.png', 'Title 1', 'Description for the first page.'),
    OnboardData('assets/image2.png', 'Title 2', 'Description for the second page.'),
    OnboardData('assets/image3.png', 'Title 3', 'Description for the third page.')
  ];

  _setSeenOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('seenOnboarding', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: _onboardData.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return OnboardPage(
            data: _onboardData[index],
            isLastPage: index == _onboardData.length - 1,
            onNext: () {
              if (index < _onboardData.length - 1) {
                _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
              } else {
                _setSeenOnboarding();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
              }
            },
            onPrevious: () {
              if (index > 0) {
                _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
              }
            },
          );
        },
      ),
    );
  }
}

class OnboardPage extends StatelessWidget {
  final OnboardData data;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final bool isLastPage;

  OnboardPage({required this.data, required this.onNext, required this.onPrevious, required this.isLastPage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(data.image),
          SizedBox(height: 20),
          Text(data.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Text(data.description, textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!isLastPage)
                TextButton(
                  onPressed: onPrevious,
                  child: Text('Previous'),
                ),
              if (isLastPage)
                TextButton(
                  onPressed: onNext,
                  child: Text('Done'),
                )
              else
                TextButton(
                  onPressed: onNext,
                  child: Text('Next'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class OnboardData {
  final String image;
  final String title;
  final String description;

  OnboardData(this.image, this.title, this.description);
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Text('Welcome to the app!'),
      ),
    );
  }
}
