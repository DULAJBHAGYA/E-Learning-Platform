import 'package:e_learning/services/requestServices.dart';
import 'package:e_learning/services/userServices.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../color.dart';
import '../login/login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your first name';
    }
    return null;
  }

  String? _validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your last name';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    } else if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await UserService.instance.registerUser(
          firstNameController.text,
          lastNameController.text,
          userNameController.text,
          emailController.text,
          passwordController.text,
          roleController.text,
        );

        if (response != null && response['statusCode'] == 200) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Registration Successful'),
                content: Text('You have successfully registered.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          // Handle other response status codes, if needed
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Registration Suucessful'),
                content: Text(
                  'Login into continue',
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      ); // Close the dialog
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Registration Failed'),
              content: Text(
                'An error occurred during registration. Please try again later.',
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        print('Registration failed: $e');
      }
    }
  }

  void postSubscription 
  () async {
      try {
      int? user_id = await SharedPreferencesHelper.getUserId();
      if (user_id == null) {
      print('User ID not found in SharedPreferences');
      return;
      }

      await SubscriptionService.instance.postSubscription(  user_id,); 
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Subscription Request sent successfully!'),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                          } catch (e) {
                                            print('Subscription Error: $e');
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Failed to sent  subscription request. Please try again.'),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                          }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          '/logos/logo.png', 
                          fit: BoxFit.fill,
                          width: 100,
                          height: 80,
                        ),
                      ),
                    ),

                      Text(
                        'Let\'s create your account',
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: black,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          TextFormField(
                            controller: firstNameController,
                            validator: _validateFirstName,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: lightgrey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  lightgrey,
                                  BlendMode.srcIn,
                                ),
                                child: Icon(Iconsax.user),
                              ),
                              iconColor: lightgrey,
                              labelText: 'First Name',
                              labelStyle: GoogleFonts.nunito(
                                fontWeight: FontWeight.bold,
                                color: lightgrey,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: lastNameController,
                            validator: _validateLastName,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: lightgrey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  lightgrey,
                                  BlendMode.srcIn,
                                ),
                                child: Icon(Iconsax.user),
                              ),
                              iconColor: lightgrey,
                              labelText: 'Last Name',
                              labelStyle: GoogleFonts.nunito(
                                fontWeight: FontWeight.bold,
                                color: lightgrey,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: userNameController,
                            validator: _validateUserName,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: lightgrey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  lightgrey,
                                  BlendMode.srcIn,
                                ),
                                child: Icon(Iconsax.direct_right),
                              ),
                              iconColor: lightgrey,
                              labelText: 'User Name',
                              labelStyle: GoogleFonts.nunito(
                                fontWeight: FontWeight.bold,
                                color: lightgrey,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: emailController,
                            validator: _validateEmail,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: lightgrey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  lightgrey,
                                  BlendMode.srcIn,
                                ),
                                child: Icon(Iconsax.sms),
                              ),
                              labelText: 'Email',
                              labelStyle: GoogleFonts.nunito(
                                fontWeight: FontWeight.bold,
                                color: lightgrey,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: _obscurePassword,
                            validator: _validatePassword,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: lightgrey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  lightgrey,
                                  BlendMode.srcIn,
                                ),
                                child: Icon(Iconsax.password_check),
                              ),
                              labelText: 'Password',
                              labelStyle: GoogleFonts.nunito(
                                fontWeight: FontWeight.bold,
                                color: lightgrey,
                              ),
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    lightgrey,
                                    BlendMode.srcIn,
                                  ),
                                  child: Icon(_obscurePassword
                                      ? Iconsax.eye_slash
                                      : Iconsax.eye),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: confirmPasswordController,
                            obscureText: _obscureConfirmPassword,
                            validator: _validateConfirmPassword,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: lightgrey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              prefixIcon: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  lightgrey,
                                  BlendMode.srcIn,
                                ),
                                child: Icon(Iconsax.password_check),
                              ),
                              labelText: 'Confirm Password',
                              labelStyle: GoogleFonts.nunito(
                                fontWeight: FontWeight.bold,
                                color: lightgrey,
                              ),
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    _obscureConfirmPassword =
                                        !_obscureConfirmPassword;
                                  });
                                },
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    lightgrey,
                                    BlendMode.srcIn,
                                  ),
                                  child: Icon(_obscureConfirmPassword
                                      ? Iconsax.eye_slash
                                      : Iconsax.eye),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Checkbox(
                            value: false,
                            onChanged: (value) {},
                          ),
                          Text(
                            'Agree with terms and conditions',
                            style: GoogleFonts.nunito(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _submitForm();
                                postSubscription();
                              }
                            },
                            style: ButtonStyle(
                              elevation:
                                  MaterialStateProperty.all<double>(100.0),
                              side: MaterialStateProperty.all<BorderSide>(
                                BorderSide(
                                  width: 0.0,
                                  color: lightgrey,
                                ),
                              ),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(25.0),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(darkblue),
                            ),
                            child: Text(
                              'CREATE ACCOUNT',
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                                color: white,
                              ),
                            ),
                          ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have an account?',
                                  style: GoogleFonts.nunito(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()),
                                    );
                                  },
                                  child: Text(
                                    'Login',
                                    style: GoogleFonts.nunito(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: darkblue,
                                    ),
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    ]),
              )
            ],
          ),
        ),
      )),
    );
  }
}

class SharedPreferencesHelper {
  static Future<int?> getUserId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getInt('user_id');
    } catch (e) {
      print('Error fetching user ID from SharedPreferences: $e');
      return null;
    }
  }
}

Future<void> saveEmailData(bool is_Email_Verified, String username) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('username', username);
  await prefs.setBool('is_email_verified', is_Email_Verified);
}
