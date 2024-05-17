import 'package:flutter/material.dart';

import 'regsiterRequestsCard.dart';

class RegisterRequests extends StatelessWidget {
  const RegisterRequests({Key? key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          RegisterRequestsCard(),
          SizedBox(height: 5,),
          RegisterRequestsCard(),
          SizedBox(height: 5,),
          RegisterRequestsCard(),
          SizedBox(height: 5,),
          RegisterRequestsCard(),
          SizedBox(height: 5,),
          RegisterRequestsCard(),
          SizedBox(height: 5,),
          RegisterRequestsCard(),
          SizedBox(height: 5,),
          RegisterRequestsCard(),
        ],
      ),
    );
  }
}