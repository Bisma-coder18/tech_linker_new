import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';import 'package:image_picker/image_picker.dart';
import 'package:tech_linker_new/models/institute-model.dart';
import 'package:tech_linker_new/services/api.dart';
import 'package:tech_linker_new/services/apis/institute/institute-apis.dart';
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

  /// 📌 Load user from LocalStorage and fetch latest from API
  Future<void> fetchProfileData() async {
    isLoading.value = true;
    try {
      // 1️⃣ Get saved institute from local storage
      final localUser = await LocalStorage.getInsUser();
       
      if (localUser == null || localUser.id == null) {
        Get.snackbar("Error", "No saved institute found");
        isLoading.value = false;
        return;
      }
       instituteNameController.text = localUser.name ?? '';
        addressController.text =localUser.address ?? '';
        emailController.text = localUser.email ?? '';
        phoneController.text = localUser.phone ?? '';
        websiteController.text = localUser.website ?? '';
        aboutController.text = localUser.about ?? '';
        return;
      // 2️⃣ Fetch latest profile from API
      final resp = await instituteApi.getProfileById(id: localUser.id!);
      if (resp.success && resp.data != null) {
        profile.value = resp.data;
  print(resp.data);
  print(",llsllsl");
        // 3️⃣ Fill controllers
        instituteNameController.text = resp.data!.name ?? '';
        addressController.text = resp.data!.address ?? '';
        emailController.text = resp.data!.email ?? '';
        phoneController.text = resp.data!.phone ?? '';
        websiteController.text = resp.data!.website ?? '';
        aboutController.text = resp.data!.about ?? '';

        // 4️⃣ Set image if exists
        if (resp.data!.image != null && resp.data!.image!.isNotEmpty) {
          // Here we keep URL as string, actual file will be picked later if updated
          selectedImage.value = XFile(resp.data!.image!);
        }
      } else {
        Get.snackbar("Error", resp.message);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

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
    final url = "${AppKeys.baseUrl}${AppKeys.updateUser}${localUser!.id}";
    print("📡 API URL: $url");

    var request = http.MultipartRequest('PUT', Uri.parse(url));

    // Add text fields
    request.fields['name'] = instituteNameController.text.trim();
    request.fields['address'] = addressController.text.trim();
    request.fields['email'] = emailController.text.trim();
    request.fields['phone'] = phoneController.text.trim();
    request.fields['website'] = websiteController.text.trim();
    request.fields['about'] = aboutController.text.trim();

    print("📦 Request Fields: ${request.fields}");

    // Add image if selected
    if (selectedImage.value != null &&
        File(selectedImage.value!.path).existsSync()) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        selectedImage.value!.path,
      ));
      print("🖼 Image Path: ${selectedImage.value!.path}");
    } else {
      print("⚠️ No image selected or file doesn't exist");
    }

    // Send request
    var response = await request.send();

    // Read response
    var responseBody = await response.stream.bytesToString();

    print("📬 Response Status Code: ${response.statusCode}");
    print("📨 Response Body: $responseBody");

    if (response.statusCode >= 200 && response.statusCode < 300) {
      Get.snackbar("Success", "Profile updated successfully");
      Navigator.pop(context);
    } else {
      Get.snackbar("Error", "Failed to update profile");
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
