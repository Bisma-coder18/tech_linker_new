import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  final double? height;
  final double? width;
  
  const Space({super.key, this.height, this.width});
  
  const Space.h(double height, {super.key}) : height = height, width = null;
  const Space.w(double width, {super.key}) : height = null, width = width;
  
  // Predefined
  const Space.xs({super.key}) : height = 4, width = null;
  const Space.sm({super.key}) : height = 8, width = null;
  const Space.md({super.key}) : height = 16, width = null;
  
  @override
  Widget build(BuildContext context) => SizedBox(height: height, width: width);
}