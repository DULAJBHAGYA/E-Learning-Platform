import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';

import '../../services/requestServices.dart'; // Import your SubscriptionService

class RegisterRequestsCard extends StatelessWidget {
  final String user_name;
  final String first_name;
  final String last_name;
  final int user_id;

  const RegisterRequestsCard({
    required this.user_name,
    required this.first_name,
    required this.last_name,
    required this.user_id,
    Key? key,
  }) : super(key: key);

  Future<void> _acceptRequest(BuildContext context) async {
    try {
      await SubscriptionService.instance.editSubscriptionRequest(
        user_id: user_id,
        active: true,
        pending: false,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request accepted')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to accept request: $e')),
      );
    }
  }

  Future<void> _deleteRequest(BuildContext context) async {
    try {
      await SubscriptionService.instance.deleteSubscriptionRequest(user_id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request deleted')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete request: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: white,
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Image
          CircleAvatar(
            radius: 40,
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
                      fontSize: 15, fontWeight: FontWeight.w500, color: black),
                ),
                SizedBox(height: 5),
                Text(
                  '$user_name',
                  style: GoogleFonts.poppins(
                      fontSize: 12, fontWeight: FontWeight.w400, color: black),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Spacer(),
                    ElevatedButton(
                      onPressed: () => _acceptRequest(context),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(5),
                        backgroundColor: darkblue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            ),
                      ),
                      child: Text('ACCEPT',
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: white)),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _deleteRequest(context),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(5),
                        backgroundColor: red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                      ),
                      child: Text('DECLINE',
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
