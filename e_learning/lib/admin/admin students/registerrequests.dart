import 'package:e_learning/services/requestServices.dart';
import 'package:flutter/material.dart';

import 'registerStudentsCard.dart';
import 'regsiterRequestsCard.dart';

class RegisterRequests extends StatefulWidget {
  const RegisterRequests({Key? key}) : super(key: key);

  @override
  _RegisterRequestsState createState() => _RegisterRequestsState();
}

class _RegisterRequestsState extends State<RegisterRequests> {
  List<dynamic> _subscriptionRequests = []; 

  @override
  void initState() {
    super.initState();
    fetchSubscriptionRequests();
  }

  Future<void> fetchSubscriptionRequests() async {
    try {
      final subscriptionRequestsData = await SubscriptionService.instance.fetchAllSubscriptionRequests();
      setState(() {
        _subscriptionRequests = subscriptionRequestsData ?? [];
      });
    } catch (e) {
      print('Error fetching subscription requests: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
                      child: Column(
                        children: _subscriptionRequests.map((subscriptions) {
                          return RegisterRequestsCard(
                            user_id: subscriptions['user_id'],
                            first_name: subscriptions['first_name'],
                            last_name: subscriptions['last_name'],
                            user_name: subscriptions['user_name'],
                          );
                        }).toList(),
                      )
                    );
  }
}

