import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tech_linker_new/config/app_assets.dart';
import 'package:tech_linker_new/modules/controllers/profileController/profileController.dart';
import 'package:tech_linker_new/theme/app_colors.dart';
import 'package:tech_linker_new/theme/app_text_styles.dart';
import 'package:tech_linker_new/util/util.dart';
import 'package:tech_linker_new/widget/cached_img.dart';
import 'package:get/get.dart';

class PersonalProfileScreen extends StatelessWidget {
  final PersonalProfileController controller =
      Get.put(PersonalProfileController());

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
          "Personal Profile",
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
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              // Profile Header
               Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 3),
                ),
                child: Obx(() {
  return CachedImage(
    imageUrl: controller.selectedImage.value?.path,
  );
})
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap:(){
                      _changeProfilePicture(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),

              const SizedBox(height: 20),

              // Profile Sections
              _buildBasicInfoSection(),
              // _buildEducationSection(),
              // _buildProfessionalSection(),
              //           _buildSection(
              //   title: "Skills & Interests",
              //   children: [
              //     _buildChipSection("Technical Skills", controller.skills, AppColors.primary,context),
              //     const SizedBox(height: 16),
              //     _buildChipSection("Areas of Interest", controller.interests, Colors.orange,context),
              //   ],
              // ),
              _buildDocumentsSection(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

 

  Widget _buildBasicInfoSection() {
    return _buildSection(
      title: "Basic Information",
      children: [
        _buildTextField(
            "Full Name", controller.nameController, Icons.person_outline),
        _buildTextField(
            "Email", controller.emailController, Icons.email_outlined,
            keyboardType: TextInputType.emailAddress),
        _buildTextField(
            "Phone", controller.phoneController, Icons.phone_outlined,
            keyboardType: TextInputType.phone),
        _buildTextField("Location", controller.locationController,
            Icons.location_on_outlined),
        _buildTextField("Bio", controller.bioController, Icons.info_outline,
            maxLines: 3),
      ],
    );
  }

  Widget _buildEducationSection() {
    return _buildSection(
      title: "Education",
      children: [
        _buildTextField("University/College", controller.universityController,
            Icons.school_outlined),
        _buildTextField("Major/Field of Study", controller.majorController,
            Icons.book_outlined),
        _buildTextField("Current Year", controller.yearController,
            Icons.calendar_today_outlined),
        _buildTextField(
            "GPA/Grade", controller.gpaController, Icons.grade_outlined),
      ],
    );
  }

  Widget _buildProfessionalSection() {
    return _buildSection(
      title: "Professional Links",
      children: [
        _buildTextField("LinkedIn Profile", controller.linkedinController,
            Icons.link_outlined),
        _buildTextField(
            "GitHub Profile", controller.githubController, Icons.code_outlined),
        _buildTextField("Portfolio Website", controller.portfolioController,
            Icons.web_outlined),
      ],
    );
  }

  Widget _buildDocumentsSection() {
    return _buildSection(
      title: "Documents",
      children: [
        _buildDocumentTile(
          title: "Resume/CV",
          subtitle: "Upload your latest resume",
          icon: Icons.description_outlined,
          onTap: controller.uploadResume,
          hasFile: true,
          fileName: "John_Doe_Resume.pdf",
        ),
        const SizedBox(height: 12),
        // _buildDocumentTile(
        //   title: "Cover Letter",
        //   subtitle: "Upload a general cover letter",
        //   icon: Icons.article_outlined,
        //   onTap: _uploadCoverLetter,
        //   hasFile: false,
        // ),
        // const SizedBox(height: 12),
        // _buildDocumentTile(
        //   title: "Portfolio",
        //   subtitle: "Upload work samples or projects",
        //   icon: Icons.folder_outlined,
        //   onTap: _uploadPortfolio,
        //   hasFile: false,
        // ),
      ],
    );
  }

  Widget _buildSection(
      {required String title, required List<Widget> children}) {
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
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppColors.primary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
          filled: true,
          fillColor: Colors.grey[50],
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildChipSection(
      String title, List<String> items, Color color, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            TextButton.icon(
              onPressed: () => _addSkillDialog(title, items, context),
              icon: Icon(Icons.add, size: 16, color: color),
              label: Text("Add", style: TextStyle(color: color)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items
              .map((item) =>
                  _buildChip(item, color, () => controller.removeSkill(item)))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildChip(String label, Color color, VoidCallback onDelete) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(color: color, fontSize: 12),
      ),
      backgroundColor: color.withOpacity(0.1),
      deleteIcon: Icon(Icons.close, size: 16, color: color),
      onDeleted: onDelete,
      side: BorderSide(color: color.withOpacity(0.3)),
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
    // Implement image picker
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
                // Implement camera
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

  void _addSkillDialog(String title, List<String> items, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add $title"),
        content: TextField(
          controller: controller.textController,
          decoration: InputDecoration(
            hintText: "Enter ${title.toLowerCase()}",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              controller.addSkill(controller.textController.text);
              Navigator.pop(context);
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }
}
