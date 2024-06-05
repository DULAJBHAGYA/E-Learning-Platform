import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';
import '../../services/userServices.dart';

class RegisterdStudentsCard extends StatelessWidget {
  final int user_id;
  final String first_name;
  final String last_name;
  final String user_name;
  final String email;

  const RegisterdStudentsCard({
    required this.user_id,
    required this.first_name,
    required this.last_name,
    required this.user_name,
    required this.email,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: white,
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Image
          CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('images/user1.jpg'),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$first_name $last_name',
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w600, color: black),
                ),
                SizedBox(height: 5),
                Text(
                  '$user_name',
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w400, color: black),
                ),
              ],
            ),
          ),
          Spacer(),
          PopupMenuButton<String>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: white,
            onSelected: (value) {
              if (value == 'delete') {
                // Handle delete action here
                // You can show a confirmation dialog before deleting
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Confirm Deletion'),
                    content: Text('Are you sure you want to delete this user?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                        child: Text('No'),
                      ),
                      TextButton(
                        onPressed: () async {
                          try {
                            await UserService.instance.deleteUser(user_id);
                            // Optionally, you can show a success message or perform any other action after deletion
                          } catch (e) {
                            // Handle error if deletion fails
                            print('Error deleting user: $e');
                          }
                          Navigator.pop(context); // Close the dialog
                        },
                        child: Text('Yes'),
                      ),
                    ],
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'delete',
                child: Text('DELETE STUDENT',
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: black)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
