import 'package:get/get.dart';
import 'dart:convert'; // For JSON encoding/decoding

class InternshipUserDetailController extends GetxController {
  final String jobId;
  final String userId;
  var isLoading = true.obs;
  var job = Rx<Job?>(null);
  var user = Rx<User?>(null);

  InternshipUserDetailController({required this.jobId, required this.userId});

  @override
  void onInit() {
    super.onInit();
    fetchDetails();
  }

  void fetchDetails() async {
    try {
      isLoading.value = true;
      // Simulate API response with mock JSON data
      await Future.delayed(Duration(seconds: 1));
      String mockJsonResponse = '''
        {
          "job": {
            "id": "1",
            "title": "UI/UX Designer Internship",
            "jobType": "Full Time",
            "jobLevel": "Mid Level",
            "salary": "\$2000 - \$2500/month",
            "locationType": "Onsite",
            "location": "New York, USA",
            "deadline": "09/15/2025"
          },
          "user": {
            "id": "user1",
            "name": "John Doe",
            "email": "john@example.com",
            "phoneNumber": "+1-555-123-4567",
            "profileImage": "path/to/image",
            "cvUrl": "https://example.com/john_doe_cv.pdf"
          }
        }
      ''';
      final data = jsonDecode(mockJsonResponse);
      job.value = Job.fromJson(data['job']);
      user.value = User.fromJson(data['user']);
    } catch (e) {
      print('Error fetching details: $e');
      Get.snackbar('Error', 'Failed to load details');
      job.value = null;
      user.value = null;
    } finally {
      isLoading.value = false;
    }
  }
}

// Models (unchanged, but included for completeness)
class Job {
  final String id;
  final String title;
  final String jobType;
  final String jobLevel;
  final String salary;
  final String locationType;
  final String? location;
  final String deadline;

  Job({
    required this.id,
    required this.title,
    required this.jobType,
    required this.jobLevel,
    required this.salary,
    required this.locationType,
    this.location,
    required this.deadline,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      title: json['title'],
      jobType: json['jobType'],
      jobLevel: json['jobLevel'],
      salary: json['salary'],
      locationType: json['locationType'],
      location: json['location'],
      deadline: json['deadline'],
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String profileImage;
  final String cvUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.profileImage = '',
    this.cvUrl = '',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      profileImage: json['profileImage'] ?? '',
      cvUrl: json['cvUrl'] ?? '',
    );
  }
}