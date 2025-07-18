import 'package:flutter/material.dart';
import 'package:tech_linker_new/widget/list_tiles.dart';

class AdminsettingScreen extends StatefulWidget {
  const AdminsettingScreen({super.key});

  @override
  State<AdminsettingScreen> createState() => _AdminsettingScreenState();
}

class _AdminsettingScreenState extends State<AdminsettingScreen> {
  bool isDarkMode=false;
  bool isMaintenanceMode=true;
  bool isNotification=false;
  bool isInstitute =true;
  bool isFeatured=false;
  bool isDelete =true;
  bool isEnable =false;
  bool isFeedbackNotification =true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
            children:[
              Text('🔒Account Setting',style:myStyle),

              CustomListTiles(icon: Icons.edit, title: 'Edit profile', onTap: (){}, color:Colors.black),
              CustomListTiles(icon: Icons.email, title: 'Change Email', onTap: (){}, color:Colors.black),
              CustomListTiles(icon: Icons.key, title: 'Change Security key', onTap: (){}, color:Colors.black),
              CustomListTiles(icon: Icons.lock, title: 'Change Password', onTap: (){}, color:Colors.black),
              Divider(thickness: 2),
              Text('🌐App Setting',style: myStyle,),
              SwitchListTile(title:Text('Dark Mode'),value: isDarkMode, onChanged: (val){setState(() {isDarkMode = val;});}),
              SwitchListTile(title:Text('Maintenance Mode'),value: isMaintenanceMode, onChanged: (val){setState(() {isMaintenanceMode= val;});}),
              Divider(thickness: 2),
              Text('🔔Notification Setting',style: myStyle,),
              SwitchListTile(title:Text('Enable Notification'),value: isNotification, onChanged: (val){setState(() {isNotification = val;});}),
              Divider(thickness: 2,),
              Text('💼Internship Setting',style: myStyle,),
              SwitchListTile(title: Text('Auto-Approve Internships'),value: isInstitute, onChanged: (val){setState(() {isInstitute=val;});}),
              SwitchListTile(title: Text('Featured Internships'),value: isFeatured, onChanged: (val){setState(() {isFeatured=val;});}),
              SwitchListTile(title: Text('Delete Internships'),value: isDelete, onChanged: (val){setState(() {isDelete=val;});}),
              SizedBox(height: 10,),
              Text('    Set Default Internship Duration',style: TextStyle(fontSize: 16),),
              SizedBox(height: 10,),
              Divider(thickness: 2,),
              Text('👥User Management',style: myStyle,),
              SizedBox(height: 10,),
              InkWell(onTap: (){},child: Text('    Delete Users ',style: TextStyle(fontSize: 16),)),
              SizedBox(height: 10,),
              Divider(thickness: 2,),
              Text('Feedback & Support',style: myStyle,),
              SwitchListTile(title: Text('Enable Feedback'),value: isEnable, onChanged: (val){setState(() {isEnable=val;});}),
              SwitchListTile(title: Text('Feedback Notification'),value: isFeedbackNotification, onChanged: (val){setState(() {isFeedbackNotification=val;});}),
              SizedBox(height: 10,),
              InkWell(onTap: (){},child: Text('    Send Acknowledge Email ',style: TextStyle(fontSize: 16),)),
              Divider(thickness: 2,),
              Text('🛠️Advanced Settings',style: myStyle,),
              CustomListTiles(icon: Icons.backup_outlined, title:'BackUp Database', onTap: (){}, color: Colors.black),
              CustomListTiles(icon: Icons.restore, title:'Restore Defaults', onTap: (){}, color: Colors.black),
              Divider(thickness: 2,),
              Text('📄Legal',style: myStyle,),
              CustomListTiles(icon: Icons.privacy_tip, title:'Privacy & Policy', onTap: (){}, color: Colors.black),
              CustomListTiles(icon: Icons.rule, title:'Terms & Conditions', onTap: (){}, color: Colors.black),
              SizedBox(height: 20,),
              ElevatedButton.icon(onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Setting Saved')),
                );
              },icon: Icon(Icons.save,color: Colors.white,),
                  label: Text('Save Settings',style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    minimumSize: Size(double.infinity,50),
                  )
              )

















            ]
        ),
      ),
    );

  }
  final TextStyle myStyle =TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.blueGrey,
      height: 2
  );
}
