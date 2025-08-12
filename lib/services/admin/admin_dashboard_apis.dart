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

// ✅ Fetch All Internships
  static Future<Map<String, dynamic>> fetchInternships() async {
    try {
      final response = await http.get(
        Uri.parse('${AppKeys.baseUrl}/api/internship'),
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

// ✅ Fetch All Internships
  static Future<Map<String, dynamic>> fetchInstitutes() async {
    try {
      final response = await http.get(
        Uri.parse('${AppKeys.baseUrl}/api/admin/all-institutes'),
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

// ✅ Fetch All Internships
  static Future<Map<String, dynamic>> fetchStudents() async {
    try {
      final response = await http.get(
        Uri.parse('${AppKeys.baseUrl}/api/admin/all-students'),
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
}
