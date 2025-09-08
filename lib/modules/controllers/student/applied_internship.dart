import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tech_linker_new/services/api.dart';
import 'package:tech_linker_new/services/local-storage.dart';

class AppliedStudentController extends GetxController {
  var isLoading = false.obs;
  var internships = [].obs;

  Future<void> fetchAppliedInternships() async {
    try {
      final localUser = await LocalStorage.getUser();
print("-----======-----ww");
// http://localhost:3000/api/internship/student/68bd9e7766d3c1003243a2e3/applied-internships
      isLoading.value = true;
      final url = Uri.parse(
          "${AppKeys.baseUrl}/internship/student/${localUser!.id}/applied-internships"); // Use your PC IP instead of localhost
print(url);
      final response = await http.get(url);
print(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
       print(data["internships"]);
       print("...");
         internships.value = data["internships"]?? [];
      } else {
        print(response.body);
        internships.clear();
      }
    } catch (e) {
      print(e);
      internships.clear();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    fetchAppliedInternships();
    super.onInit();
  }
}
