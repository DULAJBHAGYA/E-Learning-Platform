import 'package:flutter/material.dart';

import '../../services/studentServicecs.dart';
import 'registerStudentsCard.dart';

class RegisteredStudents extends StatefulWidget {
  const RegisteredStudents({Key? key}) : super(key: key);

  @override
  _RegisteredStudentsState createState() => _RegisteredStudentsState();
}

class _RegisteredStudentsState extends State<RegisteredStudents> {
  List<dynamic> _students = []; 

  @override
  void initState() {
    super.initState();
    fetchStundents();
  }

  Future<void> fetchStundents() async {
    try {
      final studentsData = await StudentService.instance.fetchAllStudents();
      setState(() {
        _students = studentsData ?? [];
      });
    } catch (e) {
      print('Error fetching students: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
                      child: Column(
                        children: _students.map((students) {
                          return RegisterdStudentsCard(
                            first_name: students['first_name'],
                            last_name: students['last_name'],
                            user_name: students['user_name'],
                            email: students['email'], user_id: students['user_id'],
                          );
                        }).toList(),
                      )
                    );
  }
}

