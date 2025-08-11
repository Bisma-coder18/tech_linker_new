import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_linker_new/util/util.dart';

class PersonalProfileController extends GetxController {
  final nameController = TextEditingController(text: "John Doe");
  final emailController = TextEditingController(text: "john.doe@email.com");
  final phoneController = TextEditingController(text: "+1 234 567 8900");
  final universityController = TextEditingController(text: "MIT University");
  final majorController = TextEditingController(text: "Computer Science");
  final yearController = TextEditingController(text: "3rd Year");
  final gpaController = TextEditingController(text: "3.8");
  final locationController = TextEditingController(text: "New York, USA");
  final bioController = TextEditingController(text: "Passionate computer science student...");
  final linkedinController = TextEditingController(text: "linkedin.com/in/johndoe");
  final githubController = TextEditingController(text: "github.com/johndoe");
  final portfolioController = TextEditingController(text: "johndoe.dev");
  final textController = TextEditingController(text: "johndoe.dev");
  Rx<File?> selectedImage = Rx<File?>(null);
  RxList<String> skills = ["Flutter", "React", "Python"].obs;
  RxList<String> interests = ["AI/ML", "Mobile Dev", "Web Dev"].obs;

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
