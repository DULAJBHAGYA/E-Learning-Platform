import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        //1st Image of Slider
        Container(
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(
                  'https://eduapp-v2.s3.eu-north-1.amazonaws.com/resources/goCourse.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        //2nd Image of Slider
        Container(
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(
                  "https://eduapp-v2.s3.eu-north-1.amazonaws.com/resources/belnderCourse.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),

        //3rd Image of Slider
        Container(
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(
                  "https://eduapp-v2.s3.eu-north-1.amazonaws.com/resources/psCourse.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),

        //4th Image of Slider
        Container(
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(
                  "https://eduapp-v2.s3.eu-north-1.amazonaws.com/resources/reactCourse.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),

        //5th Image of Slider
        Container(
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(
                  "https://eduapp-v2.s3.eu-north-1.amazonaws.com/resources/awsCourse.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
      options: CarouselOptions(
        height: 150.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 25 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 1200),
        viewportFraction: 0.8,
      ),
    );
  }
}
