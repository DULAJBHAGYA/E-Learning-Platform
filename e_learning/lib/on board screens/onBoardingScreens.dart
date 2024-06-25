import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../color.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) => OnBoardScreenContent(
                  image: '/images/intro1.png',
                  title: 'Learn anytime, anywhere',
                  description:
                      'Access courses 24/7 from home, on the go, or at your favorite spot. Learn at your own pace and convenience.',
                ),
              ),
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle,
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkblue,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(0),
                ),
                child: Icon(
                  Iconsax.arrow_right_1,
                  color: white,
                  size: 30,
                ),
              ),
            )
          ],
        )));
  }
}

class OnBoardScreenContent extends StatelessWidget {
  const OnBoardScreenContent(
      {Key? key,
      required this.image,
      required this.title,
      required this.description})
      : super(key: key);

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Image.asset(image, height: 250),
                    const Spacer(),
                    Text(title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: black)),
                    const SizedBox(height: 20),
                    Text(description,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: black,
                            fontWeight: FontWeight.w400)),
                    const Spacer(),
                  ]),
            ),
          ),
        ));
  }
}
