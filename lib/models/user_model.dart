class User {
  final String userId;
  final String email;
  final userType;

  User({required this.userId, required this.email, required this.userType});

  Map<String, dynamic> toJson() {
    return {
      'userId': this.userId,
      'email': this.email,
      'userType': this.userType
    };
  }
}
