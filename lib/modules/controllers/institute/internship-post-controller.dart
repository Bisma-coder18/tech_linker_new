import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // For MediaType
import 'package:tech_linker_new/models/internship_model.dart';
import 'package:tech_linker_new/screens/institute/institute-main.dart';
import 'dart:convert';

import 'package:tech_linker_new/services/api.dart';
import 'package:tech_linker_new/services/local-storage.dart';

class InternshipPostController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Text Controllers
  final jobTitleController = TextEditingController();
  final salaryController = TextEditingController();
  final locationController = TextEditingController();
  final deadlineController = TextEditingController();
  final descriptionController = TextEditingController();

  // Observable Variables
  var jobTitle = ''.obs;
  var salary = ''.obs;
  var location = ''.obs;
  var deadline = ''.obs;
  var description = ''.obs;
  var jobType = 'Full Time'.obs;
  var locationType = 'Onsite'.obs;
  var jobLevel = 'Mid Level'.obs;
  var selectedImage = Rx<XFile?>(null);
  var isLoading = false.obs;

  final ImagePicker _picker = ImagePicker();

  // Pick image for job post
  void pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = image;
    }
  }

  // Post internship to API
  Future<void> postInternship(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${AppKeys.baseUrl}/internship/add'), // Change if needed
      );
      final localUser = await LocalStorage.getInsUser();

      // Map variables to API fields
      request.fields['title'] = jobTitleController.text;
      request.fields['location'] = locationController.text;
      request.fields['locationType'] = locationType.value;
      request.fields['description'] = descriptionController.text;
      request.fields['type'] = jobType.value;
      request.fields['stipend'] = salaryController.text; // using salaryController as experience
      request.fields['deadline'] = deadlineController.text;
      request.fields['joblevel'] = jobLevel.value;
      request.fields['instituteId'] = localUser!.id; // Replace with actual ID

      // Attach image with proper content type
      if (selectedImage.value != null) {
        final fileExt = selectedImage.value!.path.split('.').last.toLowerCase();
        final mimeType = (fileExt == 'png')
            ? MediaType('image', 'png')
            : (fileExt == 'webp')
                ? MediaType('image', 'webp')
                : MediaType('image', 'jpeg');

        request.files.add(await http.MultipartFile.fromPath(
          'image',
          selectedImage.value!.path,
          contentType: mimeType,
        ));
      }

      var response = await request.send();
      var responseData = await http.Response.fromStream(response);
      var jsonResponse = json.decode(responseData.body);

      if (jsonResponse['success'] == true) {
        print(jsonResponse['message']);
        Get.snackbar('Success', jsonResponse['message'] ?? 'Internship posted successfully');
        _clearForm();
      } else {
        Get.snackbar('Error', jsonResponse['message'] ?? 'Something went wrong');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to post internship: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void setDataForEdit(Internship internship) {
  jobTitleController.text = internship.title;
  salaryController.text = internship.stipend ?? "";
  locationController.text = internship.location ?? "";
  descriptionController.text = internship.description;
  deadlineController.text = internship.deadline != null
      ? internship.deadline!.toIso8601String().split("T").first
      : "";

  jobType.value = internship.jobtype.isNotEmpty ? internship.jobtype : "Full Time";
  jobLevel.value = internship.joblevel ?? "Mid Level";
  // Agar API me locationType aata hai to handle karo
  // locationType.value = internship.locationType ?? "Onsite";

  // Image API se aayi hui hai to local XFile set nahi hoga,
  // isko aap server se dikha sakte ho alag UI me.
  selectedImage.value = null; 
}


  // Clear form after success
  void _clearForm() {
    jobTitleController.clear();
    salaryController.clear();
    locationController.clear();
    deadlineController.clear();
    descriptionController.clear();
    jobType.value = 'Full Time';
    locationType.value = 'Onsite';
    jobLevel.value = 'Mid Level';
    selectedImage.value = null;
    update();

  }

  @override
  void onClose() {
    jobTitleController.dispose();
    salaryController.dispose();
    locationController.dispose();
    deadlineController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
