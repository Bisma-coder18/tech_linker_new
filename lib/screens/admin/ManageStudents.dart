import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tech_linker_new/screens/admin/StudentDetailScreen.dart';
import 'package:tech_linker_new/services/admin/admin_dashboard_apis.dart';
import 'package:tech_linker_new/services/api.dart';

class ManageStudentsScreen extends StatefulWidget {
  const ManageStudentsScreen({super.key});

  @override
  State<ManageStudentsScreen> createState() => _ManageStudentsScreenState();
}

class _ManageStudentsScreenState extends State<ManageStudentsScreen>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  List<dynamic> allStudents = [];
  List<dynamic> filteredStudents = [];
  bool isLoading = true;
  String? errorMessage;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  String filterStatus = 'All'; // New: Filter for active/inactive

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    fetchStudents();
  }

  @override
  void dispose() {
    _animationController.dispose();
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchStudents() async {
    setState(() => isLoading = true);

    final result = await AdminApiService.fetchStudents();

    if (result['success']) {
      setState(() {
        allStudents = result['data'];
        _filterStudents(searchQuery); // Apply filter after fetching
        isLoading = false;
      });
      _animationController.forward();
    } else {
      setState(() {
        errorMessage = result['message'];
        isLoading = false;
      });
    }
  }

  void _filterStudents(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      filteredStudents = allStudents.where((student) {
        final matchesSearch = student['name']
                ?.toLowerCase()
                .contains(searchQuery) ??
            false || student['email']?.toLowerCase().contains(searchQuery) ??
            false;
        final matchesStatus = filterStatus == 'All' ||
            (filterStatus == 'Active' && student['active'] == true) ||
            (filterStatus == 'Inactive' && student['active'] == false);
        return matchesSearch && matchesStatus;
      }).toList();
    });
  }

  Future<void> _toggleStudentActiveStatus(dynamic student) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  student['active'] == true
                      ? 'Confirm Inactivation'
                      : 'Confirm Activation',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          content: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.8,
              maxHeight: MediaQuery.of(context).size.height * 0.3,
            ),
            child: SingleChildScrollView(
              child: Text(
                student['active'] == true
                    ? 'Are you sure you want to mark "${student['name']}" as inactive?\n\nThis action cannot be undone.'
                    : 'Are you sure you want to mark "${student['name']}" as active?',
                style: TextStyle(
                  fontSize: 16 * MediaQuery.of(context).textScaleFactor,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16 * MediaQuery.of(context).textScaleFactor,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0 * MediaQuery.of(context).textScaleFactor,
                ),
              ),
              child: Text(
                student['active'] == true ? 'Inactivate' : 'Activate',
                style: TextStyle(
                  fontSize: 16 * MediaQuery.of(context).textScaleFactor,
                ),
              ),
            ),
          ],
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 16.0 * MediaQuery.of(context).textScaleFactor,
          ),
          actionsPadding: EdgeInsets.only(
            right: 20.0,
            bottom: 16.0 * MediaQuery.of(context).textScaleFactor,
          ),
        );
      },
    );

    if (confirmed == true) {
      try {
        final result = await AdminApiService.updateStudentStatus(
          student['_id'],
        );
        if (result['success']) {
          setState(() {
            student['active'] = !student['active'];
            _filterStudents(searchController.text);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message'] ?? 'Student status updated'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          );
        } else {
          throw Exception(
              result['message'] ?? 'Failed to update student status');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFF6750A4),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        title: const Text(
          'Manage Students',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.add, color: Colors.white),
          //   onPressed: _createStudent,
          //   tooltip: 'Add Student',
          // ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              _animationController.reset();
              fetchStudents();
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFF6750A4))),
                  SizedBox(height: 16),
                  Text('Loading students...',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            )
          : errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline,
                          size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text('Error Loading Students',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700])),
                      const SizedBox(height: 8),
                      Text(errorMessage!,
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[600]),
                          textAlign: TextAlign.center),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: fetchStudents,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6750A4),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      // Header Section
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color(0xFF6750A4),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                          child: Column(
                            children: [
                              // Filter Dropdown
                              DropdownButton<String>(
                                value: filterStatus,
                                isExpanded: true,
                                items: ['All', 'Active', 'Inactive']
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,
                                        style: TextStyle(color: Colors.white)),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    filterStatus = value!;
                                    _filterStudents(searchController.text);
                                  });
                                },
                                dropdownColor: const Color(0xFF6750A4),
                                style: TextStyle(color: Colors.white),
                                icon: Icon(Icons.filter_list,
                                    color: Colors.white),
                                underline: Container(
                                  height: 2,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                              ),
                              const SizedBox(height: 16),
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
                                        offset: const Offset(0, 2))
                                  ],
                                ),
                                child: TextField(
                                  controller: searchController,
                                  onChanged: _filterStudents,
                                  decoration: InputDecoration(
                                    hintText:
                                        'Search students by name, email...',
                                    hintStyle:
                                        TextStyle(color: Colors.grey[600]),
                                    prefixIcon: Icon(Icons.search,
                                        color: Colors.grey[600]),
                                    suffixIcon: searchController.text.isNotEmpty
                                        ? IconButton(
                                            icon: const Icon(Icons.clear),
                                            onPressed: () {
                                              searchController.clear();
                                              _filterStudents('');
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
                                        horizontal: 20, vertical: 16),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Stats Row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildStatCard(
                                      'Total',
                                      allStudents.length.toString(),
                                      Icons.school_outlined,
                                      Colors.white.withOpacity(0.9)),
                                  _buildStatCard(
                                      'Active',
                                      allStudents
                                          .where((s) => s['active'] == true)
                                          .length
                                          .toString(),
                                      Icons.check_circle_outline,
                                      Colors.white.withOpacity(0.9)),
                                  _buildStatCard(
                                      'Inactive',
                                      allStudents
                                          .where((s) => s['active'] == false)
                                          .length
                                          .toString(),
                                      Icons.cancel_outlined,
                                      Colors.white.withOpacity(0.9)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Content Section
                      Expanded(
                        child: filteredStudents.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      searchQuery.isEmpty &&
                                              filterStatus == 'All'
                                          ? Icons.school_outlined
                                          : Icons.search_off,
                                      size: 64,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      searchQuery.isEmpty &&
                                              filterStatus == 'All'
                                          ? 'No Students Available'
                                          : 'No Results Found',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[700]),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      searchQuery.isEmpty &&
                                              filterStatus == 'All'
                                          ? 'There are no students to display at the moment.'
                                          : 'Try adjusting your search terms or filter.',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600]),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.all(20),
                                itemCount: filteredStudents.length,
                                itemBuilder: (context, index) {
                                  final student = filteredStudents[index];
                                  return StudentCard(
                                    student: student,
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              Studentdetailscreen(
                                            student: student,
                                            onDelete: () =>
                                                _toggleStudentActiveStatus(
                                                    student),
                                            Notification: () => null,
                                          ),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            return SlideTransition(
                                              position: animation.drive(
                                                Tween(
                                                        begin: const Offset(
                                                            1.0, 0.0),
                                                        end: Offset.zero)
                                                    .chain(CurveTween(
                                                        curve:
                                                            Curves.easeInOut)),
                                              ),
                                              child: child,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    onToggleActive: () =>
                                        _toggleStudentActiveStatus(student),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildStatCard(
      String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF6750A4), size: 20),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(value,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6750A4))),
              Text(label,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }
}

class StudentCard extends StatelessWidget {
  final dynamic student;
  final VoidCallback onTap;
  final VoidCallback onToggleActive;

  const StudentCard({
    super.key,
    required this.student,
    required this.onTap,
    required this.onToggleActive,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = student['active'] ?? true;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutBack,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive
                ? Colors.green.withOpacity(0.3)
                : Colors.red.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.08),
                spreadRadius: 0,
                blurRadius: 15,
                offset: const Offset(0, 4))
          ],
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Student Avatar
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: isActive
                            ? Colors.green.withOpacity(0.5)
                            : Colors.red.withOpacity(0.5),
                        width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: const Color(0xFF6750A4).withOpacity(0.1),
                    backgroundImage: student['image'] != null
                        ? NetworkImage(student['image'])
                        : null,
                    child: student['image'] == null
                        ? const Icon(Icons.person,
                            color: Color(0xFF6750A4), size: 28)
                        : null,
                  ),
                ),
                const SizedBox(width: 16),

                // Student Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student['name'] ?? 'Unknown Student',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isActive
                                ? Color(0xFF2A0845)
                                : Colors.grey[600]),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.email, size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              student['email'] ?? 'No email',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[700]),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Colors.blue.withOpacity(0.3)),
                            ),
                            child: Text(
                              '${student['appliedInternships']?.length ?? 0} Apps',
                              style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? Colors.green.withOpacity(0.1)
                                  : Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isActive
                                    ? Colors.green.withOpacity(0.3)
                                    : Colors.red.withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              isActive ? 'Active' : 'Inactive',
                              style: TextStyle(
                                fontSize: 10,
                                color: isActive ? Colors.green : Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Action Switch
                Switch(
                  value: isActive,
                  onChanged: (value) => onToggleActive(),
                  activeColor: const Color(0xFF6750A4),
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey[300],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
