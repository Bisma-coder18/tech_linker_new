import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:tech_linker_new/screens/admin/Internship_detailScreeen.dart';
import 'package:tech_linker_new/services/admin/admin_dashboard_apis.dart';
import 'package:tech_linker_new/services/api.dart';

class ManageInternships extends StatefulWidget {
  const ManageInternships({super.key});

  @override
  State<ManageInternships> createState() => _ManageInternshipsState();
}

class _ManageInternshipsState extends State<ManageInternships> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  List<dynamic> internships = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchInternships();
  }

  Future<void> fetchInternships() async {
    setState(() => isLoading = true);

    final result = await AdminApiService.fetchInternships();

    if (result['success']) {
      setState(() {
        internships = result['data'];
        isLoading = false;
      });
    } else {
      setState(() {
        errorMessage = result['message'];
        isLoading = false;
      });
    }
  }

  String formatDate(String date) {
    try {
      final DateTime parsedDate = DateTime.parse(date);
      return DateFormat('d MMMM yyyy').format(parsedDate);
    } catch (e) {
      return date;
    }
  }

  Future<void> _createInternship() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateEditInternshipScreen(),
      ),
    );

    if (result == true) {
      fetchInternships();
    }
  }

  Future<void> _editInternship(dynamic internship) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CreateEditInternshipScreen(internship: internship),
      ),
    );

    if (result == true) {
      fetchInternships();
    }
  }

  Future<void> _deleteInternship(dynamic internship) async {
    final bool confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Internship'),
        content: Text(
            'Are you sure you want to delete the internship "${internship['title']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (!confirm) return;

    setState(() => isLoading = true);

    final result = await AdminApiService.deleteInternship(internship['_id']);

    setState(() => isLoading = false);

    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Internship deleted successfully')),
      );
      fetchInternships(); // Refresh list
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete: ${result['message']}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFF6750A4),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Manage Internships',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: _createInternship,
            tooltip: 'Add Internship',
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : Column(
                  children: [
                    // Header Section
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFF6750A4),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                        child: Column(
                          children: [
                            // Search Bar
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 0,
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: searchController,
                                onChanged: (value) {
                                  setState(() {
                                    searchQuery = value.toLowerCase();
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: 'Search by internship or location',
                                  hintStyle: TextStyle(color: Colors.grey[600]),
                                  prefixIcon: Icon(Icons.search,
                                      color: Colors.grey[600]),
                                  suffixIcon: searchController.text.isNotEmpty
                                      ? IconButton(
                                          icon: const Icon(Icons.clear),
                                          onPressed: () {
                                            searchController.clear();
                                            setState(() => searchQuery = '');
                                          },
                                        )
                                      : null,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // List of Internships
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(20),
                        itemCount: internships
                            .where((internship) =>
                                internship['title']
                                    ?.toLowerCase()
                                    .contains(searchQuery) ||
                                internship['location']
                                    ?.toLowerCase()
                                    .contains(searchQuery))
                            .length,
                        itemBuilder: (context, index) {
                          final filteredInternships = internships
                              .where((internship) =>
                                  internship['title']
                                      ?.toLowerCase()
                                      .contains(searchQuery) ||
                                  internship['location']
                                      ?.toLowerCase()
                                      .contains(searchQuery))
                              .toList();

                          final internship = filteredInternships[index];

                          return InternCard(
                            text: internship['title'] ?? 'Untitled',
                            posted: formatDate(
                                internship['datePosted'] ?? 'Unknown'),
                            institute:
                                internship['instituteId']?['name'].toString() ??
                                    'Unknown Institute',
                            location: internship['location'] ?? 'Unknown',
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => InternshipDetailscreeen(
                                    title: internship['title'] ?? 'Untitled',
                                    posted: formatDate(
                                        internship['datePosted'] ?? 'Unknown'),
                                    institute: internship['instituteId']
                                            ?['name'] ??
                                        'Unknown Institute',
                                    location:
                                        internship['location'] ?? 'Unknown',
                                    duration:
                                        internship['duration'] ?? '3 Months',
                                    description: internship['description'] ??
                                        'No description',
                                    stipend: internship['stipend'] ??
                                        'Not specified',
                                    joblevel: internship['joblevel'] ??
                                        'Not specified',
                                    education: internship['education'] ??
                                        'Not specified',
                                  ),
                                ),
                              );
                            },
                            // onEditTap: () => _editInternship(internship),
                            onDeleteTap: () => _deleteInternship(internship),
                          );
                        },
                      ),
                    ),
                  ],
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6750A4),
        onPressed: _createInternship,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class InternCard extends StatelessWidget {
  final String text;
  final String posted;
  final String institute;
  final String location;
  final VoidCallback onTap;
  // final VoidCallback onEditTap;
  final VoidCallback onDeleteTap;

  const InternCard({
    super.key,
    required this.text,
    required this.posted,
    required this.institute,
    required this.location,
    required this.onTap,
    // required this.onEditTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.work_outline,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
              const SizedBox(width: 12),

              // Details Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2A0845),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(posted,
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[600])),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.business,
                            size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(institute,
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[600])),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            location,
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[600]),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Action Buttons
              Column(
                children: [
                  // IconButton(
                  //   icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
                  //   onPressed: onEditTap,
                  //   tooltip: 'Edit Internship',
                  // ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                    onPressed: onDeleteTap,
                    tooltip: 'Delete Internship',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Create/Edit Internship Screen
class CreateEditInternshipScreen extends StatefulWidget {
  final dynamic internship;

  const CreateEditInternshipScreen({super.key, this.internship});

  @override
  State<CreateEditInternshipScreen> createState() =>
      _CreateEditInternshipScreenState();
}

class _CreateEditInternshipScreenState
    extends State<CreateEditInternshipScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _stipendController = TextEditingController();
  final _durationController = TextEditingController();
  final _jobLevelController = TextEditingController();
  final _educationController = TextEditingController();

  bool isLoading = false;
  bool get isEditing => widget.internship != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      _titleController.text = widget.internship['title'] ?? '';
      _locationController.text = widget.internship['location'] ?? '';
      _descriptionController.text = widget.internship['description'] ?? '';
      _stipendController.text = widget.internship['stipend'] ?? '';
      _durationController.text = widget.internship['duration'] ?? '';
      _jobLevelController.text = widget.internship['joblevel'] ?? '';
      _educationController.text = widget.internship['education'] ?? '';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _stipendController.dispose();
    _durationController.dispose();
    _jobLevelController.dispose();
    _educationController.dispose();
    super.dispose();
  }

  Future<void> _saveInternship() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final data = {
        'title': _titleController.text,
        'location': _locationController.text,
        'description': _descriptionController.text,
        'stipend': _stipendController.text,
        'duration': _durationController.text,
        'joblevel': _jobLevelController.text,
        'education': _educationController.text,
      };

      http.Response response;

      if (isEditing) {
        response = await http.put(
          Uri.parse(
              '${AppKeys.baseUrl}/internships/${widget.internship['_id']}'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(data),
        );
      } else {
        response = await http.post(
          Uri.parse('${AppKeys.baseUrl}/internships'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(data),
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Internship ${isEditing ? 'updated' : 'created'} successfully'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true);
      } else {
        throw Exception(
            'Failed to ${isEditing ? 'update' : 'create'} internship');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6750A4),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          isEditing ? 'Edit Internship' : 'Create Internship',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Title is required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Location is required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Description is required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _stipendController,
              decoration: const InputDecoration(
                labelText: 'Stipend',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _durationController,
              decoration: const InputDecoration(
                labelText: 'Duration',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _jobLevelController,
              decoration: const InputDecoration(
                labelText: 'Job Level',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _educationController,
              decoration: const InputDecoration(
                labelText: 'Education Requirements',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: isLoading ? null : _saveInternship,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6750A4),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(isEditing ? 'Update Internship' : 'Create Internship'),
            ),
          ],
        ),
      ),
    );
  }
}
