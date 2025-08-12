import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_linker_new/models/internship_model.dart';
import 'package:tech_linker_new/modules/controllers/student/student_home.dart';
import 'package:tech_linker_new/screens/student/home/widgets/internship_card.dart';
import 'package:tech_linker_new/screens/student/interships/intership_detail.dart';
import 'package:tech_linker_new/theme/app_colors.dart';
import 'package:tech_linker_new/theme/app_text_styles.dart';
import 'package:tech_linker_new/widget/empty_widgets.dart';
import 'package:tech_linker_new/widget/space.dart';

class AllInternships extends StatefulWidget {
  const AllInternships({super.key});

  @override
  State<AllInternships> createState() => _AllInternshipsState();
}

class _AllInternshipsState extends State<AllInternships> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final StudentHomeController controller = Get.put(StudentHomeController());

  RxList<Internship> filteredInternships = <Internship>[].obs;

  Future<void> _refreshData() async {
    await controller.fetchInternships();
    _filterInternships(_controller.text);
  }

  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });

    // Fetch internships initially and set filtered list
    controller.fetchInternships().then((_) {
      _filterInternships('');
    });

    // Listen to search input changes
    _controller.addListener(() {
      _filterInternships(_controller.text);
    });
  }

  void _filterInternships(String query) {
    final allJobs = controller.internships.map((job) => Internship.fromJson(job)).toList();

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
        title: const Text('All Internships', style: AppTextStyles.large),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                // Search Box
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _isFocused ? AppColors.grey_20 : AppColors.grey_20,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.grey),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          focusNode: _focusNode,
                          cursorColor: AppColors.primary,
                          decoration: const InputDecoration(
                            hintText: 'Search by title',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

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
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final job = filteredInternships[index];
                        return InternshipCard(
                          job: job,
                          onApplyTap: () => Get.to(() => StudentInternshipDetailScreen(jobId: job)),
                          onDetail: () => Get.to(() => StudentInternshipDetailScreen(jobId: job)),
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
