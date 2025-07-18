import 'package:flutter/material.dart';
import 'package:tech_linker_new/screens/studentSignUp_ScreenTWo.dart';
import 'package:tech_linker_new/widget/Container_Widget.dart';
import 'package:tech_linker_new/widget/CustomElevated_Button.dart';
import 'package:tech_linker_new/widget/TextField_widget.dart';

class studentSignUpOne extends StatefulWidget {
  const studentSignUpOne ({super.key});

  @override
  State<studentSignUpOne > createState() => _ScreenFiveState();
}

class _ScreenFiveState extends State<studentSignUpOne > {

  @override
  TextEditingController nameCtrl=TextEditingController();
  TextEditingController emailCtrl=TextEditingController();
  TextEditingController passwordCtrl=TextEditingController();
  TextEditingController conformPasswordCtrl=TextEditingController();

  String?nameError;
  String?emailError;
  String?passwordError;
  String?conformPasswordError;
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
        resizeToAvoidBottomInset : false,
        backgroundColor: Colors.transparent,
        body: Column(
        children: [
        SizedBox(
        height: 60,
    ),
    Center(
    child: Text(
    'SignUp',
    style: TextStyle(color: Colors.white, fontSize: 50),
    textAlign: TextAlign.center,
    )),
    Padding(
    padding: const EdgeInsets.all(20),
    child: Expanded(
      child: ContainerWidget(
        child: Column(
        children: [
        SizedBox(height: 30,),
        Padding(
        padding: const EdgeInsets.only(right:250 ),
        child: Text('FullName',style: TextStyle(color: Colors.white,fontSize: 15),textAlign: TextAlign.left,),
        ),
        Padding(
        padding: const EdgeInsets.only(left: 30,right: 30,bottom:10,top: 10),
        child: TextFeild(hintText: 'Enter Full Name', icon: Icons.person, borderColor: Colors.white, fillColor: Colors.white,  controller:nameCtrl, keyboardType: TextInputType.text),
        ),
          nameError==null?SizedBox.shrink():Text(nameError!,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
        Padding(
        padding: const EdgeInsets.only(right:280 ),
        child: Text('Email',style: TextStyle(color: Colors.white,fontSize: 15),textAlign: TextAlign.left,),
        ),
        Padding(
        padding: const EdgeInsets.only(left: 30,right: 30,bottom:10,top: 10),
        child: TextFeild(hintText: 'Enter Email', icon: Icons.email, borderColor: Colors.white, fillColor: Colors.white, controller:emailCtrl, keyboardType: TextInputType.text),
        ),
          emailError==null?SizedBox.shrink():Text(emailError!,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
        Padding(
        padding: const EdgeInsets.only(right:250 ),
        child: Text('Password',style: TextStyle(color: Colors.white,fontSize: 15),textAlign: TextAlign.left,),
        ),
        Padding(
        padding: const EdgeInsets.only(left: 30,right: 30,bottom:10,top: 10),
        child: TextFeild(hintText: 'Enter Password', icon: Icons.lock_open, borderColor: Colors.white, fillColor: Colors.white,  controller:passwordCtrl, keyboardType: TextInputType.number),
        ),
          passwordError==null?SizedBox.shrink():Text(passwordError!,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
        Padding(
        padding: const EdgeInsets.only(right:190 ),
        child: Text('ConfirmPassword',style: TextStyle(color: Colors.white,fontSize: 15),textAlign: TextAlign.left,),
        ),
        Padding(
        padding: const EdgeInsets.only(left: 30,right: 30,bottom:10,top: 10),
        child: TextFeild(hintText: 'Confirm', icon: Icons.lock, borderColor: Colors.white, fillColor: Colors.white, controller:conformPasswordCtrl, keyboardType: TextInputType.number),
        ),
          conformPasswordError==null?SizedBox.shrink():Text(conformPasswordError!,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
          Padding(
            padding: const EdgeInsets.all(20),
            child: CustomelevatedButton(onPressed: (){
                setState(() {
                  emailError=null;
                  nameError=null;
                  passwordError=null;
                  conformPasswordError=null;
                  if (nameCtrl.text.isEmpty) {
                    setState(() {
                      nameError = 'Full name is required';
                    });
                  }
                  if (emailCtrl.text.isEmpty) {
                    setState(() {
                      emailError = 'Email is required';
                    });
                  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                      .hasMatch(emailCtrl.text)) {
                    setState(() {
                      emailError = 'Enter a valid email';
                    });
                  }
                  if (passwordCtrl.text.isEmpty) {
                    setState(() {
                      passwordError = 'Password is required';
                    });
                  } else if (passwordCtrl.text.length < 8) {
                    setState(() {
                      passwordError = 'Password must be at least 8 characters';
                    });
                  } else if(passwordCtrl.text != conformPasswordCtrl.text){
                    setState(() {
                      conformPasswordError = 'Password not match';
                    });
                  }
                  if(nameError == null && emailError == null && passwordError == null && conformPasswordError==null){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ScreenSix()));
                  }
                });

              }, text: 'Next', backgroundColor: Colors.white, fontsize: 20, fontWeight: FontWeight.bold, textColor: Colors.black),
          )
        ],
        ),
      ),
    ),
    ),
    ],
    )
        ),
    );
  }
}





