import 'package:tech_linker_new/models/institute-model.dart';

class InternshipModel {
  final String id;
  final InstituteModel institute;
  final String image;
  final String title;
  final String stipend;
  final String type;
  final String joblevel;
  final String description;
  final String location;
  final DateTime deadline;
  final String role;
  final bool active;
  final DateTime datePosted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final bool applied;

  InternshipModel({
    required this.id,
    required this.institute,
    required this.image,
    required this.title,
    required this.stipend,
    required this.type,
    required this.joblevel,
    required this.description,
    required this.location,
    required this.deadline,
    required this.role,
    required this.active,
    required this.datePosted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.applied,
  });

  factory InternshipModel.fromJson(Map<String, dynamic> json) => InternshipModel(
        id: json["_id"],
        institute: InstituteModel.fromJson(json["instituteId"]),
        image: json["image"],
        title: json["title"],
        applied: json["applied"],
        stipend: json["stipend"],
        type: json["type"],
        joblevel: json["joblevel"],
        description: json["description"],
        location: json["location"],
        deadline: DateTime.parse(json["deadline"]),
        role: json["role"],
        active: json["active"],
        datePosted: DateTime.parse(json["datePosted"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "instituteId": institute.toJson(),
        "image": image,
        "title": title,
        "stipend": stipend,
        "type": type,
        "joblevel": joblevel,
        "applied": applied,
        "description": description,
        "location": location,
        "deadline": deadline.toIso8601String(),
        "role": role,
        "active": active,
        "datePosted": datePosted.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
