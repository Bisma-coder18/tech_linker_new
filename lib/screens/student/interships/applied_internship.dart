import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_linker_new/models/internship_model.dart';
import 'package:tech_linker_new/modules/controllers/student/applied_internship.dart';
import 'package:tech_linker_new/screens/student/home/widgets/internship_card.dart';
import 'package:tech_linker_new/screens/student/interships/intership_detail.dart';
import 'package:tech_linker_new/theme/app_colors.dart';
import 'package:tech_linker_new/theme/app_text_styles.dart';
import 'package:tech_linker_new/widget/empty_widgets.dart';

class AppliedInternshipsScreen extends StatefulWidget {
  const AppliedInternshipsScreen({super.key});

  @override
  State<AppliedInternshipsScreen> createState() => _AllInternshipsState();
}

class _AllInternshipsState extends State<AppliedInternshipsScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final AppliedStudentController controller = Get.put(AppliedStudentController());

  RxList<Internship> filteredInternships = <Internship>[].obs;

  Future<void> _refreshData() async {
    await controller.fetchAppliedInternships();
    _filterInternships(_controller.text);
  }


  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      
    });

    // Fetch internships initially and set filtered list
    controller.fetchAppliedInternships().then((_) {
      _filterInternships('');
    });

    // Listen to search input changes
    _controller.addListener(() {
      _filterInternships(_controller.text);
    });
  }

  void _filterInternships(String query) {
    final allJobs =
        controller.internships.map((job) => Internship.fromJson(job)).toList();

    if (query.isEmpty) {
      filteredInternships.value = allJobs;
    } else {
      filteredInternships.value = allJobs.where((job) {
        return job.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.backgroundColor,
        shadowColor: Colors.transparent,
        title: const Text('Applied Internships', style: AppTextStyles.large),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
              
                // Internship List (scrollable)
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (filteredInternships.isEmpty) {
                      return EmptyWidget(
                        title: "",
                        description: "Not found",
                        svgAsset: 'assets/svg/search.svg',
                      );
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: filteredInternships.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final job = filteredInternships[index];
                        return InternshipCard(
                          job: job,
                          onApplyTap: () => Get.to(
                              () => StudentInternshipDetailScreen(jobId: job)),
                          onDetail: () => Get.to(
                              () => StudentInternshipDetailScreen(jobId: job)),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
