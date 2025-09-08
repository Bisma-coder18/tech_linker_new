class Internship {
  final String id;
  final String? role;
  final String? instituteId;
  final String? institute; // jab sirf name aata hai
  final String image;
  final String title;
  final String jobtype;
  final String? joblevel;
  final String? stipend;
  final String description;
  final String? location;
  final DateTime? deadline;
  final DateTime? datePosted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? appliedAt; // naya field
  final int? version;

  const Internship({
    required this.id,
    required this.title,
    required this.jobtype,
    required this.description,
    required this.image,
    this.role,
    this.instituteId,
    this.institute,
    this.joblevel,
    this.stipend,
    this.location,
    this.deadline,
    this.datePosted,
    this.createdAt,
    this.updatedAt,
    this.appliedAt,
    this.version,
  });

  factory Internship.fromJson(Map<String, dynamic> json) {
    return Internship(
      id: json['_id'] ?? json['internshipId'] ?? '',
      role: json['role'],
      instituteId: json['instituteId'],
      institute: json['institute'], // sirf name string
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      jobtype: json['type'] ?? '',
      description: json['description'] ?? '',
      location: json['location'],
      joblevel: json['joblevel'],
      stipend: json['stipend'],
      deadline: json['deadline'] != null ? DateTime.tryParse(json['deadline']) : null,
      datePosted: json['datePosted'] != null ? DateTime.tryParse(json['datePosted']) : null,
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
      appliedAt: json['appliedAt'] != null ? DateTime.tryParse(json['appliedAt']) : null,
      version: json['__v'],
    );
  }
}
