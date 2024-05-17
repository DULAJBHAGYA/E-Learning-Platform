import 'package:flutter/material.dart';

import 'registerStudentsCard.dart';

class RegiseredStudents extends StatelessWidget {
  const RegiseredStudents({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          RegisterdStudentsCard(),
          SizedBox(height: 5,),
          RegisterdStudentsCard(),
          SizedBox(height: 5,),
          RegisterdStudentsCard(),
          SizedBox(height: 5,),
          RegisterdStudentsCard(),
          SizedBox(height: 5,),
          RegisterdStudentsCard(),
          SizedBox(height: 5,),
          RegisterdStudentsCard(),
          SizedBox(height: 5,),
          RegisterdStudentsCard(),
          SizedBox(height: 5,),
          RegisterdStudentsCard(),
      
        ],
      ),
    );
  }
}

