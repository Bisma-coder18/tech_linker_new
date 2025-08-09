import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<String> fetchMessage() async {
    final url = Uri.parse('http://192.168.1.18:3000/message'); //  for emulator
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

