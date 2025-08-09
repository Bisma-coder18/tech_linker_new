import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  // String message = "Loading...";

  // @override
  // void initState() {
  //   super.initState();
  //   fetchMessage();
  // }
  //
  // Future<void> fetchMessage() async {
  //   var url = Uri.parse('http://192.168.1.18:3000/api/message');
  //   try {
  //     var response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       setState(() {
  //         message = data['msg']; // 🟢 Display backend message
  //       });
  //     } else {
  //       setState(() {
  //         message = "Server error: ${response.statusCode}";
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       message = "Connection failed: $e";
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // body: Center(child: Text(message)),
    );
  }
}
