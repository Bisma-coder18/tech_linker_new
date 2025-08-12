import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tech_linker_new/models/student.dart';
import 'package:tech_linker_new/services/api.dart';
import 'package:tech_linker_new/services/local-storage.dart';

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

  Future<void> applyForJob(String jobxId) async {
  isApplying.value = true;
  try {
   final User? users=await LocalStorage.getUser();
    final uri = Uri.parse('${AppKeys.baseUrl}/internship/apply/${users!.id}/${jobxId}');

    // Prepare the form data
    final body = {
      'studentId': users!.id,
      'internshipId': jobxId,
    };

    final response = await http.post(uri,);
if (response.statusCode == 200 || response.statusCode == 201) {
  Get.back(); // Close modal if any
  Get.snackbar(
    'Success',
    'Application submitted successfully!',
    snackPosition: SnackPosition.BOTTOM,
  );
} else if (response.statusCode == 400) {
  try{
 final data = jsonDecode(response.body);
  Get.snackbar(
    'Failure',
    data["message"] ?? 'Unknown error',
    snackPosition: SnackPosition.BOTTOM,
  );
  }catch(e){
    print(e);
  }
 
} else {
  Get.snackbar(
    'Error',
    'Failed to submit application.',
    snackPosition: SnackPosition.BOTTOM,
  );
}
  } catch (e) {
    Get.snackbar(
      'Error',
      'Error submitting application: ${e.toString()}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  } finally {
    isApplying.value = false;
  }
}

   
  
  void saveJob(){}
}