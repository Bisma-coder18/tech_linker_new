import 'package:flutter/material.dart';
import 'package:tech_linker_new/screens/InstituteSignUp_ScreenTwo.dart';
import 'package:tech_linker_new/widget/Container_Widget.dart';
import 'package:tech_linker_new/widget/CustomElevated_Button.dart';
import 'package:tech_linker_new/widget/TextField_widget.dart';

class InstitutesignupScreenone extends StatefulWidget {
  const InstitutesignupScreenone({super.key});

  @override
  State<InstitutesignupScreenone> createState() => _InstitutesignupScreenoneState();
}

class _InstitutesignupScreenoneState extends State<InstitutesignupScreenone> {
  TextEditingController instituteCtrl=TextEditingController();
  TextEditingController businessCtrl=TextEditingController();
  TextEditingController emailCtrl=TextEditingController();
  TextEditingController passwordCtrl=TextEditingController();
  TextEditingController confirmCtrl=TextEditingController();
  String? instituteError;
  String? businessError;
  String? emailError;
  String? passwordError;
  String? confirmError;
  String? selectedBusinessType;
  List<String>BusinessType=['IT','SoftwareHouse','TrainingCenter'];
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
            children: [
              SizedBox(
                height:60,
              ),
              Center(child: Text('SignUp',style: TextStyle(fontSize: 50,color: Colors.white),)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ContainerWidget(child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10,right: 210),
                        child: Text('InstituteName',style: TextStyle(color: Colors.white,fontSize: 15),textAlign: TextAlign.left,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:10,left: 30,right: 30,bottom: 10),
                        child: TextFeild(hintText: 'EraTech', icon: null, borderColor: Colors.white, fillColor: Colors.white, controller: instituteCtrl, keyboardType: TextInputType.text),
                      ),
                      instituteError==null?SizedBox.shrink():Text(instituteError!,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                      Padding(
                        padding: const EdgeInsets.only(right:220),
                        child: Text('BusinessType',style: TextStyle(color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:10,left: 30,right: 30,bottom: 10),
                        child: DropdownButtonFormField(
                            value: selectedBusinessType,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                            ),
                            items: BusinessType.map((type) {
                              return DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                               selectedBusinessType = value;
                              });
                            },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 270),
                        child: Text('Email',style: TextStyle(color: Colors.white,fontSize: 15),textAlign: TextAlign.left,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:10,left: 30,right: 30,bottom: 10),
                        child: TextFeild(hintText: 'email', icon: null, borderColor: Colors.white, fillColor: Colors.white, controller: emailCtrl, keyboardType: TextInputType.text),
                      ),
                      emailError==null?SizedBox.shrink():Text(emailError!,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                      Padding(
                        padding: const EdgeInsets.only(right: 240),
                        child: Text('Password',style: TextStyle(color: Colors.white,fontSize: 15),textAlign: TextAlign.left,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:10,left: 30,right: 30,bottom: 10),
                        child: TextFeild(hintText: 'Enter Password', icon: null, borderColor: Colors.white, fillColor: Colors.white, controller:passwordCtrl, keyboardType: TextInputType.text),
                      ),
                      passwordError==null?SizedBox.shrink():Text(passwordError!,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                      Padding(
                        padding: const EdgeInsets.only(right: 190),
                        child: Text('Confirm Password',style: TextStyle(color: Colors.white,fontSize: 15),textAlign: TextAlign.left,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:10,left: 30,right: 30,bottom: 10),
                        child: TextFeild(hintText: 'Confirm', icon: null, borderColor: Colors.white, fillColor: Colors.white, controller: confirmCtrl, keyboardType: TextInputType.text)),
                      confirmError==null?SizedBox.shrink():Text(confirmError!,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                      Padding(
                        padding: const EdgeInsets.only(top:20,left: 30,right: 30,bottom: 20),
                        child: CustomelevatedButton(onPressed: (){
                          instituteError=null;
                          businessError=null;
                          emailError=null;
                          passwordError=null;
                          confirmError=null;
                          if(instituteCtrl.text.isEmpty){
                            setState(() {
                              instituteError='Must Fill';
                            });
                          } if(emailCtrl.text.isEmpty){
                            setState(() {
                              emailError='Must enter email';
                            });
                          } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                              .hasMatch(emailCtrl.text)) {
                               setState(() {
                              emailError = 'Enter a valid email';
                            });
                          } if(passwordCtrl.text.isEmpty){
                            setState(() {
                              passwordError='Must Required';
                            });
                          }else if(passwordCtrl.text.length<8){
                            setState(() {
                              passwordError='Length must be 8 character';
                            });
                          }
                          else if(passwordCtrl.text!=confirmCtrl.text){
                            setState(() {
                              confirmError='password not match';
                            });
                          }
                          if(instituteError==null&& emailError==null&&passwordError==null&&confirmError==null ){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>InstitutesignupScreentwo()));
                          }
                        }, text: 'NEXT', backgroundColor: Colors.white, fontsize: 20, fontWeight: FontWeight.bold, textColor: Colors.black),
                      )
                    ],
                  )),
                ),
              ),
            ]
        ),
      ),
    );
  }
}

