import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../color.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(
            Iconsax.search_normal,
            size: 20,
            color: lightgrey,
          ),
          SizedBox(width: 10),
          Text(
            'search courses here',
            style: GoogleFonts.poppins(
                fontSize: 15, fontWeight: FontWeight.w400, color: lightgrey),
          ),
        ],
      ),
    );
  }
}
