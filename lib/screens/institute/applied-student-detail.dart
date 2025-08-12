import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_linker_new/models/aaplied-users.dart';
import 'package:tech_linker_new/theme/app_colors.dart';
import 'package:tech_linker_new/theme/app_text_styles.dart';
import 'package:tech_linker_new/widget/cached_img.dart';
import 'package:url_launcher/url_launcher.dart';

class InternshipUserDetailScreen extends StatelessWidget {
  final Applicant applicant;
  final RxList<Internship> jobDetail;
  final int index;
  InternshipUserDetailScreen({super.key, required this.applicant,required this.jobDetail,required this.index});

  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold( 
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // Modern App Bar with gradient
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Applicant Details",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Get.back(),
            ),
            
          ),
          
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 20),
                
                // User Profile Card
                  Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile Image and Basic Info
          Row(
            children: [
              Stack(
                children: [
                  // Container(
                  //   padding: const EdgeInsets.all(3),
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     gradient: LinearGradient(
                  //       colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
                  //     ),
                  //   ),
                  //   child: CachedImage(imageUrl:a,size: 60  ,) 
                  // ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Icon(Icons.check, color: Colors.white, size: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      applicant.student.name,
                      style: AppTextStyles.darkH4_500.copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      applicant.student.email,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Row(
                    //   children: [
                    //     Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                    //     const SizedBox(width: 4),
                    //     Text(
                    //       jobDetail,
                    //       style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
             ],
          ),
          const SizedBox(height: 16),          
          // Stats Row
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     _buildStatItem("Experience", userData['experience']),
          //     Container(width: 1, height: 30, color: Colors.grey[300]),
          //     _buildStatItem("Rating", "${userData['rating']} ⭐"),
          //     Container(width: 1, height: 30, color: Colors.grey[300]),
          //     _buildStatItem("Applied", userData['appliedDate']),
          //   ],
          // ),
        ],
      ),
    ),
                const SizedBox(height: 16),
                
                // Contact Actions
                   Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildActionButton(
              icon: Icons.email,
              label: "Email",
              color: Colors.blue,
              onTap: () => _launchEmail(applicant.student.email),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildActionButton(
              icon: Icons.phone,
              label: "Call",
              color: Colors.green,
              onTap: () => _launchPhone(applicant.student.phone!),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildActionButton(
              icon: Icons.message,
              label: "Message",
              color: Colors.orange,
              onTap: () => _launchMessage(applicant.student.phone!),
            ),
          ),
        ],
      ),
    ),
 
                const SizedBox(height: 16),
                
                // Job Details Card
                   Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.work, color: AppColors.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Job Details",
                      style: AppTextStyles.darkH4_500.copyWith(fontSize: 18),
                    ),
                    Text(
                      "Applied for this position",
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
                    // _buildSummaryItem(Icons.school, 'Education', jobDetail[index].title),
          _buildSummaryItem(Icons.work, 'Job type', jobDetail[index].type),
          _buildSummaryItem(
            Icons.update,
            'Posted',
            jobDetail[index].datePosted is DateTime
                ? "${jobDetail[index].datePosted.day.toString().padLeft(2, '0')}/${jobDetail[index].datePosted.month.toString().padLeft(2, '0')}/${jobDetail[index].datePosted.year}"
                : jobDetail[index].datePosted.toString(),
          ),
          _buildSummaryItem(Icons.bar_chart, 'Job level', jobDetail[index].jobLevel!),
          _buildSummaryItem(Icons.schedule, 'Deadline', jobDetail[index].deadline!.toString()),
          _buildSummaryItem(Icons.location_on, 'Location',  jobDetail[index].location??""),
        ],
      ),
    ),
                const SizedBox(height: 16),
                
                // CV and Documents
//    Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Documents & Portfolio",
//             style: AppTextStyles.darkH4_500.copyWith(fontSize: 18),
//           ),
//           const SizedBox(height: 16),
          
//           // CV Download
//           GestureDetector(
//             onTap: () => _downloadCV(applicant.student.cv),
//             child: Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Colors.red.withOpacity(0.1),
//                     Colors.red.withOpacity(0.05),
//                   ],
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.red.withOpacity(0.2)),
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: Colors.red.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Icon(Icons.picture_as_pdf, color: Colors.red),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Resume/CV",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 14,
//                           ),
//                         ),
//                         Text(
//                           "Download PDF • ${applicant.student.cv}",
//                           style: TextStyle(
//                             color: Colors.grey[600],
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Icon(Icons.download, color: Colors.red),
//                 ],
//               ),
//             ),
//           ),
          
//           const SizedBox(height: 12),
          
//           // Portfolio Links
//  ],
//       ),
//     ),
                    
                    
                    const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }


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


 

  Widget _buildActionButtons(Map<String, dynamic> userData) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // Reject functionality
                _showRejectDialog();
              },
              icon: Icon(Icons.close),
              label: Text("Reject"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // Accept functionality
                _showAcceptDialog();
              },
              icon: Icon(Icons.check),
              label: Text("Accept"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
 // Action Methods
  void _launchEmail(String email) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  void _launchPhone(String phone) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  void _launchMessage(String phone) async {
    final Uri smsUri = Uri(scheme: 'sms', path: phone);
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    }
  }

  void _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _downloadCV(String cvUrl) async {
    final Uri uri = Uri.parse(cvUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Get.snackbar('Error', 'Could not download CV');
    }
  }

  void _showAcceptDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Accept Application'),
        content: Text('Are you sure you want to accept this application?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.snackbar('Success', 'Application accepted successfully');
              // Add your accept logic here
            },
            child: Text('Accept'),
          ),
        ],
      ),
    );
  }

  void _showRejectDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Reject Application'),
        content: Text('Are you sure you want to reject this application?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.snackbar('Success', 'Application rejected');
              // Add your reject logic here
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Reject'),
          ),
        ],
      ),
    );
  }
}