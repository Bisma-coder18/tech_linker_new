import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tech_linker_new/config/app_assets.dart';
import 'package:tech_linker_new/models/internship_model.dart';
import 'package:tech_linker_new/models/mock_data.dart';
import 'package:tech_linker_new/modules/controllers/institute/institute-home.dart';
import 'package:tech_linker_new/modules/controllers/student/student-profile-controller.dart';
import 'package:tech_linker_new/modules/controllers/student/student_home.dart';
import 'package:tech_linker_new/screens/student/home/widgets/internship_card.dart';
import 'package:tech_linker_new/screens/student/interships/all_interships.dart';
import 'package:tech_linker_new/screens/student/home/widgets/internship_list.dart';
import 'package:tech_linker_new/screens/student/interships/intership_detail.dart';
import 'package:tech_linker_new/theme/app_colors.dart';
import 'package:tech_linker_new/theme/app_text_styles.dart';
import 'package:tech_linker_new/widget/cached_img.dart';
import 'package:tech_linker_new/widget/empty_widgets.dart';
import 'package:tech_linker_new/widget/space.dart';

class HomeScreen extends StatelessWidget {
  String? imageUrl;
  final StudentHomeController controller = Get.put(StudentHomeController());

  HomeScreen({super.key});
Future<void> _refreshData() async {
    await controller.fetchInternships();
  }

  @override
  Widget build(BuildContext context) {
    final PersonalProfileController profileController =
        Get.put(PersonalProfileController());

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: RefreshIndicator(
               onRefresh: _refreshData,
              child: SingleChildScrollView(
                        child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(children: [
                // color boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text("Hello", style: AppTextStyles.homeTop),
                        Text("User", style: AppTextStyles.homeTop)
                      ],
                    ),
                    Obx(() {
                      return CachedImage(
                        imageUrl: profileController.selectedImage.value?.path,
                        size: 40,
                      );
                    })
                  ],
                ),
                Space(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // pink
                    Container(
                      height: 190,
                      width: 155,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: AppColors.pink,
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppAssetsPath.find),
                            // Text("4.5k", style: AppTextStyles.large),
                            Text("Remote Jobs", style: AppTextStyles.medium),
                          ]),
                    ),
                    Spacer(),
                    Column(
                      children: [
                        // green
                        Container(
                          height: 85,
                          width: 170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: AppColors.green,
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Text("4.5k", style: AppTextStyles.large),
                                Text("Full time", style: AppTextStyles.medium),
                              ]),
                        ),
                        Space(height: 15),
                        Container(
                          height: 88,
                          width: 170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: AppColors.yellow,
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Text("4.5k", style: AppTextStyles.large),
                                Text("Onsite", style: AppTextStyles.medium),
                              ]),
                        )
                      ],
                    )
                  ],
                ),
                // Recent jobs
                Space(height: 30),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => AllInternships()),
                      );
                    },
                    child: Row(
                      children: [
                        Text("Recent Jobs", style: AppTextStyles.largeBold),
                        Spacer(),
                        Text(
                          "See All",
                          style: AppTextStyles.small,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: AppColors.secondary,
                        )
                      ],
                    )),
                Space(height: 15),
                // In your main screen:
                 Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (controller.internships.isEmpty) {
                        return EmptyWidget(
                          title: "",
                          description: "Not found",
                          svgAsset: 'assets/svg/search.svg',
                        );
                      }
                      final jobs = controller.internships.map((job) => Internship.fromJson(job)).toList();
              
                      return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
              
                    itemCount:jobs.length,
                    separatorBuilder: (context, index) => const Space(height: 16),
                    itemBuilder: (context, index) {
                      final job = jobs[index];
                      return InternshipCard(
                        job: job,
                        onApplyTap: () => Get.to(() => StudentInternshipDetailScreen(jobId: job)),
                        onDetail: ()=> Get.to(() => StudentInternshipDetailScreen(jobId:job)),
                      );
                    }
                  );
                    
                    }),
              ]),
                        ),
                      ),
            )));
  }
}
