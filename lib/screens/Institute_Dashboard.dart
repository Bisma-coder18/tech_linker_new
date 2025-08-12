import 'package:flutter/material.dart';
import 'package:tech_linker_new/screens/InstituteInternship_detailScreen.dart';
import 'package:tech_linker_new/screens/InstituteInternships.dart';
import 'package:tech_linker_new/screens/InstituteMessage.dart';
import 'package:tech_linker_new/screens/InstituteSetting.dart';
import 'package:tech_linker_new/screens/SignIn_screen.dart';
import 'package:tech_linker_new/screens/applicationReceived_institute.dart';
import 'package:tech_linker_new/screens/instituteNotification.dart';
import 'package:tech_linker_new/services/api.dart';
import 'package:tech_linker_new/widget/list_tiles.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class InstituteDashboard extends StatefulWidget {
  const InstituteDashboard({super.key});

  @override
  State<InstituteDashboard> createState() => _InstituteDashboardState();
}
class _InstituteDashboardState extends State<InstituteDashboard> {
  List<Map<String, dynamic>> recentInternships = [];
  String instituteName = "";
  String instituteEmail = "";
  int internshipCount = 0;
  String lastPostedDate = "N/A";
  int activeInternshipCount = 0;
  @override
  void initState() {
    super.initState();
    fetchInternshipCount();
    fetchRecentInternships();
    fetchLastPostedDate();
    fetchActiveInternships();
    loadInstituteData();
  }
  Future<void> loadInstituteData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      instituteName = prefs.getString('instituteName') ?? "Institute Name";
      instituteEmail = prefs.getString('instituteEmail') ?? "Institute Email";
    });
  }
  Future<void> fetchActiveInternships() async {
    try {
      final response = await http.get(
        Uri.parse("${AppKeys.admin}/api/internships/active-month"),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          activeInternshipCount = data.length;
        });
      } else {
        print("Failed to load active internships");
      }
    } catch (e) {
      print("Error fetching active internships: $e");
    }
  }

  Future<void> fetchLastPostedDate() async {
    try {
      final response = await http.get(
        Uri.parse("${AppKeys.admin}/api/internships/get?limit=1"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          print("createdAt: ${data[0]['createdAt']}");
          setState(() {
            lastPostedDate = data[0]['createdAt']?.substring(0, 10) ?? "N/A";
          });
        }
      } else {
        print("Failed to fetch last posted date");
      }
    } catch (e) {
      print("Error fetching last posted date: $e");
    }
  }

  Future<void> fetchRecentInternships() async {
    try {
      final response = await http.get(
        Uri.parse("${AppKeys.admin}/api/internships/get?limit=2"),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          recentInternships = data.map<Map<String, dynamic>>((item) {
            return {
            '_id': item['_id'],
            'title': item['title'],
            'posted': item['createdAt'] != null ? item['createdAt'].substring(0, 10) : 'No Date',
            'image': item['image'],          // include image
            'description': item['description'],
            'location': item['location'],
            };
          }).toList();
        });
      } else {
        print("Failed to load recent internships");
      }
    } catch (e) {
      print("Error fetching recent internships: $e");
    }
  }
  Future<void> fetchInternshipCount() async {
    try {
      final response = await http.get(
        Uri.parse("${AppKeys.admin}/api/internships/count"),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          internshipCount = data['count'];
          print("Count updated: $internshipCount");
        });
      }
    } catch (e) {
      print("Error fetching count: $e");

    }
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text('Welcome,$instituteName',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        drawer: Drawer(
          backgroundColor: Colors.deepPurple,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                  currentAccountPicture: GestureDetector(
                    // onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.settings_applications_rounded),
                    ),
                  ),
                  accountName: Text(instituteName),
                  accountEmail: Text(instituteEmail),
              ),
              CustomListTiles(icon: Icons.dashboard,
                  title: 'Dashboard',
                  onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>InstituteDashboard()));},
                  color: Colors.white),
              CustomListTiles(icon: Icons.work_outline,
                  title: 'Internships',
                  onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Instituteinternships()))
                  .then((_){fetchInternshipCount();
                            fetchActiveInternships();
                            fetchRecentInternships();
                  });},
                  color: Colors.white),
              CustomListTiles(icon: Icons.assignment_outlined,
                  title: 'Applications Received',
                  onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ApplicationsReceivedScreen()));},
                  color: Colors.white),
              CustomListTiles(icon: Icons.message_outlined,
                  title: 'Messages',
                  onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MessagesScreen()));},
                  color: Colors.white),
              CustomListTiles(icon: Icons.notifications_none,
                  title: 'Notifications',
                  onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Institutenotification()));},
                  color: Colors.white),
              CustomListTiles(icon: Icons.settings,
                  title: 'Settings',
                  onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SettingsScreen()));},
                  color: Colors.white),
              CustomListTiles(icon: Icons.logout,
                  title: 'LogOut',
                  onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SigninScreen()));},
                  color: Colors.white),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Dashboard Overview",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  DashboardCard(title: "Applications Received", count: "24", icon: Icons.mail_outline,onTap: (){},),
                  DashboardCard(title: "Internships Posted", icon: Icons.post_add, count: internshipCount.toString(), onTap: (){},),
                  DashboardCard(title: "Active Internships", icon: Icons.work_outline,  count: activeInternshipCount.toString(),onTap: (){},),
                  DashboardCard(title: "Last Posted", icon: Icons.calendar_today, count:lastPostedDate,onTap: (){},),
                ],
              ),
              SizedBox(height: 30),
              Text(
                "Quick Actions",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  ActionButton(label: "Post Internship", icon: Icons.add, onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Instituteinternships()));}),
                  ActionButton(label: "View Applications", icon: Icons.remove_red_eye, onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ApplicationsReceivedScreen()));}),
                  ActionButton(label: "Edit Profile", icon: Icons.edit, onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SettingsScreen()));}),
                ],
              ),
              SizedBox(height: 30),
              Text(
                "Recent Internships",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Column(
                children: recentInternships.map((internship) {
                  final post = internship;
                  return ListTile(
                    leading: Icon(Icons.work_outline),
                    title: Text(internship['title'] ?? 'No Title'),
                    subtitle: Text("Posted on ${internship['posted']}",style: TextStyle(fontSize: 13),),

                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>InstituteinternshipDetailscreen(post: post)));
                    },
                  );
                }).toList(),
              ),

            ],
          ),
        ),
      );
    }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String count;
  final VoidCallback onTap;

  const DashboardCard({super.key, required this.title, required this.icon, required this.count,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 6,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.deepPurple),
              const SizedBox(height: 10),
              Text(
                count,
                style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const ActionButton({super.key, required this.label, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      icon: Icon(icon, size: 20,color: Colors.white,),
      label: Text(label,style: TextStyle(color: Colors.white),),
    );
  }
}


