import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tech_linker_new/screens/AboutUs_SettingScreen.dart';
import 'package:tech_linker_new/screens/AdminSetting_Screen.dart';
import 'package:tech_linker_new/screens/Manage%20Students.dart';
import 'package:tech_linker_new/screens/ManageInstitute.dart';
import 'package:tech_linker_new/screens/ManageInterships.dart';
import 'package:tech_linker_new/screens/SignIn_screen.dart';
import 'package:tech_linker_new/screens/Supports_feedbackAdmin.dart';
import 'package:tech_linker_new/widget/Card_Widget.dart';
import 'package:tech_linker_new/widget/list_tiles.dart';
class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});
  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}
class _AdminDashboardState extends State<AdminDashboard> {
  String adminName ='AdminName';
  String adminEmail ='Admin@gmail.com';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isDrawerOpen = false;

  void _handleDrawer() {
    if (_isDrawerOpen) {
      Navigator.of(context).pop();
    } else {
      _scaffoldKey.currentState!.openDrawer();
    }
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  final Map<String, int> internshipsPerMonth = {
    'Jan': 3,
    'Feb': 5,
    'Mar': 2,
    'Apr': 6,
    'May': 4,
  };

  final Map<String, int> studentsPerMonth = {
    'Jan': 2,
    'Feb': 4,
    'Mar': 3,
    'Apr': 5,
    'May': 6,
  };

  final Map<String, int> cityVisits = {
    'Lahore': 10,
    'Karachi': 8,
    'Islamabad': 5,
    'Multan': 4,
    'Faisalabad': 7,
  };

  Widget buildBarChart(String title, Map<String, int> dataMap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 16),
        AspectRatio(
          aspectRatio: 1.7,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 10,
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true, reservedSize: 28),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      List<String> labels = dataMap.keys.toList();
                      if (value.toInt() >= 0 && value.toInt() < labels.length) {
                        return Text(labels[value.toInt()], style: const TextStyle(color: Colors.white));
                      }
                      return  Text('');
                    },
                  ),
                ),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              barGroups: dataMap.entries.toList().asMap().entries.map(
                    (entry) {
                  return BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: entry.value.value.toDouble(),
                        color: Colors.deepPurpleAccent,
                        width: 16,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  );
                },
              ).toList(),
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Color(0XFF6750A4),
        title: Text('Admin Dashboard', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon:Icon(Icons.menu, color: Colors.white),
          onPressed: _handleDrawer,
        ),
      ),
      drawer: Drawer(
        backgroundColor:Color(0xFF2A0845),
        child: ListView(
          children: [
           UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.admin_panel_settings, color: Colors.black, size: 70),
              ),
              accountName: Text('AdminName'),
              accountEmail: Text('AdminEmail'),
            ),
            Column(
              children: [
                CustomListTiles(icon: Icons.dashboard, title: 'Dashboard',color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminDashboard()))),
                CustomListTiles(icon: Icons.work_outline, title: 'Manage Internships',color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Manageinterships()))),
                CustomListTiles(icon: Icons.school, title: 'Manage Students',color: Colors.white, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ManageStudentsScreen()))),
                CustomListTiles(icon: Icons.apartment, title: 'Manage Institutes',color: Colors.white, onTap: ()  {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Manageinstitute()));}),
                CustomListTiles(icon: Icons.bar_chart, title: 'Analytics And Reports',color: Colors.white, onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AdminDashboard()));}),
                CustomListTiles(icon: Icons.settings, title: 'Settings',color: Colors.white, onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AdminsettingScreen()));}),
                CustomListTiles(icon: Icons.support_agent, title: 'SupportAndFeedback',color: Colors.white, onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SupportAndFeedbackScreen()));}),
                CustomListTiles(icon: Icons.info_outline, title: 'AboutUs',color: Colors.white, onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AboutusSettingscreen()));}),
                CustomListTiles(icon: Icons.logout, title: 'SignOut',color: Colors.white, onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>  SigninScreen()))),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding:EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:EdgeInsets.all(8.0),
                    child: CustomCard(title: 'ManageInternships', icon: Icons.work_outline_rounded, subTitle: 'Total post:12', color: const Color(0xFFC95792)),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: CustomCard(title: 'ManageInstitutes', icon: Icons.apartment, subTitle: 'Total Institutes: 5', color: const Color(0xFF7E5CAD)),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomCard(title: 'ManageStudents', icon: Icons.school, subTitle: 'Total post:12', color: const Color(0xFF48A6A7)),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomCard(title: 'Featured Internships', icon: Icons.star, subTitle: 'Total Internships: 20', color: const Color(0xFFF8B55F)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 70,),
            Divider(thickness: 3,color: Colors.black26,),
            SizedBox(height: 70),
            SizedBox(
              height: 400,
              child: PageView(
                children: [
                  Center(child: buildBarChart("Internships Per Month", internshipsPerMonth)),
                  Center(child: buildBarChart("Students Added Per Month", studentsPerMonth)),
                  Center(child: buildBarChart("App Visits Per City", cityVisits)),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  void show_editDialogue(){
    final nameController =TextEditingController(text: adminName);
    final emailController =TextEditingController(text: adminEmail);

    showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          title: Text('Edit Profile'),
          content: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText:'Email' ),
              ),
              
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
                onPressed:()=>Navigator.of(context).pop(),
                ),
            ElevatedButton(onPressed: (){
              setState(() {
                adminName =nameController.text;
                adminEmail=emailController.text;
              });
              Navigator.of(context).pop();
            }, child: Text('Save'))
          ],
        ));
  }
}
