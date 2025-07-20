import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<String> fetchMessage() async {
    final url = Uri.parse('http://10.0.2.2:3000/message'); //  Correct route
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      return jsonBody['message'] ?? 'No message';
    } else {
      throw Exception('Failed to load message');
    }
  }
}

