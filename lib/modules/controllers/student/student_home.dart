import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tech_linker_new/services/api.dart';
import 'package:tech_linker_new/services/local-storage.dart';

class StudentHomeController extends GetxController {
  var isLoading = false.obs;
  var internships = [].obs;

  Future<void> fetchInternships() async {
    try {
      final localUser = await LocalStorage.getInsUser();

      isLoading.value = true;
      final url = Uri.parse("${AppKeys.baseUrl}/internship/"); // Use your PC IP instead of localhost

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["success"] == true) {
          internships.value = data["data"] ?? [];
        } else {
          internships.clear();
        }
      } else {
        internships.clear();
      }
    } catch (e) {
      internships.clear();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    fetchInternships();
    super.onInit();
  }
}
