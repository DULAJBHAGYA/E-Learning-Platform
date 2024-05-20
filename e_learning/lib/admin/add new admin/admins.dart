import 'package:e_learning/admin/add%20new%20admin/addAdmin.dart';
import 'package:e_learning/services/adminServices.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unicons/unicons.dart';

import '../../color.dart';
import '../admin home/adminDash.dart';


class Admins extends StatefulWidget {
  const Admins({
Key? key,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
  }) : super(key: key);

  final String username;
  final String accessToken;
  final String refreshToken;
  
  @override
  _AdminsState createState() => _AdminsState();
  
}

class _AdminsState extends State<Admins> with SingleTickerProviderStateMixin {
    List<dynamic> _admins = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    fetchAdmins();
  }

   Future<void> fetchAdmins() async {
    try {
      final adminsData = await AdminService.instance.fetchAllAdmins();
      setState(() {
        _admins = adminsData ?? [];
      });
    } catch (e) {
      print('Error fetching admins: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      key: _scaffoldKey,  // Assign the GlobalKey to the Scaffold
      drawer: NavDrawer(),  // Adding the NavDrawer
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        leading: IconButton(
          icon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(UniconsLine.bars, size: 30, color: black),
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();  // Opens the drawer using the GlobalKey
          },
        ),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            //header
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    height: 60.0,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: background,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: lightgrey),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search in here',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextButton(
                      onPressed: () {
                        //navigating to new admin page to add new admin
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddAdmin()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(blue),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.all(15.0),
                        ),
                      ),
                      child: Text(
                        'ADD NEW ADMIN',
                        style: GoogleFonts.openSans(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      //inside scroll view it display all the admins 
                      child: Column(
                        children: _admins.map((admin) {
                          return AdminDisplayCard(
                            user_name: admin['user_name'],
                            first_name: admin['first_name'],
                            last_name: admin['last_name'],
                            email: admin['email'],
                            onUpdate: fetchAdmins,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//admin display card widget
class AdminDisplayCard extends StatefulWidget {
  final String user_name;
  final String first_name;
  final String last_name;
  final String email;
  final VoidCallback onUpdate;

  const AdminDisplayCard({
    required this.user_name,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.onUpdate,
    Key? key,
  }) : super(key: key);

  @override
  _AdminDisplayCardState createState() => _AdminDisplayCardState();
}

class _AdminDisplayCardState extends State<AdminDisplayCard> {
  //edit admin details
  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditAdminForm(
          user_name: widget.user_name,
          fullName: widget.first_name + ' ' + widget.last_name,
          email: widget.email,
          onUpdate: widget.onUpdate,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(16),
              
              title: Text(widget.first_name + ' ' + widget.last_name, style: GoogleFonts.openSans(fontWeight: FontWeight.bold, fontSize: 20)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${widget.user_name}', style: GoogleFonts.openSans(fontSize: 15)),
                  Text('${widget.email}', style: GoogleFonts.openSans(fontSize: 15)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Iconsax.trash, color: red),
                  onPressed: () {
                  },
                ),
                SizedBox(width: 8),
                IconButton(
                  //edit button
                  icon: Icon(Iconsax.edit, color: blue,),
                  //when tap on edit button it will open edit admin form
                  onPressed: _showEditDialog,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//edit admin form widget
class EditAdminForm extends StatefulWidget {
  final String user_name;
  final String fullName;
  final String email;
  final VoidCallback onUpdate;

  const EditAdminForm({
    required this.user_name,
    required this.fullName,
    required this.email,
    required this.onUpdate,
  });

  @override
  _EditAdminFormState createState() => _EditAdminFormState();
}

class _EditAdminFormState extends State<EditAdminForm> {
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _userNameController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.fullName);
    _userNameController = TextEditingController(text: widget.user_name);
    _emailController = TextEditingController(text: widget.email);
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

//update admin Method
  Future<void> _updateAdmin() async {
    try {
      await AdminService.instance.updateAdmin(
        _emailController.text,
        _fullNameController.text,
        _passwordController.text,
        _userNameController.text,
      );

      widget.onUpdate();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Admin updated successfully'),
          duration: Duration(seconds: 2),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      print('Error updating admin: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update admin. Please try again later.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Admin'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _fullNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextFormField(
              controller: _userNameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: _updateAdmin,
          child: Text('Save'),
        ),
      ],
    );
  }
}