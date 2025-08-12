import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:tech_linker_new/screens/admin/Internship_detailScreeen.dart';
import 'package:tech_linker_new/services/admin/admin_dashboard_apis.dart';

// lib/widget/intern_card.dart
import 'package:flutter/material.dart';
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
      return date; // Fallback to raw date if parsing fails
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: const Color(0xFF6750A4),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Manage Internships',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8),
                        child: TextField(
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value.toLowerCase();
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Search by internship or location',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                      ),
                      ...internships
                          .where((internship) =>
                              internship['title']
                                  ?.toLowerCase()
                                  .contains(searchQuery) ||
                              internship['location']
                                  ?.toLowerCase()
                                  .contains(searchQuery))
                          .map((internship) => InternCard(
                                text: internship['title'] ?? 'Untitled',
                                posted: formatDate(
                                    internship['datePosted'] ?? 'Unknown'),
                                institute: internship['instituteId']?['name'] ??
                                    'Unknown Institute',
                                location: internship['location'] ?? 'Unknown',
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          InternshipDetailscreeen(
                                        title:
                                            internship['title'] ?? 'Untitled',
                                        posted: formatDate(
                                            internship['datePosted'] ??
                                                'Unknown'),
                                        institute: internship['instituteId']
                                                ?['name'] ??
                                            'Unknown Institute',
                                        location:
                                            internship['location'] ?? 'Unknown',
                                        duration: internship['duration'] ??
                                            '3 Months', // Add duration to schema if needed
                                        description:
                                            internship['description'] ??
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
                                onDeleteTap: () async {
                                  // Implement delete API call
                                  try {
                                    final response = await http.delete(
                                      Uri.parse(
                                          '${AppKeys}/internships/${internship['_id']}'),
                                    );
                                    if (response.statusCode == 200) {
                                      setState(() {
                                        internships.remove(internship);
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Failed to delete internship')),
                                      );
                                    }
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Error: $e')),
                                    );
                                  }
                                },
                              ))
                          .toList(),
                    ],
                  ),
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
  final VoidCallback onDeleteTap;

  const InternCard({
    super.key,
    required this.text,
    required this.posted,
    required this.institute,
    required this.location,
    required this.onTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon or Image Placeholder
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
                        const Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          posted,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.business,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          institute,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            location,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Delete Button
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDeleteTap,
                tooltip: 'Delete Internship',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
