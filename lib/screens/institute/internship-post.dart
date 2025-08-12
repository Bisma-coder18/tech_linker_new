import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_linker_new/modules/controllers/institute/internship-post-controller.dart';
import 'package:tech_linker_new/theme/app_colors.dart';
import 'package:tech_linker_new/theme/app_text_styles.dart';
import 'package:tech_linker_new/widget/common_fill_btn.dart';
import 'package:tech_linker_new/widget/custom-text-feild.dart';
import 'package:tech_linker_new/widget/cached_img.dart'; // Assuming for image preview
import 'package:tech_linker_new/widget/space.dart'; // For image picker

class InternshipPostScreen extends StatelessWidget {
  String? commingFrom;
  InternshipPostScreen({super.key,this.commingFrom});
  final InternshipPostController controller = Get.put(InternshipPostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
     body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Space(height: 60,),
                  commingFrom=="edit"?
              Row(
                
                children: [
                    Space(width: 20,),
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back_ios_new_sharp)),
                   Space(width: 100,),
                  Text("Post Internship",style: AppTextStyles.large,),
                ],
              ):
                  Text("Post Internship",style: AppTextStyles.large,),
              // Job Image Section
              _buildImageSection(),
              const SizedBox(height: 20),
              // Job Details Section
              _buildJobDetailsSection(),
              _buildSalarySection(),
              _buildJobTypeSection(),
              _buildLocationTypeSection(),
              _buildJobLevelSection(),
              _buildDeadlineSection(context),
              _buildDescriptionSection(),
              const SizedBox(height: 15),
              commingFrom == "edit"?
               Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child:Column(children: [
              CommonFillButton(onPressed:()=>controller.postInternship(context), text: "Edit Post", isLoading: controller.isLoading),
             Space(height: 10,),
             CommonFillButton(
              bgColor:Colors.red,
              onPressed:()=>controller.postInternship(context), text: "Delete Post", isLoading: controller.isLoading)

                ],)) 
               :
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: CommonFillButton(onPressed:()=>controller.postInternship(context), text: "Create Post", isLoading: controller.isLoading)),
                Space(height: 40,)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          
          Obx(
            ()=> Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Obx(() {
                    return controller.selectedImage.value != null
                        ? CachedImage(imageUrl: controller.selectedImage.value!.path,isCircular: false,)
                        : GestureDetector(
                          onTap: () => controller.pickImage(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image, size: 40, color: Colors.grey),
                              Text("Select Image"),
                            ],
                          ),
                        );
                  }),
                ),
                if(controller.selectedImage.value != null)
                  Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: controller.pickImage,
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
                        size: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobDetailsSection() {
    return _buildSection(
      title: "Job Details",
      children: [
        CustomTextField(
          controller: controller.jobTitleController,
          label: 'Job Title',
          prefixIcon: Icons.work_outline,
          onChanged: (value) => controller.jobTitle.value = value,
          validator: (value) {
            if (value == null || value.isEmpty) return 'Please enter job title';
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSalarySection() {
    return _buildSection(
      title: "Salary",
      children: [
        CustomTextField(
          controller: controller.salaryController,
          label: 'Salary (e.g., \$2600 - \$3400/yr)',
          prefixIcon: Icons.attach_money,
          keyboardType: TextInputType.text,
          onChanged: (value) => controller.salary.value = value,
          validator: (value) {
            if (value == null || value.isEmpty) return 'Please enter salary';
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildJobTypeSection() {
    return _buildSection(
      title: "Job Type",
      children: [
        Obx(() => DropdownButtonFormField<String>(
              value: controller.jobType.value,
              decoration: InputDecoration(
                labelText: 'Job Type',
                prefixIcon: Icon(Icons.work, color: AppColors.primary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: ['Full Time', 'Part Time'].map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) => controller.jobType.value = value!,
              validator: (value) => value == null ? 'Please select job type' : null,
            )),
      ],
    );
  }

  Widget _buildLocationTypeSection() {
    return _buildSection(
      title: "Location Type",
      children: [
        Obx(() => DropdownButtonFormField<String>(
              value: controller.locationType.value,
              decoration: InputDecoration(
                labelText: 'Location Type',
                prefixIcon: Icon(Icons.location_on, color: AppColors.primary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelStyle: TextStyle(color: AppColors.textGrey),
                focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color:AppColors.primary), // Change purple to blue when focused
                ),
              ),
              items: ['Onsite', 'Remote', 'Hybrid'].map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) => controller.locationType.value = value!,
              validator: (value) => value == null ? 'Please select location type' : null,
            )),
        Obx(() {
          if (controller.locationType.value != 'Remote') {
            return 
            Column(
           children: [
             const Space(height: 15),
             CustomTextField(
              controller: controller.locationController,
              label: 'Location (e.g., New York, USA)',
              prefixIcon: Icons.map,
              onChanged: (value) => controller.location.value = value,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Please enter location';
                return null;
              },
            )
           ]);
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }

  Widget _buildJobLevelSection() {
    return _buildSection(
      title: "Job Level",
      children: [
        Obx(() => DropdownButtonFormField<String>(
          dropdownColor: AppColors.backgroundColor,
              value: controller.jobLevel.value,
              
              decoration: InputDecoration(
                
                labelText: 'Job Level',
                prefixIcon: Icon(Icons.bar_chart, color: AppColors.primary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusColor: AppColors.primary,
                labelStyle: TextStyle(color: AppColors.primary),
                focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color:AppColors.primary)),
              ),
              items: ['Mid Level', 'Senior'].map((String level) {
                return DropdownMenuItem<String>(
                  value: level,
                  
                  child: Text(level),
                );
              }).toList(),
              onChanged: (value) => controller.jobLevel.value = value!,
              validator: (value) => value == null ? 'Please select job level' : null,
            )),
      ],
    );
  }

Widget _buildDeadlineSection(BuildContext context) {
  return _buildSection(
    title: "Deadline",
    children: [
      Row(
        children: [
          Expanded(
            child: CustomTextField(
              controller: controller.deadlineController,
              label: 'Deadline (MM/DD/YYYY)',
              
              enabled: false, // Disable manual typing
              onChanged: (value) => controller.deadline.value = value,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Please select deadline';
                // Optional: Add additional validation if needed
                return null;
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.calendar_today, color: AppColors.primary),
            onPressed: () => _selectDate(context),
          ),
        ],
      ),
    ],
  );
}

// Method to handle date picking
Future<void> _selectDate(BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(), // Restrict to future dates only
    lastDate: DateTime(2100),
  );
  if (pickedDate != null) {
    // Format the date to MM/DD/YYYY
    String formattedDate = "${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.year}";
    controller.deadlineController.text = formattedDate;
    controller.deadline.value = formattedDate; // Update observable
  }
}
  Widget _buildDescriptionSection() {
    return _buildSection(
      title: "Job Description",
      children: [
        CustomTextField(
          controller: controller.descriptionController,
          label: 'Job Description',
          prefixIcon: Icons.description,
          onChanged: (value) => controller.description.value = value,
          validator: (value) {
            if (value == null || value.isEmpty) return 'Please enter job description';
            return null;
          },
        ),
      ],
    );
  }

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
}