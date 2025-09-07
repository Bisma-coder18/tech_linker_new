import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_linker_new/models/institute-model.dart';
import 'package:tech_linker_new/services/api.dart';
import 'package:tech_linker_new/services/apis/institute/institute-apis.dart';
import 'package:tech_linker_new/services/http-service.dart';
import 'package:tech_linker_new/services/local-storage.dart';

class InstituteProfileController extends GetxController {
  InstituteApiService instituteApi = InstituteApiService();
  final formKey = GlobalKey<FormState>();

  final instituteNameController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final websiteController = TextEditingController();
  final aboutController = TextEditingController();

  var selectedImage = Rx<XFile?>(null);
  var isLoading = false.obs;
  final ImagePicker _picker = ImagePicker();

  Rxn<InstituteModel> profile = Rxn<InstituteModel>();

  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
  }

  Future<void> fetchProfileData({bool forceRefresh = false}) async {
    isLoading.value = true;
    try {
      final localUser = await LocalStorage.getInsUser();
      if (localUser == null || localUser.id == null) {
        Get.snackbar("Error", "No saved institute found");
        Get.offNamed('/login');
        isLoading.value = false;
        return;
      }

      // Use local data unless forceRefresh is true
      if (!forceRefresh) {
        instituteNameController.text = localUser.name ?? '';
        addressController.text = localUser.address ?? '';
        emailController.text = localUser.email ?? '';
        phoneController.text = localUser.phone ?? '';
        websiteController.text = localUser.website ?? '';
        aboutController.text = localUser.about ?? '';
        profile.value = localUser;
        isLoading.value = false;
        return;
      }

      // Fetch latest profile from API
      final resp = await instituteApi.getProfileById(id: localUser.id!);
      if (resp.success && resp.data != null) {
        profile.value = resp.data;
        instituteNameController.text = resp.data!.name ?? '';
        addressController.text = resp.data!.address ?? '';
        emailController.text = resp.data!.email ?? '';
        phoneController.text = resp.data!.phone ?? '';
        websiteController.text = resp.data!.website ?? '';
        aboutController.text = resp.data!.about ?? '';

        if (resp.data!.image != null && resp.data!.image!.isNotEmpty) {
          profile.value = resp.data; // Store image URL
        }

        // Update local storage
        await LocalStorage.saveInstUser(resp.data!);
      } else {
        Get.snackbar("Error", resp.message);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// 📌 Load user from LocalStorage and fetch latest from API
  // Future<void> fetchProfileData() async {
  //   isLoading.value = true;
  //   try {
  //     // 1️⃣ Get saved institute from local storage
  //     final localUser = await LocalStorage.getInsUser();
  //     print('========================================');
  //     print(localUser?.name);
  //     print('========================================');
  //     if (localUser == null || localUser.id == null) {
  //       Get.snackbar("Error", "No saved institute found");
  //       isLoading.value = false;
  //       return;
  //     }
  //     instituteNameController.text = localUser.name ?? '';
  //     addressController.text = localUser.address ?? '';
  //     emailController.text = localUser.email ?? '';
  //     phoneController.text = localUser.phone ?? '';
  //     websiteController.text = localUser.website ?? '';
  //     aboutController.text = localUser.about ?? '';
  //     return;

  //     // 2️⃣ Fetch latest profile from API
  //     // final resp = await instituteApi.getProfileById(id: localUser.id!);
  //     // if (resp.success && resp.data != null) {
  //     //   profile.value = resp.data;
  //     //   print(resp.data);
  //     //   print(",llsllsl");
  //     //   // 3️⃣ Fill controllers
  //     //   instituteNameController.text = resp.data!.name ?? '';
  //     //   addressController.text = resp.data!.address ?? '';
  //     //   emailController.text = resp.data!.email ?? '';
  //     //   phoneController.text = resp.data!.phone ?? '';
  //     //   websiteController.text = resp.data!.website ?? '';
  //     //   aboutController.text = resp.data!.about ?? '';

  //     //   // 4️⃣ Set image if exists
  //     //   if (resp.data!.image != null && resp.data!.image!.isNotEmpty) {
  //     //     // Here we keep URL as string, actual file will be picked later if updated
  //     //     selectedImage.value = XFile(resp.data!.image!);
  //     //   }
  //     // } else {
  //     //   Get.snackbar("Error", resp.message);
  //     // }
  //   } catch (e) {
  //     Get.snackbar("Error", e.toString());
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  /// 📌 Pick from camera
  void pickFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) selectedImage.value = image;
  }

  /// 📌 Pick from gallery
  void pickFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) selectedImage.value = image;
  }

  Future<void> saveProfile(BuildContext context) async {
    final localUser = await LocalStorage.getInsUser();

    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      final url = "${AppKeys.updateUser}${localUser!.id}";
      print("📡 API URL: $url");

      // Use a regular POST request instead of MultipartRequest since no image is supported
      final body = {
        'name': instituteNameController.text.trim(),
        'address': addressController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'website': websiteController.text.trim(),
        'about': aboutController.text.trim(),
      };

      final response =
          await HttpService.put(url, body); // Use a custom put method

      print("📬 Response Status Code: ${response.statusCode}");
      print("📨 Response Body: ${response.data}");

      if (response.success && response.data != null) {
        // Parse the updated institute data
        final updatedInstitute = InstituteModel.fromJson(response.data);
        // profile.value = response.data; // Update reactive profile
        await LocalStorage.saveInstUser(
            updatedInstitute); // Update local storage

        // Update text controllers to reflect the latest data
        instituteNameController.text = updatedInstitute.name ?? '';
        addressController.text = updatedInstitute.address ?? '';
        emailController.text = updatedInstitute.email ?? '';
        phoneController.text = updatedInstitute.phone ?? '';
        websiteController.text = updatedInstitute.website ?? '';
        aboutController.text = updatedInstitute.about ?? '';

        Get.snackbar("Success", "Profile updated successfully");
        Navigator.pop(context);
      } else {
        Get.snackbar("Error", response.message ?? "Failed to update profile");
      }
    } catch (e, stack) {
      print("❌ Exception: $e");
      print("📌 Stack Trace: $stack");
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    instituteNameController.dispose();
    addressController.dispose();
    emailController.dispose();
    phoneController.dispose();
    websiteController.dispose();
    aboutController.dispose();
    super.onClose();
  }
}
