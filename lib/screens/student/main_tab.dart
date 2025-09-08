import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:tech_linker_new/screens/student/home/home.dart';
import 'package:tech_linker_new/screens/student/interships/all_interships.dart';
import 'package:tech_linker_new/screens/student/interships/applied_internship.dart';
import 'package:tech_linker_new/screens/student/settings/settings.dart';
import 'package:tech_linker_new/theme/app_colors.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({Key? key}) : super(key: key);

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    AllInternships(),
    AppliedInternshipsScreen(),
    SettingsScreen()
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
          CurvedNavigationBarItem(child: Icon(Icons.search), ),
          CurvedNavigationBarItem(child: Icon(Icons.save_rounded)),
          CurvedNavigationBarItem(child: Icon(Icons.person)),
        ],
        backgroundColor: Colors.transparent,
        color: AppColors.white,
        buttonBackgroundColor:AppColors.white,
       
      ),
    );
  }
}
