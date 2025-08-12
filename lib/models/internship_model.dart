class Internship {
  final String id;
  final String role;
  final String instituteId;
  final String image;
  final String title;
  final String jobtype;
  final String? joblevel;
  final String? stipend;
  final String description;
  final String? location;
  final DateTime deadline;
  final DateTime datePosted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  const Internship({
    required this.id,
    required this.role,
    required this.instituteId,
    required this.image,
    required this.title,
    required this.jobtype,
    this.joblevel,
    required this.description,
     this.stipend,
    this.location,
    required this.deadline,
    required this.datePosted,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory Internship.fromJson(Map<String, dynamic> json) {
    print(json['instituteId']);
    print("alallalal");
    return Internship(
      id: json['_id'] ?? '',
      role: json['role'] ?? '',
      instituteId: json['instituteId'] ,
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      jobtype: json['type'] ?? '',
      description: json['description'] ?? '',
      location: json['location'],
      joblevel: json['joblevel'],
      stipend: json['stipend'],
      deadline: DateTime.parse(json['deadline'] ?? DateTime.now().toIso8601String()),
      datePosted: DateTime.parse(json['datePosted'] ?? DateTime.now().toIso8601String()),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      version: json['__v'] ?? 0,
    );
  }
}