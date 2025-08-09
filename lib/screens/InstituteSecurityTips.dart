import 'package:flutter/material.dart';

class Institutesecuritytips extends StatelessWidget {
  Institutesecuritytips({super.key});

  final List<String> tips = [
    "Use a strong password with numbers, letters, and symbols.",
    "Enable two-step verification for extra security.",
    "Never share your password with anyone.",
    "Regularly check devices logged into your account.",
    "Keep your app and phone software updated.",
    "Be cautious when using public Wi-Fi networks.",
    "Log out from devices you no longer use.",
    "Avoid clicking on suspicious links or emails.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Security Tips"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: tips.length,
          separatorBuilder: (context, index) => const Divider(height: 20),
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.security, color: Colors.blueAccent),
              title: Text(
                tips[index],
                style: const TextStyle(fontSize: 16),
              ),
            );
          },
        ),
      ),
    );
  }
}
