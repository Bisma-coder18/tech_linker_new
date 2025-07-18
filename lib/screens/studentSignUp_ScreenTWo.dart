import 'package:flutter/material.dart';
import 'package:tech_linker_new/screens/Student_dashboard.dart';
import 'package:tech_linker_new/screens/home_screen.dart';
import 'package:tech_linker_new/widget/CustomElevated_Button.dart';
import 'package:tech_linker_new/widget/TextField_widget.dart';

class ScreenSix extends StatefulWidget {
  const ScreenSix({super.key});

  @override
  State<ScreenSix> createState() => _ScreenSixState();
}

class _ScreenSixState extends State<ScreenSix> {
  TextEditingController universityCtrl=TextEditingController();
  TextEditingController phoneCtrl=TextEditingController();
  TextEditingController graduationCtrl=TextEditingController();
  TextEditingController GradYearCtrl=TextEditingController();

  String? universityError;
  String? graduationError;
  String? phoneError;
  String? selectedGradYear;
  List<String> gradYears = ['2024', '2025', '2026', '2027'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
        child: Container(
        decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(16)
        ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 245,top: 20),
                child: Text('University',style: TextStyle(color: Colors.white,fontSize: 16),textAlign: TextAlign.left,),
              ),
             Padding(
               padding: const EdgeInsets.only(left: 30,right: 30,bottom:10),
               child: TextFeild(hintText: 'MIT', icon: null, borderColor:Colors.white, fillColor: Colors.white, controller:universityCtrl, keyboardType:TextInputType.text ),
             ),
              universityError==null?SizedBox.shrink():Text(universityError!,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
              Padding(
                padding: const EdgeInsets.only(right: 240),
                child: Text('Graduation',style: TextStyle(color: Colors.white,fontSize: 16),textAlign: TextAlign.left,),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30,bottom:10,top: 10),
                child: TextFeild(hintText: 'BsCs', borderColor: Colors.white, fillColor: Colors.white, controller:graduationCtrl, keyboardType: TextInputType.text, icon: null,),
              ),
              graduationError==null?SizedBox.shrink():Text(graduationError!,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
              Padding(
                padding: const EdgeInsets.only(right: 210),
                child: Text('GraduationYear',style: TextStyle(color: Colors.white,fontSize: 16),textAlign: TextAlign.left,),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0,left: 24,right: 24,bottom: 10),
                child: DropdownButtonFormField<String>(
                  value: selectedGradYear,
                  decoration: InputDecoration(

                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  items: gradYears.map((year) {
                    return DropdownMenuItem(
                      value: year,
                      child: Text(year),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedGradYear = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 210),
                child: Text('PhoneNumber',style: TextStyle(color: Colors.white,fontSize: 16),textAlign: TextAlign.left,),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 30,right: 30,bottom: 10),
              child: TextFeild(hintText: 'phoneNumber', borderColor: Colors.white, fillColor: Colors.white,controller:phoneCtrl, keyboardType: TextInputType.number, icon: null,),
            ),
              phoneError==null?SizedBox.shrink():Text(phoneError!,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
              Padding(
                padding: const EdgeInsets.all(20),
                child: CustomelevatedButton(onPressed: (){
                  setState(() {
                    universityError=null;
                    graduationError=null;
                    phoneError=null;
                    if (universityCtrl.text.isEmpty) {
                      setState(() {
                        universityError = 'Must enter detail';
                      });
                    }
                    if (graduationCtrl.text.isEmpty) {
                      setState(() {
                        graduationError = 'Not empty';
                      });
                    }
                    if (phoneCtrl.text.isEmpty) {
                      setState(() {
                        phoneError = 'Required';
                      });
                    }
                    if(universityError == null && graduationError == null && phoneError == null ){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StudentDashboard()));
                    }
                  });
                }, text: 'Next', backgroundColor: Colors.white, fontsize: 20, fontWeight: FontWeight.bold, textColor: Colors.black),
              )

            ],
          ),
        ),
      )
          )
      ],
      ),
      ),
      

    );
  }
}
