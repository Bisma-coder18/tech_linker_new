class User {
  final String id;
  final String email;
  final String role;
  final String? name;
  final String? avatar;

  User({
    required this.id,
    required this.role,
    required this.email,
    this.name,
    this.avatar,
  });

  // Convert from JSON (API response)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'],
      avatar: json['avatar'],
      role: json['role'],
    );
  }

  // Convert to JSON (for storage)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'avatar': avatar,
    };
  }
}
