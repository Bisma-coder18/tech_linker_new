import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_linker_new/screens/InstituteInternship_detailScreen.dart';

class Instituteinternships extends StatefulWidget {
  const Instituteinternships({super.key});

  @override
  State<Instituteinternships> createState() => _InstituteinternshipsState();
}

class _InstituteinternshipsState extends State<Instituteinternships> {
  List<Map<String, dynamic>> internships = [];
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      _showPostForm();
    }
  }

  void _showPostForm() {
    final titleController = TextEditingController();
    final locationController = TextEditingController();
    final descriptionController = TextEditingController();
    String type = 'Paid';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (_selectedImage != null)
                Image.file(_selectedImage!, height: 100),
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Internship Title'),
              ),
              TextField(
                controller: locationController,
                decoration: InputDecoration(labelText: 'Location'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              DropdownButton<String>(
                value: type,
                onChanged: (value) => setState(() => type = value!),
                items: ['Paid', 'Unpaid']
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
              ),
              ElevatedButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty &&
                      locationController.text.isNotEmpty) {
                    setState(() {
                      internships.add({
                        'title': titleController.text,
                        'location': locationController.text,
                        'description': descriptionController.text,
                        'type': type,
                        'image': _selectedImage,
                        'posted': DateTime.now().toString().substring(0, 10)
                      });
                    });
                    Navigator.pop(context);
                  }
                },
                child: Text('Post Internship'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Internships"),
        backgroundColor: Colors.blueAccent,
      ),
      body: internships.isEmpty
          ? Center(child: Text("No internships yet"))
          : ListView.builder(
        itemCount: internships.length,
        itemBuilder: (context, index) {
          final post = internships[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: post['image'] != null
                  ? Image.file(post['image'], width: 50, fit: BoxFit.cover)
                  : null,
              title: Text(post['title']),
              subtitle: Text("${post['location']} • ${post['type']}"),
              trailing: Text(post['posted']),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>InstituteinternshipDetailscreen(post: post)));
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        child: Icon(Icons.camera_alt),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
