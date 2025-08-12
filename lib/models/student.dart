class User {
  final String? id;
  final String? email;
  final String? role;
  final String? name;
  final String? avatar;
  final String? phone;
  final String? location;
  final String? bio;

  User({
    required this.id,
    required this.role,
    required this.email,
    this.name,
    this.avatar,
    this.phone,
    this.location,
    this.bio
  });

  // Convert from JSON (API response)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id']??json['id']  ?? '',
      email: json['email'] ?? '',
      name: json['name'],
      avatar: json['avatar'],
      role: json['role'],
      phone: json['phone'],
      location: json['location'],
      bio: json['bio'],
    );
  }

  // Convert to JSON (for storage)
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'name': name,
      'avatar': avatar,
      'phone':phone,
      'location':location,
    };
  }
}
