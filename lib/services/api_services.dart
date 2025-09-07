import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tech_linker_new/services/api.dart';

class ApiService {
  static Future<String> fetchMessage() async {
    final url = Uri.parse('${AppKeys.admin}/message'); //  for emulator
    // final url = Uri.parse('http://192.168.9.104/message'); //  for real device
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return jsonBody['message'] ?? 'No message';
    } else {
      throw Exception('Failed to load message');
    }
  }
}

class HealthService {
  static Future<String> checkHealth() async {
    try {
      final response = await http.get(Uri.parse('${AppKeys.appUrl}/health'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        return "Health Check Success: ${data}";
      } else {
        return "Health Check Failed: Status Code ${response.statusCode}";
      }
    } catch (e) {
      return "Health Check Error: $e";
    }
  }
}
