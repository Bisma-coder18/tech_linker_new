import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_linker_new/models/internship_model.dart';
import 'package:tech_linker_new/screens/Internship_detailScreeen.dart';
import 'package:tech_linker_new/screens/student/interships/intership_detail.dart';
import 'package:tech_linker_new/screens/student/home/widgets/internship_card.dart';
import 'package:tech_linker_new/widget/space.dart';

class InternshipList extends StatelessWidget {
  final List<Internship> jobs;
  final Function(Internship)? onJobApply;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  const InternshipList({
    super.key,
    required this.jobs,
    this.onJobApply,
    this.physics,
    this.shrinkWrap = true,
  });

  @override
  Widget build(BuildContext context) {
    if (jobs.isEmpty) {
      return const Center(
        child: Text('No jobs available'),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: physics,
      itemCount: jobs.length,
      separatorBuilder: (context, index) => const Space(height: 16),
      itemBuilder: (context, index) {
        final job = jobs[index];
        return InternshipCard(
          job: job,
          onApplyTap: ()=>Get.to(()=>StudentInternshipDetailScreen(jobId:job.id)),
          onDetail: ()=>Get.to(()=>StudentInternshipDetailScreen(jobId:job.id)));
          }
        );
  }
}
