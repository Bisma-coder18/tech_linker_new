import 'package:flutter/material.dart';
import 'package:tech_linker_new/screens/Institute_Dashboard.dart';
import 'package:tech_linker_new/widget/Container_Widget.dart';
import 'package:tech_linker_new/widget/CustomElevated_Button.dart';
import 'package:tech_linker_new/widget/TextField_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class InstitutesignupScreentwo extends StatefulWidget {
  final String institute;
  final String email;
  final String password;
  final String business;
  const InstitutesignupScreentwo({super.key,required this.password,required this.email,required this.business,required this.institute});

  @override
  State<InstitutesignupScreentwo> createState() => _InstitutesignupScreentwoState();
}

class _InstitutesignupScreentwoState extends State<InstitutesignupScreentwo> {
  TextEditingController phoneCtrl=TextEditingController();
  TextEditingController contactCtrl=TextEditingController();
  TextEditingController addressCtrl=TextEditingController();
  String? phoneError;
  String? contactError;
  String? addressError;
  String? selectedCity;
  List<String>CityType =['Lahore','Gujranwala','Islamabad','Gujrat','GujarKhan','Sadar','Faisalabaad','RawalPindi'];
  Future<void> postInstituteData() async {
    final url = Uri.parse('http://192.168.1.18:3000/institutes/signup');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'instituteName': widget.institute,
        'businessType': widget.business,
        'email': widget.email,
        'password': widget.password,
        'phone': phoneCtrl.text.trim(),
        'city': selectedCity ?? "",
        'contactPerson': contactCtrl.text.trim(),
        'address': addressCtrl.text.trim(),
      }),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      print('✅ Signup successful: ${data['message']}');

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Signup Successful! Redirecting...")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const InstituteDashboard()),
        );
      }
    } else {
      final error = json.decode(response.body);
      print('❌ Signup failed: ${error['message']}');

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Signup Failed: ${error['message']}")),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  child: ContainerWidget(child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10,right: 135),
                          child: Text('Phone/WhatsappNumber',style: TextStyle(color: Colors.white,fontSize: 15),textAlign: TextAlign.left,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:10,left: 30,right: 30,bottom: 10),
                          child: TextFeild(hintText: '12345', icon: null, borderColor: Colors.white, fillColor: Colors.white, controller: phoneCtrl, keyboardType: TextInputType.text),
                        ),
                        phoneError==null?SizedBox.shrink():Text(phoneError!,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                        Padding(
                          padding: const EdgeInsets.only(right: 250),
                          child: Text('SelectCity',style: TextStyle(color: Colors.white,fontSize: 15),textAlign: TextAlign.left,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:10,left: 30,right: 30,bottom: 10),
                          child: DropdownButtonFormField(
                            value: selectedCity,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                              ),
                              items: CityType.map((type){
                                return DropdownMenuItem(
                                  value: type,
                                    child: Text(type));
                              }).toList(),
                              onChanged: (value){
                              setState(() {
                                selectedCity =value;
                              });
                              }

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 250),
                          child: Text('Contact with',style: TextStyle(color: Colors.white,fontSize: 15),textAlign: TextAlign.left,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:10,left: 30,right: 30,bottom: 10),
                          child: TextFeild(hintText: 'HR Manager', icon: null, borderColor: Colors.white, fillColor: Colors.white, controller: contactCtrl, keyboardType: TextInputType.text),
                        ),
                        contactError==null?SizedBox.shrink():Text(contactError!,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                        Padding(
                          padding: const EdgeInsets.only(right: 250),
                          child: Text('Address',style: TextStyle(color: Colors.white,fontSize: 15),textAlign: TextAlign.left,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:10,left: 30,right: 30,bottom: 10),
                          child: TextFeild(hintText: 'City/Street...', icon: null, borderColor: Colors.white, fillColor: Colors.white, controller: addressCtrl, keyboardType: TextInputType.text),
                        ),
                         addressError==null?SizedBox.shrink():Text(addressError!,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                        Padding(
                          padding: const EdgeInsets.only(top:20,left: 30,right: 30,bottom: 20),
                          child: CustomelevatedButton(
                            onPressed: () {
                              setState(() {
                                phoneError = phoneCtrl.text.isEmpty ? 'Must Required' : null;
                                contactError = contactCtrl.text.isEmpty ? 'Must Required' : null;
                                addressError = addressCtrl.text.isEmpty ? 'Must Required' : null;
                              });

                              if (phoneError == null && contactError == null && addressError == null) {
                                if (selectedCity == null || selectedCity!.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Please select a city')),
                                  );
                                } else {
                                  print('Business: "${widget.business}"');
                                  print('Institute: "${widget.institute}"');

                                  postInstituteData();
                                }
                              }

                            },
                            text: 'NEXT',
                            backgroundColor: Colors.white,
                            fontsize: 20,
                            fontWeight: FontWeight.bold,
                            textColor: Colors.black,
                          ),

                        )
                      ],
                    ),
                  )),
                ),
              ]
          ),
        ),

    );
  }
}
