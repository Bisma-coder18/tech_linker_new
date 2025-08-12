import 'package:flutter/material.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:tech_linker_new/screens/AboutUs_SettingScreen.dart';
import 'package:tech_linker_new/screens/admin/ManageInstitute.dart';
import 'package:tech_linker_new/screens/admin/ManageInterships.dart';
import 'package:tech_linker_new/screens/admin/Supports_feedbackAdmin.dart';
import 'package:tech_linker_new/screens/admin/ManageStudents.dart';
import 'package:tech_linker_new/screens/admin/admin_login.dart';
import 'package:tech_linker_new/screens/admin/admin_main_screen.dart';
import 'package:tech_linker_new/widget/list_tiles.dart';
import 'package:tech_linker_new/theme/app_colors.dart';
import 'package:tech_linker_new/theme/app_text_styles.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _currentIndex = 0;
  String adminName = 'Admin Name';
  String adminEmail = 'admin@gmail.com';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _screens = [
    const AdminHomeScreen(),
    const ManageInternships(),
    const Manageinstitute(),
    const ManageStudentsScreen(),
  ];

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[100],
      body: _screens[_currentIndex],
      drawer: _buildDrawer(),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          CurvedNavigationBarItem(
            child: Icon(Icons.dashboard,
                color: AppColors.primary ?? const Color(0xFF6750A4)),
            label: 'Dashboard',
            labelStyle: TextStyle(
                color: AppColors.primary ?? const Color(0xFF6750A4),
                fontSize: 12),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.work,
                color: AppColors.primary ?? const Color(0xFF6750A4)),
            label: 'Internships',
            labelStyle: TextStyle(
                color: AppColors.primary ?? const Color(0xFF6750A4),
                fontSize: 12),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.apartment,
                color: AppColors.primary ?? const Color(0xFF6750A4)),
            label: 'Institutes',
            labelStyle: TextStyle(
                color: AppColors.primary ?? const Color(0xFF6750A4),
                fontSize: 12),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.school,
                color: AppColors.primary ?? const Color(0xFF6750A4)),
            label: 'Students',
            labelStyle: TextStyle(
                color: AppColors.primary ?? const Color(0xFF6750A4),
                fontSize: 12),
          ),
        ],
        backgroundColor: Colors.transparent,
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        height: 70,
        animationDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF2A0845),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6750A4), Color(0xFF2A0845)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.admin_panel_settings,
                color: Colors.grey[800],
                size: 50,
              ),
            ),
            accountName: Text(
              adminName,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            accountEmail:
                Text(adminEmail, style: const TextStyle(fontSize: 14)),
          ),
          // CustomListTiles(
          //   icon: Icons.support_agent,
          //   title: 'Support & Feedback',
          //   color: Colors.white,
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (_) => const SupportAndFeedbackScreen()),
          //     );
          //   },
          // ),
          CustomListTiles(
            icon: Icons.info_outline,
            title: 'About Us',
            color: Colors.white,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutusSettingscreen()),
              );
            },
          ),
          const Divider(color: Colors.white24, indent: 16, endIndent: 16),
          CustomListTiles(
            icon: Icons.logout,
            title: 'Sign Out',
            color: Colors.white,
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => AdminLoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
