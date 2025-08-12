import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:tech_linker_new/screens/institute/applied-students.dart';
import 'package:tech_linker_new/screens/institute/institute-home.dart';
import 'package:tech_linker_new/screens/institute/internship-post.dart';
import 'package:tech_linker_new/screens/institute/settings-institute.dart';
import 'package:tech_linker_new/theme/app_colors.dart';

class InstituteMainScreen extends StatefulWidget {
  const InstituteMainScreen({Key? key}) : super(key: key);

  @override
  State<InstituteMainScreen> createState() => _InstituteMainScreenState();
}

class _InstituteMainScreenState extends State<InstituteMainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    InstituteHomeScreen(),
    InternshipPostScreen(),
    AppliedUsersScreen(),
    InstituteSettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          CurvedNavigationBarItem(child: Icon(Icons.home), ),
          CurvedNavigationBarItem(child: Icon(Icons.post_add), ),
          CurvedNavigationBarItem(child: Icon(Icons.badge), ),
          CurvedNavigationBarItem(child: Icon(Icons.person)),
        ],
        backgroundColor: Colors.transparent,
        color: AppColors.white,
        buttonBackgroundColor:AppColors.white,
       
      ),
    );
  }
}
