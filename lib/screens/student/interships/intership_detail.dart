import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_linker_new/models/internship_model.dart';
import 'package:tech_linker_new/modules/controllers/auth/student_auth_controller.dart';
import 'package:tech_linker_new/modules/controllers/student/internship_detail.dart';
import 'package:tech_linker_new/services/api.dart';
import 'package:tech_linker_new/theme/app_colors.dart';
import 'package:tech_linker_new/widget/cached_img.dart';

class StudentInternshipDetailScreen extends StatelessWidget {
  final Internship jobId;
  
  const StudentInternshipDetailScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InternshipDetailController(jobId.id));
      final authcontroller = Get.put(StudentSignupController());

    return
     Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Job Description',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Stack(
              children: [
                Container(
  height: 120,
  width: double.infinity,
  color: Colors.grey.shade300,
  child: jobId.image.isNotEmpty
      ? CachedNetworkImage(
          imageUrl:"http://192.168.1.13:3000"+jobId.image,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
          errorWidget: (context, url, error) => Center(
            child: Icon(Icons.image, size: 40, color: Colors.grey.shade500),
          ),
        )
      : Center(
          child: Icon(Icons.image, size: 40, color: Colors.grey.shade500),
        ),
),
                Positioned(
                  right: 10,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: (){
                         showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black87,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 60,
          ),
          child: Stack(
            children: [
              Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: InteractiveViewer(
                    panEnabled: true,
                    minScale: 1,
                    maxScale: 5,
                    child: CachedNetworkImage(
                      imageUrl:"http://192.168.1.13:3000"+jobId.image,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(
                              strokeWidth: 3,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Loading image...',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      errorWidget: (context, url, error) => SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                size: 48,
                                color: Colors.red[400],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Failed to load image',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Please check your internet connection',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.textSecondary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.zoom_out_map,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            // Positioned(
            //   bottom: -30,
            //   child: CircleAvatar(
            //     radius: 30,
            //     backgroundColor: Colors.orange.shade100,
            //     child: CachedImage(),
            //   ),
            // ),
          ],
        ),
        const SizedBox(height: 40),
         Text(
          jobId.title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Icon(Icons.calendar_today, size: 14, color: Colors.grey.shade600),
        //     const SizedBox(width: 4),
        //     Text(
        //       jobId.datePosted.toString().split(' ')[0],
        //       style: TextStyle(
        //         fontSize: 12,
        //         color: Colors.grey.shade600,
        //       ),
        //     ),
        //     const SizedBox(width: 16),
        //     // Icon(Icons.access_time, size: 14, color: Colors.grey.shade600),
        //     // const SizedBox(width: 4),
        //     // Text(
        //     //   '10 min ago',
        //     //   style: TextStyle(
        //     //     fontSize: 12,
        //     //     color: Colors.grey.shade600,
        //     //   ),
        //     // ),
        //     // const SizedBox(width: 16),
        //     // const Icon(Icons.star, size: 14, color: Colors.orange),
        //     // const SizedBox(width: 2),
        //     // const Text(
        //     //   '4.8',
        //     //   style: TextStyle(
        //     //     fontSize: 12,
        //     //     color: Colors.orange,
        //     //     fontWeight: FontWeight.w500,
        //     //   ),
        //     // ),
        //   ],
        // ),
        // const SizedBox(height: 10),
      ],
    ),
                  _buildTabBar(controller),
                  // Obx(() => controller.isDescriptionTab.value ? 
                   Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Job Summary',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          // _buildSummaryItem(Icons.business, 'Company', 'UI UX Designer, Graphic'),
          // _buildSummaryItem(Icons.school, 'Education', 'Masters in any discipline'),
          _buildSummaryItem(Icons.attach_money, 'Salary', jobId.stipend!),
          _buildSummaryItem(Icons.work, 'Job type', jobId.jobtype), 
          _buildSummaryItem(Icons.create, 'Updated', jobId.updatedAt.toString().split(' ')[0]),
          _buildSummaryItem(Icons.bar_chart, 'Job level',jobId.joblevel!),
          // _buildSummaryItem(Icons.person, 'Age', 'Age at least 24 years'),
          _buildSummaryItem(Icons.work_history,'location Type', jobId.location!),
          _buildSummaryItem(Icons.schedule, 'Deadline',jobId.deadline.toString().split(' ')[0]),
          const SizedBox(height: 20),
            Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 20,
                    // color: Colors.grey.shade700,
                    height: 1.5,
                  ),
                ),
           Text(
                  jobId.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    height: 1.5,
                  ),
                ),
              
          
       ],
      ),
    )
 
                      // : _buildCompanyContent()),
                ],
              ),
            ),
          ),
              authcontroller.role.value == "student" 
     ? Container(
         color: Colors.white,
         padding: const EdgeInsets.all(20),
         child: SafeArea(
           child: Row(
             children: [
               Expanded(
                 child: OutlinedButton(
                   onPressed: controller.saveJob,
                   style: OutlinedButton.styleFrom(
                     side: const BorderSide(color: AppColors.primary),
                     padding: const EdgeInsets.symmetric(vertical: 16),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(8),
                     ),
                   ),
                   child: const Text(
                     'Save',
                     style: TextStyle(
                       color: AppColors.primary,
                       fontSize: 16,
                       fontWeight: FontWeight.w500,
                     ),
                   ),
                 ),
               ),
               const SizedBox(width: 12),
               Expanded(
                 child: ElevatedButton(
                   onPressed: () => _showApplyModal(context),
                   style: ElevatedButton.styleFrom(
                     backgroundColor: AppColors.primary,
                     padding: const EdgeInsets.symmetric(vertical: 16),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(8),
                     ),
                   ),
                   child: const Text(
                     'Apply',
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: 16,
                       fontWeight: FontWeight.w500,
                     ),
                   ),
                 ),
               ),
             ],
           ),
         ),
       )
     : const SizedBox.shrink()
        ],
      ),
    );
  }
// Add this new method to your StudentInternshipDetailScreen class
void _showApplyModal(BuildContext context) {
  final controller = Get.find<InternshipDetailController>();
  final authcontroller = Get.put(StudentSignupController());
  Get.bottomSheet(
    Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Upload Your CV',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Please upload your CV to apply for this position',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          
          // CV Upload Container
          Obx(() => Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.insert_drive_file,
                  size: 40,
                  color: AppColors.primary,
                ),
                const SizedBox(height: 10),
                Text(
                  controller.cvFile.value?.name ?? 'No file selected',
                  style: TextStyle(
                    fontSize: 14,
                    color: controller.cvFile.value != null 
                        ? Colors.black 
                        : Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                TextButton(
  onPressed: controller.pickCV,
  style: TextButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    foregroundColor: AppColors.primary, // Text color
  ),
  child: const Text(
    'Choose File',
    style: TextStyle(
      decoration: TextDecoration.underline,
      fontSize: 16, // Adjust as needed
    ),
  ),
),
              ],
            ),
          )),
          const SizedBox(height: 30),
          
          // Apply Button

          Obx(() => SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.isApplying.value ? null : controller.applyForJob,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: controller.isApplying.value
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      'Submit Application',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
          )),
          const SizedBox(height: 10),
          
          // Cancel Button
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    ),
    isScrollControlled: true,
  );
}

// Then update your _buildBottomButtons method to use this modal:


  Widget _buildTabBar(InternshipDetailController controller) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          // Expanded(
          //   child: GestureDetector(
          //     onTap: () => controller.toggleTab(true),
          //     child: Obx(() => Container(
          //       padding: const EdgeInsets.symmetric(vertical: 12),
          //       decoration: BoxDecoration(
          //         color: controller.isDescriptionTab.value ? AppColors.primary : Colors.transparent,
          //         borderRadius: BorderRadius.circular(8),
          //       ),
          //       child: Text(
          //         'Description',
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //           color: controller.isDescriptionTab.value ? AppColors.white : AppColors.textSecondary,
          //           fontWeight: FontWeight.w500,
          //         ),
          //       ),
          //     )),
          //   ),
          // ),
          Text(
                  'Description',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }



  // Widget _buildCompanyContent() {
  //   return Container(
  //     color: Colors.white,
  //     margin: const EdgeInsets.only(top: 10),
  //     padding: const EdgeInsets.all(20),
  //     child: const Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'Company Information',
  //           style: TextStyle(
  //             fontSize: 16,
  //             fontWeight: FontWeight.w600,
  //             color: Colors.black87,
  //           ),
  //         ),
  //         SizedBox(height: 16),
  //         Text(
  //           'This is where company information would be displayed.',
  //           style: TextStyle(
  //             fontSize: 14,
  //             color: Colors.grey,
  //             height: 1.5,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildSummaryItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.grey.shade600),
          const SizedBox(width: 12),
          SizedBox(
            width: 100,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 6),
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }
 
}