import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import '../../color.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final String time;
  final VoidCallback? onDelete;

  const NotificationCard({
    Key? key,
    required this.title,
    required this.message,
    required this.time,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Dismissible(
          key: Key(title + time),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            color: red,
            child: Icon(
              Iconsax.trash,
              color: white,
              size: 20,
            ),
          ),
          onDismissed: (direction) {
            if (onDelete != null) {
              onDelete!();
            }
          },
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: black,
                      ),
                    ),
                    Text(
                      time,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 10,
                        color: grey,
                      ),
                    ),
                  ],
                ),
                Text(
                  message,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}