import 'dart:io';

import 'package:flutter/material.dart';

class InstituteinternshipDetailscreen
    extends StatelessWidget {
  final Map<String, dynamic> post;

  const InstituteinternshipDetailscreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post['title'] ?? 'Internship Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            post['image'] != null && post['image']is File
                ? Image.file(post['image'], height: 200,width: double.infinity, fit: BoxFit.cover)
                : Container(height: 200, color: Colors.grey),
            const SizedBox(height: 16),
            Text("Title: ${post['title']}"),
            Text("Description: ${post['description']}"),
            Text("Location: ${post['location']}"),
            Text("Date: ${post['date']}"),
            Text("Type: ${post['type']}"),
          ],
        ),
      ),
    );
  }
}
