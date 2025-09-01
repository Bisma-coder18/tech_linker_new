// services/admin_api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tech_linker_new/services/api.dart';

class AdminApiService {
  // static const String baseUrl =
  //     'http://192.168.0.104:3000'; // Replace with your actual API URL
  static const String apiPrefix = '/admin';

// Check API Health
  static Future<Map<String, dynamic>> checkHealth() async {
    try {
      final response = await http.get(
        Uri.parse('${AppKeys.baseUrl}/health'),
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'API is healthy',
          'data': response.body,
        };
      } else {
        return {
          'success': false,
          'message': 'Health check failed: ${response.statusCode}',
          'data': null,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
        'data': null,
      };
    }
  }

  // Helper method to get headers with auth token if needed
  static Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('admin_token');

    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // Admin Login
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${AppKeys.baseUrl}$apiPrefix/login'),
        headers: await _getHeaders(),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success']) {
        // Save admin data to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('admin_email', data['data']['email']);
      }

      return data;
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
        'data': null,
      };
    }
  }

// ====================

  // Get Dashboard Statistics
  static Future<Map<String, dynamic>> getDashboardStats() async {
    try {
      final response = await http.get(
        Uri.parse('${AppKeys.baseUrl}$apiPrefix/dashboard/stats'),
        headers: await _getHeaders(),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
        'data': null,
      };
    }
  }

  // Get Recent Students
  static Future<Map<String, dynamic>> getRecentStudents() async {
    try {
      final response = await http.get(
        Uri.parse('${AppKeys.baseUrl}$apiPrefix/dashboard/recent-students'),
        headers: await _getHeaders(),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
        'data': null,
      };
    }
  }

  // Get Active Internships
  static Future<Map<String, dynamic>> getActiveInternships() async {
    try {
      final response = await http.get(
        Uri.parse('${AppKeys.baseUrl}$apiPrefix/dashboard/active-internships'),
        headers: await _getHeaders(),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
        'data': null,
      };
    }
  }

  // Get Partner Institutes
  static Future<Map<String, dynamic>> getPartnerInstitutes() async {
    try {
      final response = await http.get(
        Uri.parse('${AppKeys.baseUrl}$apiPrefix/dashboard/partner-institutes'),
        headers: await _getHeaders(),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
        'data': null,
      };
    }
  }

  // Get Recent Activity
  static Future<Map<String, dynamic>> getRecentActivity() async {
    try {
      final response = await http.get(
        Uri.parse('${AppKeys.baseUrl}$apiPrefix/dashboard/recent-activity'),
        headers: await _getHeaders(),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: ${e.toString()}',
        'data': null,
      };
    }
  }

// ==============  Internships apis ==================

// create internship
  static Future<Map<String, dynamic>> createInternship({
    required Map<String, dynamic> internshipData,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${AppKeys.baseUrl}/internship/admin/add'),
        headers: await _getHeaders(),
        body: jsonEncode(internshipData),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return {
          'success': data['success'] ?? true,
          'message': data['message'] ?? 'Internship created successfully',
          'data': data['data'] ?? {},
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to create internship: ${response.statusCode}',
          'data': {},
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
        'data': {},
      };
    }
  }

// ✅ Edit Internship
  static Future<Map<String, dynamic>> editInternship({
    required String id,
    required Map<String, dynamic> updatedData,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('${AppKeys.baseUrl}/internship/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(updatedData),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': data['success'] ?? false,
          'message': data['message'] ?? '',
          'data': data['data'] ?? {},
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to update internship: ${response.statusCode}',
          'data': {},
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
        'data': {},
      };
    }
  }

// ✅ Fetch All Internships
  static Future<Map<String, dynamic>> fetchInternships() async {
    try {
      final response = await http.get(
        Uri.parse('${AppKeys.admin}/api/internship/all'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': data['success'] ?? false,
          'message': data['message'] ?? '',
          'data': data['data'] ?? [],
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to load internships',
          'data': [],
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
        'data': [],
      };
    }
  }

// Delete
  static Future<Map<String, dynamic>> deleteInternship(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('${AppKeys.baseUrl}/internship/$id'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': data['success'] ?? false,
          'message': data['message'] ?? '',
          'data': data['data'] ?? [],
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to delete internship: ${response.statusCode}',
          'data': [],
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
        'data': [],
      };
    }
  }

//====================== Institutes apis ========
// ✅ Fetch All Institutes
  static Future<Map<String, dynamic>> fetchInstitutes() async {
    try {
      final response = await http.get(
        Uri.parse('${AppKeys.admin}/api/admin/all-institutes'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': data['success'] ?? false,
          'message': data['message'] ?? '',
          'data': data['data'] ?? [],
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to load institute',
          'data': [],
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
        'data': [],
      };
    }
  }

// Delete institute
  static Future<Map<String, dynamic>> deleteInstitute(
      String instituteId) async {
    try {
      final response = await http.delete(
        Uri.parse('${AppKeys.baseUrl}/institute/$instituteId'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': data['success'] ?? true,
          'message': data['message'] ?? 'Institute deleted successfully',
          'data': data['data'] ?? null,
        };
      } else {
        final data = jsonDecode(response.body);
        return {
          'success': false,
          'message': data['message'] ??
              'Failed to delete institute: ${response.statusCode}',
          'data': null,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
        'data': null,
      };
    }
  }

//====================== Students apis ========

// ✅ Fetch All Students
  static Future<Map<String, dynamic>> fetchStudents() async {
    try {
      final response = await http.get(
        Uri.parse('${AppKeys.admin}/api/admin/all-students'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': data['success'] ?? false,
          'message': data['message'] ?? '',
          'data': data['data'] ?? [],
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to load students',
          'data': [],
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
        'data': [],
      };
    }
  }

  // Delete Student
  static Future<Map<String, dynamic>> deleteStudent(String studentId) async {
    try {
      final response = await http.delete(
        Uri.parse('${AppKeys.baseUrl}/student/$studentId'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': data['success'] ?? true,
          'message': data['message'] ?? 'Student deleted successfully',
          'data': data['data'] ?? null,
        };
      } else {
        final data = jsonDecode(response.body);
        return {
          'success': false,
          'message': data['message'] ??
              'Failed to delete student: ${response.statusCode}',
          'data': null,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
        'data': null,
      };
    }
  }
}
