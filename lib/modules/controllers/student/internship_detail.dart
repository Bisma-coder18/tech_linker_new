import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternshipDetailController extends GetxController {
  final String jobId;
  
  InternshipDetailController(this.jobId);

  var isDescriptionTab = true.obs;
  var isLoading = false.obs;
  var cvFile = Rxn<PlatformFile>();
  var isApplying = false.obs;

  void toggleTab(bool isDescription) {
    isDescriptionTab.value = isDescription;
  }
   
  Future<void> pickCV() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
        allowMultiple: false,
      );

      if (result != null) {
        cvFile.value = result.files.first;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick file: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> applyForJob() async {
    if (cvFile.value == null) {
      Get.snackbar(
        'Error',
        'Please upload your CV first',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isApplying.value = true;
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    isApplying.value = false;
    Get.back(); // Close the modal
    Get.snackbar(
      'Success',
      'Application submitted successfully!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
  void saveJob(){}
}