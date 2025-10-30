import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../color.dart';

class LogoutConfirmationDialog extends StatefulWidget {
  const LogoutConfirmationDialog({Key? key}) : super(key: key);

  @override
  _LogoutConfirmationDialogState createState() => _LogoutConfirmationDialogState();
}

class _LogoutConfirmationDialogState extends State<LogoutConfirmationDialog> {
  bool _isCancelHovered = false;
  bool _isLogoutHovered = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      title: Text(
        'Logout of your account',
        style: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: black,
        ),
        textAlign: TextAlign.left,
      ),
      content: Text(
        'Are you sure you want to logout from your account?',
        style: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: grey,
        ),
        textAlign: TextAlign.left,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Cancel button
            MouseRegion(
              onEnter: (_) => setState(() => _isCancelHovered = true),
              onExit: (_) => setState(() => _isCancelHovered = false),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Return false when canceled
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isCancelHovered ? background.withOpacity(0.8) : background2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                ),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: black,
                  ),
                ),
              ),
            ),
            // Logout button
            MouseRegion(
              onEnter: (_) => setState(() => _isLogoutHovered = true),
              onExit: (_) => setState(() => _isLogoutHovered = false),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // Return true when confirmed
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isLogoutHovered ? background2.withOpacity(0.8) : background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                ),
                child: Text(
                  'Logout',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}