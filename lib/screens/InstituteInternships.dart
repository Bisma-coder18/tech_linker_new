import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_linker_new/screens/InstituteInternship_detailScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Instituteinternships extends StatefulWidget {
  const Instituteinternships({super.key});

  @override
  State<Instituteinternships> createState() => _InstituteinternshipsState();
}

class _InstituteinternshipsState extends State<Instituteinternships> {
  List<Map<String, dynamic>> internships = [];
  File? _selectedImage;
  final   titleController = TextEditingController();
  final locationController = TextEditingController();
  final   descriptionController = TextEditingController();
  String selectedType = 'Paid';

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
  Future<void> _submitInternship() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("http://10.0.2.2:3000/api/internships/add"),


    );

    // ✅ Add form fields
    request.fields['title'] = titleController.text;
    request.fields['location'] = locationController.text;
    request.fields['description'] = descriptionController.text;
    request.fields['type'] = selectedType; // Paid/Unpaid dropdown value

    // ✅ Add image file (if picked)
    if (_selectedImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        _selectedImage!.path,
      ));
    }

    // ✅ Send request
    var response = await request.send();

    if (response.statusCode == 201) {
      titleController.clear();
      locationController.clear();
      descriptionController.clear();
      setState(() {
        _selectedImage = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Internship posted successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to post internship')),
      );
    }
  }
  @override
  void initState() {
    super.initState();
    fetchInternships();
  }
  Future<void> fetchInternships() async {
    try {
      final response = await http.get(
        Uri.parse("http://10.0.2.2:3000/api/internships/get"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        setState(() {
          internships = data.map<Map<String, dynamic>>((item) {
            return {
              'title': item['title'],
              'location': item['location'],
              'description': item['description'],
              'type': item['type'],
              'posted': item['createdAt']!= null
                  ? item['createdAt'].substring(0, 10)
                  : 'No Date',
              'image': item['image'] != null ? "http://10.0.2.2:3000/uploads/${item['image']}" : null,
            };
          }).toList();

        });
      } else {
        print('Failed to load internships');
      }
    } catch (e) {
      print('Error fetching internships: $e');
    }
  }



  void _showPostForm() {
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
                value: selectedType,
                onChanged: (value) => setState(() => selectedType = value!),
                items: ['Paid', 'Unpaid']
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
              ),
              ElevatedButton(
                onPressed: () async {
                  await _submitInternship();
                  await fetchInternships(); // ✅ refresh data from backend
                  Navigator.pop(context);
                },
                child: Text('Post Internship'),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
                  ? Image.network(
                  post['image'], //
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover)
                  : Icon(Icons.image),
              title: Text(post['title'] ?? 'No Title'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${post['location']} • ${post['type']}"),
                  Text(post['description'], maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
              trailing: Text(post['posted']),
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>InstituteinternshipDetailscreen(post: post)));},
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
