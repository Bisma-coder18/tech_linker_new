class Applicant {
  final String id;
  final Student student;
  final String internshipId;
  final String resume;
  final DateTime appliedAt;

  Applicant({
    required this.id,
    required this.student,
    required this.internshipId,
    required this.resume,
    required this.appliedAt,
  });

  factory Applicant.fromJson(Map<String, dynamic> json) {
    return Applicant(
      id: json['_id'] ?? '',
      student: Student.fromJson(json['studentId'] ?? {}),
      internshipId: json['internshipId'] ?? '',
      resume: json['resume'] ?? '',
      appliedAt: DateTime.tryParse(json['appliedAt'] ?? '') ?? DateTime.now(),
    );
  }
}

class Student {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? cv;

  Student({
    required this.id,
    required this.name,
    required this.email,
     this.cv,
     this.phone,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      cv: json['cv'] ?? '',
    );
  }
}

class Internship {
  final String id;
  final String title;
  final String type;
  final String? jobLevel;
  final String? experience;
  final String description;
  final String? location;
  final String image;
  final String role;
  final DateTime datePosted;
  final DateTime deadline;
  final List<Applicant> applicants;

  Internship({
    required this.id,
    required this.title,
    required this.type,
    this.jobLevel,
    this.experience,
    required this.description,
    this.location,
    required this.image,
    required this.role,
    required this.datePosted,
    required this.deadline,
    required this.applicants,
  });

  factory Internship.fromJson(Map<String, dynamic> json) {
    return Internship(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      type: json['type'] ?? '',
      jobLevel: json['joblevel'],
      experience: json['experience'],
      description: json['description'] ?? '',
      location: json['location'],
      image: json['image'] ?? '',
      role: json['role'] ?? '',
      datePosted: DateTime.tryParse(json['datePosted'] ?? '') ?? DateTime.now(),
      deadline: DateTime.tryParse(json['deadline'] ?? '') ?? DateTime.now(),
      applicants: (json['applicants'] as List? ?? [])
          .map((a) => Applicant.fromJson(a))
          .toList(),
    );
  }
}
