import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_linker_new/screens/student/auth/student_signup.dart';
import 'package:tech_linker_new/screens/student/main_tab.dart';
import 'package:tech_linker_new/screens/student/settings/settings.dart';

import 'ImagePickerBottomSheet.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Column(
        children: [
          // 🔹 Top Profile Section
        Container(
        width: double.infinity,
        height: 155,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
        decoration: const BoxDecoration(
          color: Color(0xFF2563EB),
        ),
        child: Center(
          child: SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              child: GestureDetector(
                                onTap: (){},
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff032C7E),
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 35,
                              left: 43,
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                    ),
                                    builder: (context) {
                                      return ImagePickerBottomSheet(
                                        onRemove: () {
                                          debugPrint("Image removed");
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              )

                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 8,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("UserName", style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.white),),
                        Text("Location", style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),)
                      ],
                    ),
                  ],
                ),
                IconButton(onPressed: (){}, icon: Icon(Icons.settings, color: Colors.white,))
              ],
            ),
          ),
        ),
      ),


        const SizedBox(height: 100),

          // 🔹 Emoji
          const Text(
            "😔",
            style: TextStyle(fontSize: 70),
          ),

          const SizedBox(height: 20),

          // 🔹 Logout Text
          const Text(
            "Log out",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Are you sure you want to leave?",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 40),

          // 🔹 Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                // Yes Button (Light Blue)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.offAll(() => StudentSignupScreen()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEFF6FF),
                      foregroundColor: const Color(0xFF2563EB),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text("Yes"),
                  ),
                ),
                const SizedBox(height: 12),
                // Cancel Button (Blue)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.offAll(() => MainTabScreen()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text("Cancel"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
