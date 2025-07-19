import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:3000'; // Android emulator

  static Future<String> getBackendMessage() async {
    final uri = Uri.parse('$baseUrl/');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('❌ Failed to connect: ${response.statusCode}');
    }
  }
}
