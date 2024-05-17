import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../color.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width:MediaQuery.of(context).size.width*0.9,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: background2,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(EneftyIcons.search_normal_outline, size: 20, color: grey,),
          SizedBox(width: 10),
          Text('search courses here', style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w500, color: grey
          ),),
        ],
      ),
    );
  }
}
