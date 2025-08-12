import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_linker_new/models/student.dart';
import 'package:tech_linker_new/services/local-storage.dart';
import 'package:tech_linker_new/util/util.dart';

class PersonalProfileController extends GetxController {
  final nameController = TextEditingController(text: "");
  final emailController = TextEditingController(text: "");
  final phoneController = TextEditingController(text: "");
  final universityController = TextEditingController(text: "");
  final majorController = TextEditingController(text: "");
  final yearController = TextEditingController(text: "");
  final gpaController = TextEditingController(text: "");
  final locationController = TextEditingController(text: "");
  final bioController = TextEditingController(text: "");
  final linkedinController = TextEditingController(text: "");
  final githubController = TextEditingController(text: "");
  final portfolioController = TextEditingController(text: "");
  final textController = TextEditingController(text: "");
  Rx<File?> selectedImage = Rx<File?>(null);
  RxList<String> skills = [""].obs;
  RxList<String> interests = [""].obs;

  final formKey = GlobalKey<FormState>();

  // Validation
  bool validateAndSave() {
    return formKey.currentState?.validate() ?? false;
  }

  // Add/remove Skills
  void addSkill(String skill) {
    if (skill.isNotEmpty) skills.add(skill);
  }

  void removeSkill(String skill) {
    skills.remove(skill);
  }

  // Add/remove Interests
  void addInterest(String interest) {
    if (interest.isNotEmpty) interests.add(interest);
  }

  void removeInterest(String interest) {
    interests.remove(interest);
  }

  // Save profile
  void saveProfile(BuildContext context) {
    if (validateAndSave()) {
      Get.snackbar("Success", "Profile saved successfully!",
          backgroundColor: Colors.green.shade100,
          colorText: Colors.black,
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar("Error", "Please complete all required fields.",
          backgroundColor: Colors.red.shade100,
          colorText: Colors.black,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void uploadResume(){
    
  }

   @override
  void onInit() {
    super.onInit();
    loadUserFromStorage();
  }

  Future<void> loadUserFromStorage() async {
    try {
      User? user = await LocalStorage.getUser();
      if (user != null) {
        nameController.text = user.name ?? '';
        emailController.text = user.email ?? '';
        phoneController.text=user.phone??"";
        locationController.text=user.location??"";
        bioController.text=user.bio??"";
update();
        // set other controllers if you want like phone, university, etc.
      }
    } catch (e) {
      print('Error loading user from storage: $e');
    }
  }

  // Show skill input dialog
  void showAddSkillDialog(BuildContext context) {
    final skillController = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Skill"),
        content: TextField(
          controller: skillController,
          decoration: const InputDecoration(hintText: "Enter skill"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              addSkill(skillController.text.trim());
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  // Show interest input dialog
  void showAddInterestDialog(BuildContext context) {
    final interestController = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Interest"),
        content: TextField(
          controller: interestController,
          decoration: const InputDecoration(hintText: "Enter interest"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              addInterest(interestController.text.trim());
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }


   void pickFromCamera() async {
    File? image = await Util.openCamera();
    if (image != null) {
      selectedImage.value = image;
    }
  }

  void pickFromGallery() async {
    File? image = await Util.openGallery();
    if (image != null) {
      selectedImage.value = image;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    universityController.dispose();
    majorController.dispose();
    yearController.dispose();
    gpaController.dispose();
    locationController.dispose();
    bioController.dispose();
    linkedinController.dispose();
    githubController.dispose();
    portfolioController.dispose();
    super.onClose();
  }
}
