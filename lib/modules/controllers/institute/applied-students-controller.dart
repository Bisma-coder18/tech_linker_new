import 'package:get/get.dart';
import 'package:tech_linker_new/models/institute-model.dart';
import 'package:tech_linker_new/models/aaplied-users.dart';
import 'package:tech_linker_new/services/api.dart';
import 'package:tech_linker_new/services/local-storage.dart';

class AppliedUsersController extends GetxController {
  var isLoading = false.obs;
  var internships = <Internship>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAppliedUsers();
  }

  Future<void> fetchAppliedUsers() async {
    try {
      isLoading.value = true;
      final InstituteModel? userdetails=await LocalStorage.getInsUser();
      final response = await GetConnect().get(
        "${AppKeys.baseUrl}/nternship/institute/${userdetails!.id}",
      );

      if (response.statusCode == 200 && response.body['success'] == true) {
        final data = response.body['data'] ?? {};
        final list = data['internships'] ?? [];

        internships.assignAll(
          (list as List).map((i) => Internship.fromJson(i)).toList(),
        );
      } else {
        internships.clear();
      }
    } catch (e) {
      internships.clear();
      print("Error fetching internships: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
