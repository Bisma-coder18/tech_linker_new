import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_linker_new/modules/controllers/institute/institute-controller.dart';
import 'package:tech_linker_new/theme/app_colors.dart';
import 'package:tech_linker_new/theme/app_text_styles.dart';
import 'package:tech_linker_new/widget/cached_img.dart';
import 'package:tech_linker_new/widget/custom-text-feild.dart';

class InstituteProfileScreen extends StatelessWidget {
  InstituteProfileScreen({super.key});
  final InstituteProfileController controller = Get.put(InstituteProfileController());

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.grey[50],
    appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.black87),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Institute Profile",
        style: AppTextStyles.darkH4_500,
      ),
      centerTitle: true,
      actions: [
        TextButton(
          onPressed: () {
            controller.saveProfile(context);
          },
          child: Text(
            "Save",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
    body: Stack(
      children: [
        // Your existing body
        SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // _changeProfilePicture(context),
                const SizedBox(height: 20),
                _buildBasicInfoSection(),
                _buildContactSection(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),

        // Loader overlay
        Obx(() {
          if (controller.isLoading.value) {
            return Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    ),
  );
}

  Widget _buildBasicInfoSection() {
    return _buildSection(
      title: "Basic Information",
      children: [
        _buildTextField(
          "Institute Name",
          controller.instituteNameController,
          Icons.business,
        ),
       _buildTextField(
          "Address",
          controller.addressController,
          Icons.location_on,
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _buildContactSection() {
    return _buildSection(
      title: "Contact Information",
      children: [
        _buildTextField(
          "Email",
          controller.emailController,
          Icons.email,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) return 'Please enter email';
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value))
              return 'Please enter a valid email';
            return null;
          },
        ),
        _buildTextField(
          "Phone Number",
          controller.phoneController,
          Icons.phone,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) return 'Please enter phone number';
            if (!RegExp(r'^\d+$').hasMatch(value))
              return 'Phone number must contain only numbers';
            if (value.length < 10) return 'Phone number must be at least 10 digits';
            return null;
          },
        ),
        _buildTextField(
          "Website",
          controller.websiteController,
          Icons.language,
          keyboardType: TextInputType.url,
        ),
         _buildTextField(
          "About",
          controller.aboutController,
          Icons.info,
        ),
      ],
    );
  }

  // Widget _buildDocumentsSection() {
  //   return _buildSection(
  //     title: "Documents",
  //     children: [
  //       _buildDocumentTile(
  //         title: "Registration Certificate",
  //         subtitle: "Upload institute registration",
  //         icon: Icons.verified_user_outlined,
  //         onTap: controller.uploadRegistrationCertificate,
  //         hasFile: true,
  //         fileName: "Registration_Cert.pdf",
  //       ),
  //       const SizedBox(height: 12),
  //       _buildDocumentTile(
  //         title: "Accreditation Certificate",
  //         subtitle: "Upload accreditation proof",
  //         icon: Icons.badge_outlined,
  //         onTap: controller.uploadAccreditationCertificate,
  //         hasFile: false,
  //       ),
  //     ],
  //   );
  // }

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.darkH4_500.copyWith(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: CustomTextField(
        label: label,
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator ?? (value) {
          if (value == null || value.isEmpty) return 'Please enter $label';
          return null;
        },
      ),
    );
  }

  Widget _buildDocumentTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    bool hasFile = false,
    String? fileName,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: hasFile
                ? Colors.green.withOpacity(0.1)
                : AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: hasFile ? Colors.green : AppColors.primary,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(hasFile ? fileName! : subtitle),
        trailing: Icon(
          hasFile ? Icons.check_circle : Icons.upload_file,
          color: hasFile ? Colors.green : AppColors.primary,
        ),
        onTap: onTap,
      ),
    );
  }

  void _changeProfilePicture(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Take Photo"),
              onTap: () {
                controller.pickFromCamera();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Choose from Gallery"),
              onTap: () {
                Navigator.pop(context);
                controller.pickFromGallery();
              },
            ),
          ],
        ),
      ),
    );
  }

  
}