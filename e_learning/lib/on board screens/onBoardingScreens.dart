import 'package:e_learning/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../color.dart';
import 'introPage1.dart';
import 'introPage2.dart';
import 'introPage3.dart';

class OnBoardScreens extends StatefulWidget {
  const OnBoardScreens({Key? key}) : super(key: key);

  @override
  State<OnBoardScreens> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreens> {
  //controller to keep track of which page we are on
  PageController _controller = PageController();

  //keep track of if we are on the last page
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //page view
          PageView(controller: _controller, 
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: [
            IntroPage1(),
            IntroPage2(),
            IntroPage3(),
          ]),

          //dot indicator
          Container(
              alignment: Alignment(0, 0.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text('skip', style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w700, color: black),)
                      ),



                  SmoothPageIndicator(controller: _controller, count: 3, effect: SlideEffect(
                    activeDotColor: darkblue,
                    dotColor: background2,
                  ),),

                  onLastPage ? GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text('done', 
                    style: GoogleFonts.nunito(
                      fontSize: 18, 
                      fontWeight: FontWeight.w700, 
                      color: onLastPage ? darkblue : black
                      ),)) : GestureDetector(
                    onTap: () {
                      _controller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    },
                    child: Text('next', 
                    style: GoogleFonts.nunito(
                      fontSize: 18, 
                      fontWeight: FontWeight.w700, 
                      color: onLastPage ? darkblue : black
                      ),)),
                  

                ],
              )),
        ],
      ),
    );
  }
}
