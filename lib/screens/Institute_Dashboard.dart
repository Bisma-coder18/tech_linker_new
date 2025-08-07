import 'package:flutter/material.dart';
import 'package:tech_linker_new/screens/InstituteInternships.dart';
import 'package:tech_linker_new/screens/InstituteMessage.dart';
import 'package:tech_linker_new/screens/SignIn_screen.dart';
import 'package:tech_linker_new/screens/applicationReceived_institute.dart';
import 'package:tech_linker_new/screens/instituteNotification.dart';
import 'package:tech_linker_new/widget/list_tiles.dart';


class InstituteDashboard extends StatefulWidget {
  const InstituteDashboard({super.key});

  @override
  State<InstituteDashboard> createState() => _InstituteDashboardState();
}
class _InstituteDashboardState extends State<InstituteDashboard> {
  // File? _profileImage;
  // final ImagePicker _picker = ImagePicker();
  //
  // Future<void> _pickImage() async {
  //   final XFile? pickedImage = await _picker.pickImage(
  //       source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     setState(() {
  //       _profileImage = File(pickedImage.path);
  //     });
  //   }
  // }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text('Welcome,Era Tech',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
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
                      // backgroundImage: _profileImage != null
                      //     ? FileImage(_profileImage!)
                      //     : null,
                      // child: _profileImage == null
                      //     ? Icon(Icons.apartment, size: 40, color: Colors.black)
                      //     : null,
                    ),
                  ),
                  accountName: Text('InstituteName'),
                  accountEmail: Text('InstituteEmail')
              ),
              CustomListTiles(icon: Icons.dashboard,
                  title: 'Dashboard',
                  onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>InstituteDashboard()));},
                  color: Colors.white),
              CustomListTiles(icon: Icons.work_outline,
                  title: 'Internships',
                  onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Instituteinternships()));},
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
                  DashboardCard(title: "Applications Received", count: "24", icon: Icons.mail_outline,),
                  DashboardCard(title: "Internships Posted", icon: Icons.post_add, count: "8"),
                  DashboardCard(title: "Active Internships", icon: Icons.work_outline, count: "5"),
                  DashboardCard(title: "Last Posted", icon: Icons.calendar_today, count: "May 22"),
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
                  ActionButton(label: "View Applications", icon: Icons.remove_red_eye, onTap: () {}),
                  ActionButton(label: "Edit Profile", icon: Icons.edit, onTap: () {}),
                ],
              ),
              SizedBox(height: 30),
              Text(
                "Recent Internships",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              ListTile(
                leading:Icon(Icons.work_outline),
                title:Text("Flutter Developer Internship"),
                subtitle:Text("Posted on May 22"),
                trailing:Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.work_outline),
                title: Text("UI/UX Designer Internship"),
                subtitle:Text("Posted on May 20"),
                trailing:Icon(Icons.arrow_forward_ios),
                onTap: () {},
              )
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

  const DashboardCard({super.key, required this.title, required this.icon, required this.count});

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
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
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


