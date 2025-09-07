import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tech_linker_new/screens/admin/AdminInstituteDetailScreeen.dart';
import 'package:tech_linker_new/services/admin/admin_dashboard_apis.dart';
import 'package:tech_linker_new/services/api.dart';

class Manageinstitute extends StatefulWidget {
  const Manageinstitute({super.key});

  @override
  State<Manageinstitute> createState() => _ManageinstituteState();
}

class _ManageinstituteState extends State<Manageinstitute>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  List<dynamic> allInstitutes = [];
  List<dynamic> filteredInstitutes = [];
  bool isLoading = true;
  String? errorMessage;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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
    fetchInstitutes();
  }

  @override
  void dispose() {
    _animationController.dispose();
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchInstitutes() async {
    setState(() => isLoading = true);

    final result = await AdminApiService.fetchInstitutes();

    if (result['success']) {
      setState(() {
        allInstitutes = result['data'];
        filteredInstitutes = allInstitutes;
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

  void _filterInstitutes(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
      filteredInstitutes = allInstitutes
          .where((institute) =>
              institute['name']?.toLowerCase().contains(searchQuery) ||
              institute['email']?.toLowerCase().contains(searchQuery) ||
              institute['location']?.toLowerCase().contains(searchQuery))
          .toList();
    });
  }

  Future<void> _createInstitute() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateEditInstituteScreen(),
      ),
    );

    if (result == true) {
      fetchInstitutes();
    }
  }

  Future<void> _editInstitute(dynamic institute) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateEditInstituteScreen(institute: institute),
      ),
    );

    if (result == true) {
      fetchInstitutes();
    }
  }

  Future<void> _deleteInstitute(dynamic institute) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 28),
              SizedBox(width: 12),
              Text('Confirm Delete',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          content: Text(
            'Are you sure you want to delete "${institute['name']}"?\n\nThis action cannot be undone.',
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      try {
        final result = await AdminApiService.deleteInstitute(institute['_id']);
        if (result['success']) {
          setState(() {
            allInstitutes.remove(institute);
            _filterInstitutes(searchController.text);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text(result['message'] ?? 'Institute deleted successfully'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          );
        } else {
          throw Exception(result['message'] ?? 'Failed to delete institute');
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
          'Manage Institutes',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.add, color: Colors.white),
          //   onPressed: _createInstitute,
          //   tooltip: 'Add Institute',
          // ),
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
                  Text('Loading institutes...',
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
                      Text('Error Loading Institutes',
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
                        onPressed: fetchInstitutes,
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
                                  onChanged: _filterInstitutes,
                                  decoration: InputDecoration(
                                    hintText:
                                        'Search institutes by name, email, location...',
                                    hintStyle:
                                        TextStyle(color: Colors.grey[600]),
                                    prefixIcon: Icon(Icons.search,
                                        color: Colors.grey[600]),
                                    suffixIcon: searchController.text.isNotEmpty
                                        ? IconButton(
                                            icon: const Icon(Icons.clear),
                                            onPressed: () {
                                              searchController.clear();
                                              _filterInstitutes('');
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
                                      allInstitutes.length.toString(),
                                      Icons.business_outlined,
                                      Colors.white.withOpacity(0.9)),
                                  _buildStatCard(
                                      'Showing',
                                      filteredInstitutes.length.toString(),
                                      Icons.visibility_outlined,
                                      Colors.white.withOpacity(0.9)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Content Section
                      Expanded(
                        child: filteredInstitutes.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      searchQuery.isEmpty
                                          ? Icons.business_outlined
                                          : Icons.search_off,
                                      size: 64,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      searchQuery.isEmpty
                                          ? 'No Institutes Available'
                                          : 'No Results Found',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey[700]),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      searchQuery.isEmpty
                                          ? 'There are no institutes to display at the moment.'
                                          : 'Try adjusting your search terms.',
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
                                itemCount: filteredInstitutes.length,
                                itemBuilder: (context, index) {
                                  final institute = filteredInstitutes[index];
                                  return InstituteCard(
                                    institute: institute,
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              Institutedetailscreeen(
                                            institute: institute,
                                            onDelete: () =>
                                                _deleteInstitute(institute),
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
                                    // onEdit: () => _editInstitute(institute),
                                    onDelete: () => _deleteInstitute(institute),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: const Color(0xFF6750A4),
      //   onPressed: _createInstitute,
      //   child: const Icon(Icons.add, color: Colors.white),
      // ),
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

class InstituteCard extends StatelessWidget {
  final dynamic institute;
  final VoidCallback onTap;
  // final VoidCallback onEdit;
  final VoidCallback onDelete;

  const InstituteCard({
    super.key,
    required this.institute,
    required this.onTap,
    // required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutBack,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Institute Avatar
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: const Color(0xFF6750A4).withOpacity(0.2),
                        width: 2),
                  ),
                  child: const CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xFF6750A4),
                    child: Icon(Icons.business, color: Colors.white, size: 28),
                  ),
                ),
                const SizedBox(width: 16),

                // Institute Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        institute['name'] ?? 'Unknown Institute',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2A0845)),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.email, size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              institute['email'] ?? 'No email',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[700]),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on,
                              size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              institute['location'] ?? 'Unknown Location',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[600]),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6750A4).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: const Color(0xFF6750A4).withOpacity(0.3)),
                        ),
                        child: Text(
                          '${institute['internshipsCount'] ?? 0} Internships',
                          style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF6750A4),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),

                // Action Buttons
                Column(
                  children: [
                    // IconButton(
                    //   icon:
                    //       const Icon(Icons.edit, color: Colors.blue, size: 20),
                    //   onPressed: onEdit,
                    //   tooltip: 'Edit Institute',
                    // ),
                    IconButton(
                      icon:
                          const Icon(Icons.delete, color: Colors.red, size: 20),
                      onPressed: onDelete,
                      tooltip: 'Delete Institute',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Create/Edit Institute Screen
class CreateEditInstituteScreen extends StatefulWidget {
  final dynamic institute;

  const CreateEditInstituteScreen({super.key, this.institute});

  @override
  State<CreateEditInstituteScreen> createState() =>
      _CreateEditInstituteScreenState();
}

class _CreateEditInstituteScreenState extends State<CreateEditInstituteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _locationController = TextEditingController();
  final _phoneController = TextEditingController();
  final _websiteController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isLoading = false;
  bool get isEditing => widget.institute != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      _nameController.text = widget.institute['name'] ?? '';
      _emailController.text = widget.institute['email'] ?? '';
      _locationController.text = widget.institute['location'] ?? '';
      _phoneController.text = widget.institute['phone'] ?? '';
      _websiteController.text = widget.institute['website'] ?? '';
      _descriptionController.text = widget.institute['description'] ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    _phoneController.dispose();
    _websiteController.dispose();
    _descriptionController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _saveInstitute() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final data = {
        'name': _nameController.text,
        'email': _emailController.text,
        'location': _locationController.text,
        'phone': _phoneController.text,
        'website': _websiteController.text,
        'description': _descriptionController.text,
        if (!isEditing && _passwordController.text.isNotEmpty)
          'password': _passwordController.text,
      };

      http.Response response;

      if (isEditing) {
        response = await http.put(
          Uri.parse('${AppKeys.baseUrl}/institutes/${widget.institute['_id']}'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(data),
        );
      } else {
        response = await http.post(
          Uri.parse('${AppKeys.baseUrl}/institutes'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(data),
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Institute ${isEditing ? 'updated' : 'created'} successfully'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true);
      } else {
        throw Exception(
            'Failed to ${isEditing ? 'update' : 'create'} institute');
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
          isEditing ? 'Edit Institute' : 'Create Institute',
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
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Institute Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.business),
              ),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Institute name is required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value?.isEmpty ?? true) return 'Email is required';
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}')
                    .hasMatch(value!)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Location/Address',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Location is required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _websiteController,
              decoration: const InputDecoration(
                labelText: 'Website URL',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.web),
              ),
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 16),
            if (!isEditing)
              Column(
                children: [
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    validator: isEditing
                        ? null
                        : (value) => value?.isEmpty ?? true
                            ? 'Password is required'
                            : null,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: isLoading ? null : _saveInstitute,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6750A4),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(isEditing ? 'Update Institute' : 'Create Institute'),
            ),
          ],
        ),
      ),
    );
  }
}
