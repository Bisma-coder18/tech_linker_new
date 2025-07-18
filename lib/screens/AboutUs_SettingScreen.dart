import 'package:flutter/material.dart';

class AboutusSettingscreen extends StatefulWidget {
  const AboutusSettingscreen({super.key});

  @override
  State<AboutusSettingscreen> createState() => _AboutusSettingscreenState();
}

class _AboutusSettingscreenState extends State<AboutusSettingscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'About Us',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFE3F2FD)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
          child: Column(
            children: [
              _buildAboutCard(
                icon: '👋',
                title: 'Welcome to TechBridge',
                text:
                'TechBridge is a digital platform that connects students with IT institutes and software houses. We aim to reduce the gap between education and real-world experience by making internships accessible. Our clean interface helps students explore, apply, and grow easily.',
              ),
              _buildAboutCard(
                icon: '🎯',
                title: 'Our Mission',
                text:
                'We believe every student deserves the chance to learn, grow, and explore the industry through internships. Our mission is to offer equal access to opportunities and encourage skill development through modern tech solutions.',
              ),
              _buildAboutCard(
                icon: '👨‍💻',
                title: 'Meet the Team',
                text:
                'We are a team of passionate developers and educators driven to empower students. With innovation, dedication, and teamwork, we deliver tools that make career building smooth and smart for both students and companies.',
              ),
              _buildAboutCard(
                icon: '📈',
                title: 'Future Vision',
                text:
                'We’re planning to evolve TechBridge into a complete career growth platform. Expect smart AI recommendations, online training, and global opportunities. We are building not just for today — but for the future of talent.',
              ),
              _buildAboutCard(
                icon: '🙏',
                title: 'Thank You',
                text:
                'Thank you for trusting TechBridge. Your feedback and participation inspire us. Whether you’re a student exploring internships or an institute looking for talent, your support fuels our mission for a better, connected tech future.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAboutCard({
    required String icon,
    required String title,
    required String text,
  }) {
    return Container(
      margin:EdgeInsets.only(bottom: 20),
      padding:EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.1),
            blurRadius: 10,
            offset:Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$icon $title',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.blueAccent,
              shadows: [
                Shadow(
                  offset: Offset(0.8, 0.8),
                  blurRadius: 2.0,
                  color: Colors.blueGrey,
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              height: 1.7,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
