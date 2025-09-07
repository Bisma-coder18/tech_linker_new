class InstituteModel {
  final String id;
  final String? email;
  final String? role;
  final String? name;
  final String? phone;
  final String? image;
  final String? address;
  final String? bio;
  final String? website;
  final String? about;

  InstituteModel({
    required this.id,
    this.role,
    this.email,
    this.phone,
    this.name,
    this.address,
    this.bio,
    this.website,
    this.about,
    this.image,
  });

  // Convert from JSON (API response)
  factory InstituteModel.fromJson(Map<String, dynamic> json) {
    print("lslslslsllsls");
    print(json);
    return InstituteModel(
      id: json['_id'] ?? json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'],
      image: json['image'] ?? '',
      role: json['role'],
      phone: json['phone'],
      address: json['address'] ?? '',
      bio: json['bio'] ?? '',
      website: json['website'] ?? json['web'] ?? '',
      about: json['about'] ?? '',
    );
  }
  // Convert to JSON (for storage)
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'name': name,
      'image': image,
      'address': address,
      'bio': bio,
      'phone': phone,
      'website': website,
      'about': about,
    };
  }
}
