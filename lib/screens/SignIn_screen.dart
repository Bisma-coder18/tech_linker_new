import 'package:flutter/material.dart';
import 'package:tech_linker_new/screens/Admin_dashboard.dart';
import 'package:tech_linker_new/screens/InstituteSignUp_ScreenOne.dart';
import 'package:tech_linker_new/screens/Institute_Dashboard.dart';
import 'package:tech_linker_new/screens/adminSignUp_ScreenOne.dart';
import 'package:tech_linker_new/screens/studentSignUp_ScreenOne.dart';
import 'package:tech_linker_new/screens/Student_dashboard.dart';
import 'package:tech_linker_new/widget/Container_Widget.dart';
import 'package:tech_linker_new/widget/CustomElevated_Button.dart';
import 'package:tech_linker_new/widget/TextField_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum UserType { student, admin, institute }

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  UserType selectedLoginUserType = UserType.institute;
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  String? emailError;
  String? passwordError;

  Future<void> signInStudent() async {

    final url = Uri.parse('http://10.0.2.2:3000/students/login');
    print("Login Email: ${emailCtrl.text.trim()}");
    print("Login Password: ${passwordCtrl.text.trim()}");
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': emailCtrl.text.trim(),
          'password': passwordCtrl.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StudentDashboard()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              data['message'] ?? 'Login failed',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Something went wrong. Try again later.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      print('Exception: $e');
    }
  }
  Future<void> signInInstitute() async {

    final url = Uri.parse('http://10.0.2.2:3000/institutes/login');
    print("Login Email: ${emailCtrl.text.trim()}");
    print("Login Password: ${passwordCtrl.text.trim()}");
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': emailCtrl.text.trim(),
          'password': passwordCtrl.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => InstituteDashboard()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              data['message'] ?? 'Login failed',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Something went wrong. Try again later.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      print('Exception: $e');
    }
  }
  Future<void> signInAdmin() async {

    final url = Uri.parse('http://10.0.2.2:3000/admins/login');
    print("Login Email: ${emailCtrl.text.trim()}");
    print("Login Password: ${passwordCtrl.text.trim()}");

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': emailCtrl.text.trim(),
          'password': passwordCtrl.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminDashboard()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              data['message'] ?? 'Login failed',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Something went wrong. Try again later.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      print('Exception: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/techLogo.jpeg'),
              ),
            ),
          ),
          Center(
              child: Text(
                'TechLinker',
                style: TextStyle(
                    color: Colors.white, fontSize: 45, fontWeight: FontWeight.bold),
              )),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ContainerWidget(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Welcome',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 270),
                    child: Text(
                      'Email',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30,bottom:10),
                    child: TextFeild(
                        keyboardType: TextInputType.text,
                        controller: emailCtrl,
                        hintText: 'Enter email',
                        icon: Icons.email,
                        borderColor: Colors.white,
                        fillColor: Colors.white),
                  ),
                  emailError == null
                      ? SizedBox.shrink()
                      : Text(
                    emailError!,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 240),
                    child: Text(
                      'Password',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30,bottom:10),
                    child: TextFeild(
                        keyboardType: TextInputType.text,
                        hintText: 'Enter password',
                        icon: Icons.lock_open,
                        borderColor: Colors.white,
                        fillColor: Colors.white,
                        controller: passwordCtrl),
                  ),
                  passwordError == null
                      ? SizedBox.shrink()
                      : Text(
                    passwordError!,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomelevatedButton(onPressed: () {
                      setState(() {
                        emailError = null;
                        passwordError = null;
                      });

                      if (emailCtrl.text.isEmpty) {
                        setState(() {
                          emailError = 'Email is required';
                        });
                        return;
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(emailCtrl.text)) {
                        setState(() {
                          emailError = 'Enter a valid email';
                        });
                        return;
                      }

                      if (passwordCtrl.text.isEmpty) {
                        setState(() {
                          passwordError = 'Password is required';
                        });
                        return;
                      } else if (passwordCtrl.text.length < 8) {
                        setState(() {
                          passwordError = 'Password must be at least 8 characters';
                        });
                        return;
                      }
                      if (selectedLoginUserType == UserType.student) {
                        signInStudent();
                      } else if (selectedLoginUserType == UserType.institute) {
                        signInInstitute();
                      }
                      else if (selectedLoginUserType == UserType.admin) {
                        signInAdmin();
                      }

                    },
                        text: 'SignIn', backgroundColor: Colors.white, fontsize: 30, fontWeight: FontWeight.bold, textColor: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Dont have an account?',
                          style:
                          TextStyle(color: Colors.white, fontSize: 15)),
                      TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
                            ),
                            backgroundColor: Colors.white,
                            builder: (BuildContext context) {
                              UserType? tempSelectedUserType;

                              return StatefulBuilder(
                                builder: (BuildContext context, StateSetter setModalState) {
                                  return Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Choose your role",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            setModalState((){
                                              tempSelectedUserType=UserType.student;
                                            });
                                          },
                                          child: ListTile(
                                            title: const Text('Student'),
                                            leading: Radio<UserType>(
                                              value: UserType.student,
                                              groupValue: tempSelectedUserType,
                                              onChanged: (UserType? value) {
                                                setModalState(() {
                                                  tempSelectedUserType = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            setModalState((){
                                              tempSelectedUserType=UserType.institute;
                                            });
                                          },
                                          child: ListTile(
                                            title: const Text('Institute'),
                                            leading: Radio<UserType>(
                                              value: UserType.institute,
                                              groupValue: tempSelectedUserType,
                                              onChanged: (UserType? value) {
                                                setModalState(() {
                                                  tempSelectedUserType = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            setModalState(() {
                                              tempSelectedUserType=UserType.admin;
                                            });

                                          },
                                          child: ListTile(
                                            title: const Text('Admin'),
                                            leading: Radio<UserType>(
                                              value: UserType.admin,
                                              groupValue: tempSelectedUserType,
                                              onChanged: (UserType? value) {
                                                setModalState(() {
                                                  tempSelectedUserType = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        CustomelevatedButton(onPressed: () {
                                          if (tempSelectedUserType==UserType.student) {
                                            Navigator.pop(
                                                context); // Close the bottom sheet
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        studentSignUpOne ()));
                                          }if (tempSelectedUserType==UserType.institute) {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        InstitutesignupScreenone ()));
                                          }if (tempSelectedUserType == UserType.admin) {
                                            Navigator.pop(context); // Close the bottom sheet
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  TextEditingController _securityKeyController = TextEditingController();
                                                  return AlertDialog(
                                                    title: Text('Enter Security Key'),
                                                    content: TextField(
                                                      controller: _securityKeyController,
                                                      obscureText: true,
                                                      decoration: InputDecoration(hintText: 'Security Key'),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        child: Text('Submit'),
                                                        onPressed: () {
                                                          if (_securityKeyController.text.trim() == 'OnlyForAdmins123') {
                                                            Navigator.pop(context); // Close dialog
                                                            Navigator.of(context).push(MaterialPageRoute(
                                                              builder: (context) => AdminsignupScreenone(),
                                                            ));
                                                          } else {
                                                            Navigator.pop(context); // Close dialog
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              SnackBar(content: Text('Invalid Security Key',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)),
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                }
                                            );
                                          } else {
                                            Text('Please select a role to continue');
                                          }
                                        }, text: 'Continue', backgroundColor: Colors.transparent, fontsize: 20, fontWeight: FontWeight.bold, textColor: Colors.black)
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: Text(
                          'SignUp',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }
}


