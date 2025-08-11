import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class InstituteProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final instituteNameController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final websiteController = TextEditingController();
  final aboutController = TextEditingController(); // For About section
  var instituteName = ''.obs;
  var address = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var website = ''.obs;
  var selectedImage = Rx<XFile?>(null); // Ensure it's Rx
  var isLoading = false.obs;

  final ImagePicker _picker = ImagePicker();

  void pickFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) selectedImage.value = image; // Update with .value
  }

  void pickFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) selectedImage.value = image; // Update with .value
  }

  void uploadRegistrationCertificate() {
    // Implement file upload logic
    print("Uploading Registration Certificate");
  }

  void uploadAccreditationCertificate() {
    // Implement file upload logic
    print("Uploading Accreditation Certificate");
  }

  void saveProfile(BuildContext context) {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        // Update observables with controller values
        instituteName.value = instituteNameController.text;
        address.value = addressController.text;
        email.value = emailController.text;
        phone.value = phoneController.text;
        website.value = websiteController.text;
        // No need to update about as it's already reactive via aboutController
        // Add save logic here (e.g., API call)
        print("Profile saved: ${instituteName.value}");
        Get.snackbar('Success', 'Profile updated successfully');
        Navigator.pop(context);
      } catch (e) {
        Get.snackbar('Error', 'Failed to save profile');
      } finally {
        isLoading.value = false;
      }
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