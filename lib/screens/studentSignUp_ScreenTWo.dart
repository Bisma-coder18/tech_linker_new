import 'package:flutter/material.dart';
import 'package:tech_linker_new/screens/Student_dashboard.dart';
import 'package:tech_linker_new/widget/CustomElevated_Button.dart';
import 'package:tech_linker_new/widget/TextField_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScreenSix extends StatefulWidget {
  final String email;
  final String fullName;
  final String password;
  const ScreenSix({required this.email,required this.password,required this.fullName, super.key});

  @override
  State<ScreenSix> createState() => _ScreenSixState();
}

class _ScreenSixState extends State<ScreenSix> {
  // Controllers for fields
  TextEditingController universityCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController graduationCtrl = TextEditingController();

  // Dropdown
  String? selectedGradYear;
  List<String> gradYears = ['2024', '2025', '2026', '2027'];

  // Error messages
  String? universityError;
  String? graduationError;
  String? phoneError;

  bool isLoading = false;

  // 🔁 Submit form to backend
  Future<void> submitStudentSignup() async {
    setState(() {
      isLoading = true;
    });

    var url = Uri.parse('http://192.168.1.18:3000/students/signup');

    var body = {
      'email': widget.email,
      'fullName':widget.fullName,
      'password':widget.password,
      'university': universityCtrl.text.trim(),
      'graduation': graduationCtrl.text.trim(),
      'graduationYear': selectedGradYear ?? '',
      'phone': phoneCtrl.text.trim(),
    };

    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      var data = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => StudentDashboard()),
        );
    } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Signup failed')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // 📱 UI BUILD
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            const SizedBox(height: 60),
            const Center(
              child: Text('SignUp',
                  style: TextStyle(color: Colors.white, fontSize: 50)),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 🔷 UNIVERSITY
                        const Text('University',
                            style: TextStyle(
                                color: Colors.white, fontSize: 16)),
                        const SizedBox(height: 8),
                        TextFeild(
                          hintText: 'MIT',
                          icon: null,
                          borderColor: Colors.white,
                          fillColor: Colors.white,
                          controller: universityCtrl,
                          keyboardType: TextInputType.text,
                        ),
                        if (universityError != null)
                          Text(universityError!,
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold)),

                        const SizedBox(height: 20),

                        // 🔷 GRADUATION
                        const Text('Graduation',
                            style: TextStyle(
                                color: Colors.white, fontSize: 16)),
                        const SizedBox(height: 8),
                        TextFeild(
                          hintText: 'BSCS',
                          borderColor: Colors.white,
                          fillColor: Colors.white,
                          controller: graduationCtrl,
                          keyboardType: TextInputType.text,
                          icon: null,
                        ),
                        if (graduationError != null)
                          Text(graduationError!,
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold)),

                        const SizedBox(height: 20),

                        // 🔷 GRAD YEAR
                        const Text('Graduation Year',
                            style: TextStyle(
                                color: Colors.white, fontSize: 16)),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: selectedGradYear,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
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

                        const SizedBox(height: 20),

                        // 🔷 PHONE
                        const Text('Phone Number',
                            style: TextStyle(
                                color: Colors.white, fontSize: 16)),
                        const SizedBox(height: 8),
                        TextFeild(
                          hintText: '03XXXXXXXXX',
                          borderColor: Colors.white,
                          fillColor: Colors.white,
                          controller: phoneCtrl,
                          keyboardType: TextInputType.number,
                          icon: null,
                        ),
                        if (phoneError != null)
                          Text(phoneError!,
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold)),

                        const SizedBox(height: 30),

                        // 🔘 SUBMIT BUTTON
                        Center(
                          child: CustomelevatedButton(
                            onPressed: isLoading ? null : () {
                              setState(() {
                                universityError = universityCtrl.text.isEmpty ? 'University is required' : null;
                                graduationError = graduationCtrl.text.isEmpty ? 'Graduation field is required' : null;
                                phoneError = phoneCtrl.text.isEmpty ? 'Phone number is required' : null;
                              });

                              if (universityError == null && graduationError == null && phoneError == null) {
                                submitStudentSignup();
                              }
                            },
                            text: isLoading ? 'Processing...' : 'Submit',
                            backgroundColor: Colors.white,
                            fontsize: 20,
                            fontWeight: FontWeight.bold,
                            textColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
