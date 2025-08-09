import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Instituteeditprofile extends StatefulWidget {
  final String instituteId;

  const Instituteeditprofile({Key? key, required this.instituteId}) : super(key: key);

  @override
  State<Instituteeditprofile> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<Instituteeditprofile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.18:3000/institutes/${widget.instituteId}'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          nameController.text = data['name'] ?? "";
          phoneController.text = data['phone'] ?? "";
          emailController.text = data['email'] ?? "";
        });
      } else {
        print("Failed to load profile");
      }
    } catch (e) {
      print("Error fetching profile: $e");
    }
  }

  Future<void> updateProfile() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.put(
        Uri.parse('http://192.168.1.18:3000/institutes/update-profile/${widget.instituteId}'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "name": nameController.text,
          "email": emailController.text,
          "phone": phoneController.text,
        }),
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile updated successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update profile")),
        );
      }
    } catch (e) {
      print("Error updating profile: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error updating profile")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey.shade100,
      labelStyle: TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.w600),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: Colors.blue.shade600,
        centerTitle: true,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Update Your Institute Profile",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              "Make sure your information is up to date so students can contact you easily.",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 35),

            // Name Field
            TextField(
              controller: nameController,
              decoration: inputDecoration("Name"),
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade900,
              ),
            ),
            const SizedBox(height: 20),

            // Email Field
            TextField(
              controller: emailController,
              decoration: inputDecoration("Email"),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade900,
              ),
            ),
            const SizedBox(height: 20),

            // Phone Field
            TextField(
              controller: phoneController,
              decoration: inputDecoration("Phone"),
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade900,
              ),
            ),
            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: isLoading ? null : updateProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 5,
              ),
              child: isLoading
                  ? const SizedBox(
                height: 28,
                width: 28,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
              )
                  : const Text(
                "Save Changes",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
