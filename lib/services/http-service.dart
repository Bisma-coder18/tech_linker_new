import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tech_linker_new/models/api-model.dart';
import 'package:tech_linker_new/services/api.dart';

class HttpService {
  // Replace with your actual API URL

  // Common headers for all requests
  static Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  // POST request helper
  static Future<ApiResponse> post(
      String endpoint, Map<String, dynamic> data) async {
    try {
      print('📤 POST: ${AppKeys.baseUrl}$endpoint');
      print('📤 Data: $data');

      final response = await http.post(
        Uri.parse('${AppKeys.baseUrl}$endpoint'),
        headers: _headers,
        body: jsonEncode(data),
      );

      print('📥 Response: ${response.statusCode}');
      print('📥 Body: ${response.body}');

      return _handleResponse(response);
    } catch (e) {
      print('❌ Network Error: $e');
      return ApiResponse(
        success: false,
        statusCode: 500,
        message: 'Network error. Please check your internet connection.',
      );
    }
  }

  static Future<ApiResponse> put(
      String endpoint, Map<String, dynamic> data) async {
    try {
      print('📤 POST: ${AppKeys.baseUrl}$endpoint');
      print('📤 Data: $data');

      final response = await http.put(
        Uri.parse('${AppKeys.baseUrl}$endpoint'),
        headers: _headers,
        body: jsonEncode(data),
      );

      print('📥 Response: ${response.statusCode}');
      print('📥 Body: ${response.body}');

      return _handleResponse(response);
    } catch (e) {
      print('❌ Network Error: $e');
      return ApiResponse(
        success: false,
        statusCode: 500,
        message: 'Network error. Please check your internet connection.',
      );
    }
  }

  // GET request helper (for future use)
  static Future<ApiResponse> get(String endpoint, {String? token}) async {
    try {
      final headers = Map<String, String>.from(_headers);
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      final response = await http.get(
        Uri.parse('${AppKeys.baseUrl}$endpoint'),
        headers: headers,
      );

      return _handleResponse(response);
    } catch (e) {
      return ApiResponse(
        success: false,
        statusCode: 500,
        message: 'Network error. Please check your internet connection.',
      );
    }
  }

  // Handle API response
  static ApiResponse _handleResponse(http.Response response) {
    try {
      final jsonData = jsonDecode(response.body);

      // Success responses (200-299)
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponse.fromJson(jsonData);
      }

      // Error responses
      return ApiResponse(
        statusCode: response.statusCode,
        success: false,
        message: jsonData['message'] ?? 'Something went wrong',
        data: jsonData,
      );
    } catch (e) {
      return ApiResponse(
        success: false,
        statusCode: response.statusCode,
        message: 'Invalid response from server',
      );
    }
  }

  static Future<ApiResponse> postMultipart(
      String url, Map<String, dynamic> body) async {
    try {
      var request = http.MultipartRequest('PUT', Uri.parse(url));

      body.forEach((key, value) async {
        if (value is File) {
          request.files.add(await http.MultipartFile.fromPath(key, value.path));
        } else if (value != null) {
          request.fields[key] = value.toString();
        }
      });

      var streamedResponse = await request.send();
      var respStr = await streamedResponse.stream.bytesToString();
      var jsonResp = jsonDecode(respStr);

      return ApiResponse(
        success: streamedResponse.statusCode >= 200 &&
            streamedResponse.statusCode < 300,
        message: jsonResp['message'] ?? 'Request completed',
        statusCode: streamedResponse.statusCode,
        data: jsonResp,
      );
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Network error: $e',
        statusCode: 0,
        data: null,
      );
    }
  }
}
