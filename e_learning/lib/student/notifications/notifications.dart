import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../color.dart';
import '../../shared/bottomNavBAr.dart'; // Import the bottom navigation bar
import 'notification_card.dart'; // Import the notification card widget

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Sample notifications data with dates
  List<Map<String, dynamic>> notifications = [
    {
      'title': 'New Course Available',
      'message': 'Check out our new Flutter Development course',
      'time': '2 hours ago',
      'date': DateTime.now(),
    },
    {
      'title': 'Assignment Due',
      'message': 'Your Python assignment is due tomorrow',
      'time': '5 hours ago',
      'date': DateTime.now().subtract(Duration(hours: 5)),
    },
    {
      'title': 'Course Update',
      'message': 'The React course has been updated with new content',
      'time': '1 day ago',
      'date': DateTime.now().subtract(Duration(days: 1)),
    },
    {
      'title': 'Quiz Results',
      'message': 'You scored 95% on your JavaScript quiz',
      'time': '2 days ago',
      'date': DateTime.now().subtract(Duration(days: 2)),
    },
    {
      'title': 'Welcome Back!',
      'message': 'We\'ve missed you! Check out new courses',
      'time': '5 days ago',
      'date': DateTime.now().subtract(Duration(days: 5)),
    },
  ];

  // Group notifications by date
  Map<String, List<Map<String, dynamic>>> groupNotificationsByDate() {
    Map<String, List<Map<String, dynamic>>> grouped = {
      'Today': [],
      'Yesterday': [],
      'Older': [],
    };

    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(Duration(days: 1));

    for (var notification in notifications) {
      DateTime notificationDate = notification['date'];
      DateTime date = DateTime(notificationDate.year, notificationDate.month, notificationDate.day);
      
      if (date.isAtSameMomentAs(today)) {
        grouped['Today']!.add(notification);
      } else if (date.isAtSameMomentAs(yesterday)) {
        grouped['Yesterday']!.add(notification);
      } else {
        grouped['Older']!.add(notification);
      }
    }

    // Remove empty groups
    grouped.removeWhere((key, value) => value.isEmpty);
    
    return grouped;
  }

  // Delete a notification
  void deleteNotification(Map<String, dynamic> notificationToDelete) {
    setState(() {
      notifications.removeWhere((notification) => 
        notification['title'] == notificationToDelete['title'] && 
        notification['time'] == notificationToDelete['time']
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, dynamic>>> groupedNotifications = groupNotificationsByDate();

    return Scaffold(
      backgroundColor: background ,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Text(
                        'Notifications',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  // Notifications list with date grouping
                  Expanded(
                    child: ListView.builder(
                      itemCount: groupedNotifications.length,
                      itemBuilder: (context, sectionIndex) {
                        String dateGroup = groupedNotifications.keys.elementAt(sectionIndex);
                        List<Map<String, dynamic>> notificationsInSection = groupedNotifications[dateGroup]!;
                        
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Date header
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                dateGroup,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: black,
                                ),
                              ),
                            ),
                            // Notifications in this date group
                            Column(
                              children: notificationsInSection.map((notification) {
                                return NotificationCard(
                                  title: notification['title'],
                                  message: notification['message'],
                                  time: notification['time'],
                                  onDelete: () => deleteNotification(notification), // Pass delete callback
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 5),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Bottom Navigation Bar
            Positioned(
              bottom: 10,
              left: MediaQuery.of(context).size.width * 0.04,
              right: MediaQuery.of(context).size.width * 0.04,
              child: BottomNavBar(), // Add the bottom navigation bar
            ),
          ],
        ),
      ),
    );
  }
}