import 'package:flutter/material.dart';
import 'Internship_post.dart';
class InternshipPost {
  final String id;
  final String title;
  final String institute;
  final String description;
  final String skills;
  final String deadline;
  final String status;

  InternshipPost({
    required this.id,
    required this.title,
    required this.institute,
    required this.description,
    required this.skills,
    required this.deadline,
    required this.status,
  });
}
