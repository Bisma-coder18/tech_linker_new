import 'package:flutter/material.dart';

class SupportAndFeedbackScreen extends StatefulWidget {
  const SupportAndFeedbackScreen({super.key});

  @override
  State<SupportAndFeedbackScreen> createState() => _SupportAndFeedbackScreenState();
}

class _SupportAndFeedbackScreenState extends State<SupportAndFeedbackScreen> {
  List<Map<String, dynamic>> studentFeedbacks = [
    {
      'name': 'Ali',
      'message': 'I love this app! Very helpful.',
      'isRead': false,
      'profileUrl': 'https://i.pravatar.cc/150?img=1'
    },
    {
      'name': 'Fatima',
      'message': 'Please add more internship filters.',
      'isRead': false,
      'profileUrl': 'https://i.pravatar.cc/150?img=2'
    },
    {
      'name': 'Junaid',
      'message': 'Please add more internship filters.',
      'isRead': false,
      'profileUrl': 'https://cdn.pixabay.com/photo/2022/09/13/05/34/boy-handsome-pose-ideas-7450990_1280.jpg'

    },
    {
      'name': 'Sufyan',
      'message': 'Please add more internship filters.',
      'isRead': false,
      'profileUrl': 'https://i.pinimg.com/736x/5a/24/3e/5a243e143200e6489fbc451f7e99e043.jpg'
    },
    {
      'name': 'Ayesha',
      'message': 'Please add more internship filters.',
      'isRead': false,
      'profileUrl': 'https://images.pexels.com/photos/1391498/pexels-photo-1391498.jpeg'
    },
    {
      'name': 'Bisma',
      'message': 'Please add more internship filters.',
      'isRead': false,
      'profileUrl': 'https://img.freepik.com/free-photo/young-beautiful-girl-posing-black-leather-jacket-park_1153-8104.jpg?semt=ais_hybrid&w=740'
    },
    {
      'name': 'Rabia',
      'message': 'Please add more internship filters.',
      'isRead': false,
      'profileUrl': 'https://i.pinimg.com/736x/3d/c5/fb/3dc5fb89281b39037074316447e33d84.jpg'
    },
    {
      'name': 'Rimsha',
      'message': 'Please add more internship filters.',
      'isRead': false,
      'profileUrl': 'https://media.istockphoto.com/id/1092715214/photo/two-glad-positive-grinning-lady-stand-in-glasses-spectacles-street-style-stylish-trendy-cool.jpg?s=612x612&w=0&k=20&c=ypVq4SYum8SDK8S8or7jq6svxaKMSW4eSh4l1dlnmSU='
    },

  ];

  List<Map<String, dynamic>> instituteFeedbacks = [
    {
      'name': 'Tech Institute',
      'message': 'App design needs improvement.',
      'isRead': false,
      'profileUrl': 'https://i.pravatar.cc/150?img=3',
    },
    {
      'name': 'Smart Academy',
      'message': 'Can we post multiple internships?',
      'isRead': false,
      'profileUrl': 'https://i.pravatar.cc/150?img=4',
    },
    {
      'name': 'Smart Academy',
      'message': 'Can we post multiple internships?',
      'isRead': false,
      'profileUrl': 'https://i.pravatar.cc/150?img=4',
    },
    {
      'name': 'Smart Academy',
      'message': 'Can we post multiple internships?',
      'isRead': false,
      'profileUrl': 'https://i.pravatar.cc/150?img=4',
    },
    {
      'name': 'Smart Academy',
      'message': 'Can we post multiple internships?',
      'isRead': false,
      'profileUrl': 'https://i.pravatar.cc/150?img=4',
    },
    {
      'name': 'Smart Academy',
      'message': 'Can we post multiple internships?',
      'isRead': false,
      'profileUrl': 'https://i.pravatar.cc/150?img=4',
    },
    {
      'name': 'Smart Academy',
      'message': 'Can we post multiple internships?',
      'isRead': false,
      'profileUrl': 'https://i.pravatar.cc/150?img=4',
    },
    {
      'name': 'Smart Academy',
      'message': 'Can we post multiple internships?',
      'isRead': false,
      'profileUrl': 'https://i.pravatar.cc/150?img=4',
    },
    {
      'name': 'Smart Academy',
      'message': 'Can we post multiple internships?',
      'isRead': false,
      'profileUrl': 'https://i.pravatar.cc/150?img=4'
    },
  ];

  void markAsRead(List<Map<String, dynamic>> list, int index) {
    setState(() {
      list[index]['isRead'] = true;
    });
  }

  Widget buildFeedbackList(List<Map<String, dynamic>> feedbackList, bool isStudent) {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: feedbackList.length,
      itemBuilder: (context, index) {
        final feedback = feedbackList[index];
        return Card(
          margin:  EdgeInsets.symmetric(vertical: 6),
          elevation: 3,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(feedback['profileUrl']),
            ),
            title: Text(feedback['name']),
            subtitle: Text(feedback['message']),
            trailing: feedback['isRead']
                ? Icon(Icons.check, color: Colors.green)
                : TextButton(
              onPressed: () => markAsRead(feedbackList, index),
              child:  Text("Mark as Read"),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title:  Text("Support & Feedback",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          backgroundColor:  Color(0xFF6750A4),
          bottom:  TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(text: "Students"),
              Tab(text: "Institutes"),
            ],
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: TabBarView(
          children: [
            buildFeedbackList(studentFeedbacks, true),
            buildFeedbackList(instituteFeedbacks, true),
          ],
        ),
      ),
    );
  }
}
