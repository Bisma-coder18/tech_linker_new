import 'package:flutter/material.dart';

class InstituteinternshipDetailscreen extends StatelessWidget {
  final Map post;

  const InstituteinternshipDetailscreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Internship Details"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // 🔼 Image area with tap to open fullscreen
          GestureDetector(
            onTap: () {
              if (post['image'] != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FullImageScreen(
                      imageUrl: post['image'].startsWith('http')
                          ? post['image']
                          : 'http://192.168.1.18:3000/uploads/${post['image']}',
                    ),
                  ),
                );
              }
            },
            child: post['image'] != null
                ? Image.network(
              post['image'].startsWith('http')
                  ? post['image']
                  : 'http://192.168.1.18:3000/uploads/${post['image']}',
              height: screenHeight * 0.45,
              width: double.infinity,
              fit: BoxFit.cover,
            )
                : Container(
              height: screenHeight * 0.45,
              width: double.infinity,
              color: Colors.grey[300],
              child: const Icon(Icons.image, size: 60),
            ),
          ),

          // 🔽 Scrollable content
          Expanded(
            child: Container(
              width: screenWidth,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    detailCard("📌 Title", post['title']),
                    detailCard("📝 Description", post['description']),
                    detailCard("📍 Location", post['location']),
                    detailCard("📅 Date", post['date']),
                    detailCard("💼 Type", post['type']),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget detailCard(String label, String? value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 6),
          Text(
            value ?? "N/A",
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

// 🔍 Fullscreen image screen
class FullImageScreen extends StatelessWidget {
  final String imageUrl;

  const FullImageScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
