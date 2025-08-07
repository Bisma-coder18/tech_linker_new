import 'package:flutter/material.dart';
import 'package:tech_linker_new/screens/Admin_dashboard.dart';
import 'package:tech_linker_new/widget/Container_Widget.dart';
import 'package:tech_linker_new/widget/CustomElevated_Button.dart';
import 'package:tech_linker_new/widget/TextField_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AdminsignupScreenone extends StatefulWidget {
  const AdminsignupScreenone({super.key});
  @override
  State<AdminsignupScreenone> createState() => _AdminsignupScreenoneState();
}

class _AdminsignupScreenoneState extends State<AdminsignupScreenone> {
  TextEditingController nameCtrl=TextEditingController();
  TextEditingController emailCtrl=TextEditingController();
  TextEditingController passwordCtrl=TextEditingController();
  TextEditingController confirmCtrl=TextEditingController();
  String?nameError;
  String?emailError;
  String?passwordError;
  String?confirmError;
  Future<void> registerAdmin() async {
    final url = Uri.parse('http://10.0.2.2:3000/admins/signup');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fullName': nameCtrl.text.trim(),
          'email': emailCtrl.text.trim(),
          'password': passwordCtrl.text.trim(),
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        // Signup successful
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AdminDashboard()));
      } else {
        // Signup failed
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(responseData['message'] ?? 'Signup failed'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Server error: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
        backgroundColor: Colors.transparent,
        body:ListView(
        children: [
        SizedBox(
        height:60,
        ),
    Center(child: Text('SignUp',style: TextStyle(fontSize: 50,color: Colors.white),)),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ContainerWidget(child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20,right: 260),
                  child: Text('FullNme',style: TextStyle(color: Colors.white,fontSize: 15),textAlign: TextAlign.left,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10,left: 30,right: 30,bottom: 10),
                  child: TextFeild(hintText: 'john', icon: null, borderColor: Colors.white, fillColor: Colors.white, controller: nameCtrl, keyboardType: TextInputType.text),
                ),
                nameError==null?SizedBox.shrink():Text(nameError!,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                Padding(
                  padding: const EdgeInsets.only(top: 10,right: 280),
                  child: Text('Email',style: TextStyle(color: Colors.white,fontSize: 15),textAlign: TextAlign.left,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10,left: 30,right: 30,bottom: 10),
                  child: TextFeild(hintText: 'enterEmail', icon: null, borderColor: Colors.white, fillColor: Colors.white, controller: emailCtrl, keyboardType: TextInputType.text),
                ),
                emailError==null?SizedBox.shrink():Text(emailError!,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                Padding(
                  padding: const EdgeInsets.only(top: 10,right: 250),
                  child: Text('Password',style: TextStyle(color: Colors.white,fontSize: 15),textAlign: TextAlign.left,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10,left: 30,right: 30,bottom: 10),
                  child: TextFeild(hintText: '123', icon: null, borderColor: Colors.white, fillColor: Colors.white, controller: passwordCtrl, keyboardType: TextInputType.text),
                ),
                passwordError==null?SizedBox.shrink():Text(passwordError!,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                Padding(
                  padding: const EdgeInsets.only(top: 10,right: 190),
                  child: Text('ConfirmPassword',style: TextStyle(color: Colors.white,fontSize: 15),textAlign: TextAlign.left,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:10,left: 30,right: 30,bottom: 10),
                  child: TextFeild(hintText: '123', icon: null, borderColor: Colors.white, fillColor: Colors.white, controller:confirmCtrl, keyboardType: TextInputType.text),
                ),
                confirmError==null?SizedBox.shrink():Text(confirmError!,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                Padding(
                  padding: const EdgeInsets.only(top:20,left: 30,right: 30,bottom: 20),
                  child: CustomelevatedButton(onPressed: (){
                      nameError=null;
                      emailError=null;
                      passwordError=null;
                      confirmError=null;
                      if(nameCtrl.text.isEmpty){
                        setState(() {
                          nameError='Required';
                        });
                      }
                      if(emailCtrl.text.isEmpty){
                        setState(() {
                          emailError='Required';
                        });
                      }else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                          .hasMatch(emailCtrl.text)) {
                           setState(() {
                             emailError = 'Enter a valid email';
                           }
                          );
                           }if(passwordCtrl.text.isEmpty){
                        setState(() {
                          passwordError='Must Required';
                        });
                      }else if(passwordCtrl.text.length<8){
                        setState(() {
                          passwordError='Must 8 Character';
                        });
                      }if(passwordCtrl.text!=confirmCtrl.text){
                        setState(() {
                          confirmError='Password Not Match';
                        });
                      }if (nameError == null &&
                          emailError == null &&
                          passwordError == null &&
                          confirmError == null) {
                        registerAdmin(); // <-- backend call
                      }

                  },
                      text: 'Next', backgroundColor: Colors.white, fontsize: 20, fontWeight: FontWeight.bold, textColor: Colors.black),
                )
              ],
            )),
          )
        ]
    )
    ),
    );
    }
}
