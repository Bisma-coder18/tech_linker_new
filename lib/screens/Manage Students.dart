import 'package:flutter/material.dart';
import 'package:tech_linker_new/screens/StudentDetailScreen.dart';

class ManageStudentsScreen extends StatefulWidget {
  const ManageStudentsScreen({super.key});

  @override
  State<ManageStudentsScreen> createState() => _ManageStudentsScreenState();
}
class _ManageStudentsScreenState extends State<ManageStudentsScreen> {
  Map<String, List<Map<String, String>>> studentNotifications = {};
  List<Map<String, String>> allStudents = [
    {"name": "Ayesha", "email": "ayesha@bisma.com", "Address": "Gujranwala"},
    {"name": "Bisma", "email": "bisma@bisma.com", "Address": "Gujranwala"},
    {"name": "Saniya", "email": "sania@bisma.com", "Address": "Lahore"},
    {"name": "Nimra", "email": "nimra1@bisma.com", "Address": "Gujranwala"},
    {"name": "Muskan", "email": "muskan@bisma.com", "Address": "Rawalpindi"},
    {"name": "Bazgah", "email": "bazgah@bisma.com", "Address": "Islamabad"},
    {"name": "Momina", "email": "momina@bisma.com", "Address": "Gujranwala"},
    {"name": "Hafsa", "email": "hafsa@bisma.com", "Address": "Lahore"},
    {"name": "Eman", "email": "eman@bisma.com", "Address": "Gujranwala"},
    {"name": "Barriya", "email": "barriya@bisma.com", "Address": "Gujranwala"},
  ];


  List<Map<String, String>> filteredStudents = [];
  List<Map<String, String>> deletedStudents = [];



  @override
  void initState() {
    super.initState();
    filteredStudents = allStudents;
  }

  void _filterStudents(String query) {
    final results = allStudents.where((student) {
      final name = student['name']!.toLowerCase();
      final email = student['email']!.toLowerCase();
      final input = query.toLowerCase();
      return name.contains(input) || email.contains(input);
    }).toList();

    setState(() {
      filteredStudents = results;
    });
  }
  void _deleteStudent(int index) {
    final deleted = allStudents[index];
    setState(() {
      deletedStudents.add(deleted);
      allStudents.removeAt(index);
      filteredStudents = List.from(allStudents);
    });
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Student deleted'),
          action: SnackBarAction(
              label: 'Undo',
              onPressed:(){
                setState(() {
                  allStudents.insert(index, deleted);
                  deletedStudents.remove(deleted);
                  filteredStudents=List.from(allStudents);
                });
              } ),
        )
    );
  }
  // void _restoreStudent(Map<String, String> student) {
  //   setState(() {
  //     allStudents.add(student);
  //     deletedStudents.remove(student);
  //     filteredStudents = allStudents;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Manage Students',style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0XFF6750A4),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: _filterStudents,
              decoration: InputDecoration(
                hintText: 'Search by name or email',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredStudents.length,
              itemBuilder: (context, index) {
                final student = filteredStudents[index];
                return ListTile(
                  leading: CircleAvatar(child: Icon(Icons.person)),
                  title: Text(student['name']!,style: TextStyle(color: Colors.white,fontSize: 18),),
                  subtitle: Text(student['email']!,style: TextStyle(color:Colors.white),),
                  onTap: () async {
                    final originalIndex = allStudents.indexOf(student);
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Studentdetailscreen(
                          student: student,
                          onDelete: () => _deleteStudent(originalIndex),
                          Notification:()=>Notification,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
