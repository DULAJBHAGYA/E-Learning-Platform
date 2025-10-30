import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../color.dart';
import '../../services/enrollServices.dart';
import '../my courses/presentation/pages/myCourses.dart';
import 'sharedPreferencesHelper.dart';

class ActionButton extends StatefulWidget {
  final bool active;
  final bool pending;
  final int course_id;

  const ActionButton({
    Key? key,
    required this.active,
    required this.pending,
    required this.course_id,
  }) : super(key: key);

  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    if (!widget.active && !widget.pending) {
      return TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          backgroundColor: darkblue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          side: BorderSide(
            color: darkblue,
            width: 2,
          ),
        ),
        onPressed: () async {
          try {
            int? user_id = await SharedPreferencesHelper.getUserId();
            if (user_id == null) {
              print('User ID not found in SharedPreferences');
              return;
            }

            await EnrollService.instance.postEnrollment(
              user_id,
              widget.course_id,
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Enroll request sent successfully!'),
                duration: Duration(seconds: 2),
              ),
            );
          } catch (e) {
            print('Enrollment Error: $e');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text('Failed to send enroll request. Please try again.'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: Text(
          'Enroll Now'.toUpperCase(),
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: white,
          ),
        ),
      );
    } else if (!widget.active && widget.pending) {
      return TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          backgroundColor: pendingColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          side: BorderSide(
            color: pendingColor,
            width: 2,
          ),
        ),
        onPressed: null,
        child: Text(
          'Pending'.toUpperCase(),
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: white,
          ),
        ),
      );
    } else if (widget.active && !widget.pending) {
      return TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          backgroundColor: darkblue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          side: BorderSide(
            color: darkblue,
            width: 2,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyCourses()),
          );
        },
        child: Text(
          'Get Started'.toUpperCase(),
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: white,
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}