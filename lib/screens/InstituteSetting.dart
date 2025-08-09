import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tech_linker_new/screens/InstituteChangePassword.dart';
import 'package:tech_linker_new/screens/InstituteEditProfile.dart';
import 'package:tech_linker_new/screens/InstituteSecurityTips.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool twoStepVerification = false;
  bool profileVisibility = true;
  bool readReceipts = true;
  bool locationAccess = false;
  bool isLocationToggleProcessing = false;

  @override
  void initState() {
    super.initState();
    fetchSettings("6894c1d410bb949a514a4e40");
  }

  Future<void> fetchSettings(String instituteId) async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.18:3000/api/instituteSetting/$instituteId'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          twoStepVerification = data['twoStepVerification'] ?? false;
          profileVisibility = data['profileVisibility'] ?? true;
          readReceipts = data['readReceipts'] ?? true;
          locationAccess = data['locationAccess'] ?? false;
        });
      } else {
        print("Failed to load settings");
      }
    } catch (e) {
      print("Error fetching settings: $e");
    }
  }

  Future<void> updateSettings(String instituteId) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.18:3000/api/instituteSetting/update/$instituteId'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "twoStepVerification": twoStepVerification,
          "profileVisibility": profileVisibility,
          "readReceipts": readReceipts,
          "locationAccess": locationAccess,
        }),
      );
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        print("Settings updated successfully");
        await fetchSettings(instituteId);
      } else {
        print("Failed to update settings");
      }
    } catch (e) {
      print("Error updating settings: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "Profile",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Edit Profile"),
            subtitle: const Text("Change name, email, etc."),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      Instituteeditprofile(instituteId: "6894c1d410bb949a514a4e40")));
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Change Password"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      Institutechangepassword(instituteId: "6894c1d410bb949a514a4e40")));
            },
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "Privacy",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SwitchListTile(
            title: const Text("Profile Visibility"),
            subtitle: const Text("Allow others to see your profile"),
            value: profileVisibility,
            onChanged: (val) async {
              setState(() {
                profileVisibility = val;
              });
              await updateSettings("6894c1d410bb949a514a4e40");
            },
          ),
          SwitchListTile(
            title: const Text("Read Receipts"),
            subtitle: const Text("Show when you've read messages"),
            value: readReceipts,
            onChanged: (val) async {
              setState(() {
                readReceipts = val;
              });
              await updateSettings("6894c1d410bb949a514a4e40");
            },
          ),
          SwitchListTile(
            title: const Text("Location Access"),
            subtitle: const Text("Allow location for internships near you"),
            value: readReceipts,
            onChanged: (val) async {
              setState(() {
                readReceipts = val;
              });
              await updateSettings("6894c1d410bb949a514a4e40");
            },
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "Security",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text("Security Tips"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Institutesecuritytips()),
              );
            },
          ),
        ],
      ),
    );
  }
}
