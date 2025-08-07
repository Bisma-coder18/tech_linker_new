import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class Internship {
  final String title;
  final String location;
  final String description;
  final String type;
  final String image;
  final String posted;

  Internship({
    required this.title,
    required this.location,
    required this.description,
    required this.type,
    required this.image,
    required this.posted,
  });

  factory Internship.fromJson(Map<String, dynamic> json) {
    return Internship(
      title: json['title'] ?? '',
      location: json['location'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      image: json['image'] ?? '',
      posted: json['posted'] ?? '',
    );
  }
}
