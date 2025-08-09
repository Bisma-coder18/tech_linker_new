import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // ✅ Toggle values
  bool twoStepVerification = false;
  bool profileVisibility = true;
  bool readReceipts = true;
  bool locationAccess = false;

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
              // ✅ Navigate to Edit Profile Screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Change Password"),
            onTap: () {
              // ✅ Navigate to Change Password Screen
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
            onChanged: (val) {
              setState(() {
                profileVisibility = val;
              });
            },
          ),
          SwitchListTile(
            title: const Text("Read Receipts"),
            subtitle: const Text("Show when you've read messages"),
            value: readReceipts,
            onChanged: (val) {
              setState(() {
                readReceipts = val;
              });
            },
          ),
          SwitchListTile(
            title: const Text("Location Access"),
            subtitle: const Text("Allow location for internships near you"),
            value: locationAccess,
            onChanged: (val) {
              setState(() {
                locationAccess = val;
              });
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
          SwitchListTile(
            title: const Text("Two-step Verification"),
            value: twoStepVerification,
            onChanged: (val) {
              setState(() {
                twoStepVerification = val;
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.phonelink_lock),
            title: const Text("Manage Devices"),
            subtitle: const Text("Check and remove logged in devices"),
            onTap: () {
              // ✅ Navigate to Manage Devices Screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text("Security Tips"),
            onTap: () {
              // ✅ Show Security Tips
            },
          ),
        ],
      ),
    );
  }
}
