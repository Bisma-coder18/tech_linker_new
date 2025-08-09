import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_linker_new/models/mock_data.dart';
import 'package:tech_linker_new/screens/student/home/widgets/internship_card.dart';
import 'package:tech_linker_new/screens/student/interships/intership_detail.dart';
import 'package:tech_linker_new/theme/app_colors.dart';
import 'package:tech_linker_new/theme/app_text_styles.dart';
import 'package:tech_linker_new/widget/empty_widgets.dart';
import 'package:tech_linker_new/widget/space.dart';

class AppliedInternshipScreen extends StatelessWidget {
  const AppliedInternshipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isEmpty = jobsData.isEmpty;

    return Scaffold(
      backgroundColor:AppColors.backgroundColor,
      appBar: AppBar(
       backgroundColor: AppColors.backgroundColor,
  surfaceTintColor:AppColors.backgroundColor, 
  shadowColor:  Colors.transparent,
        title: const Text('Applied Interships',style: AppTextStyles.large,),
      ),
      body:Padding(
        padding: EdgeInsets.symmetric(vertical:10,horizontal: 20 ),
            child: isEmpty
          ?  const EmptyWidget(
                svgAsset: 'assets/svg/search.svg',
                title: 'No Applications Yet',
                description: 'You haven’t applied for any internships.',
              )
          : ListView.separated(
      shrinkWrap: true,
      itemCount: jobsData.length,
      separatorBuilder: (context, index) => const Space(height: 16),
      itemBuilder: (context, index) {
        final job = jobsData[index];
        return InternshipCard(
          job: job,
          buttonVisible:false,
          onDetail: ()=>Get.to(()=>StudentInternshipDetailScreen(jobId: job.id,)));
          }
        ),
          )
    );
  }
}
