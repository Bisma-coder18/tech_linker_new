import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
  var jobType = 'Full Time'.obs; // Default value
  var locationType = 'Onsite'.obs; // Default value
  var jobLevel = 'Mid Level'.obs; // Default value
  var selectedImage = Rx<XFile?>(null); // For job image
  var isLoading = false.obs;

  final ImagePicker _picker = ImagePicker();

  // Pick image for job post
  void pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = image; // Update reactive image
    }
  }

  // Post internship
  void postInternship(BuildContext context) {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        // Update observables with controller values
        jobTitle.value = jobTitleController.text;
        salary.value = salaryController.text;
        location.value = locationController.text;
        deadline.value = deadlineController.text;
        description.value = descriptionController.text;

        // Simulate API call or save logic
        print("Internship Posted:");
        print("Title: ${jobTitle.value}");
        print("Salary: ${salary.value}");
        print("Location: ${location.value}");
        print("Deadline: ${deadline.value}");
        print("Description: ${description.value}");
        print("Job Type: ${jobType.value}");
        print("Location Type: ${locationType.value}");
        print("Job Level: ${jobLevel.value}");
        print("Image: ${selectedImage.value?.path}");

        Get.snackbar('Success', 'Internship posted successfully');
        _clearForm();
        Get.back();
      } catch (e) {
        Get.snackbar('Error', 'Failed to post internship');
      } finally {
        isLoading.value = false;
      }
    }
  }

  // Clear form after successful post
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