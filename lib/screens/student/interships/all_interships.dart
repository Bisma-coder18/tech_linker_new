import 'package:flutter/material.dart';
import 'package:tech_linker_new/models/mock_data.dart';
import 'package:tech_linker_new/screens/student/home/widgets/internship_list.dart';
import 'package:tech_linker_new/theme/app_colors.dart';
import 'package:tech_linker_new/theme/app_text_styles.dart';

class AllInternships extends StatefulWidget {
  const AllInternships({super.key});

  @override
  State<AllInternships> createState() => _AllInternshipsState();
}

class _AllInternshipsState extends State<AllInternships> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
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
      backgroundColor:AppColors.backgroundColor,
      appBar: AppBar(
       backgroundColor:AppColors.backgroundColor,
  surfaceTintColor:AppColors.backgroundColor, // Needed on Material 3
  shadowColor:  Colors.transparent, // In case of subtle default shadow
        title: const Text('All Internships',style: AppTextStyles.large,),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              // 🔍 Search Box
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

              // 📄 Internship List (scrollable)
              Expanded(
                child: InternshipList(
                  jobs: jobsData,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
