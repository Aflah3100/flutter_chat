class UserModel {
  UserModel({
    required this.userId,
    required this.name,
    required this.email,
  });

  String? userId;
  String name;
  String email;

  Map<String, dynamic> toMap() =>
      {"name": name, "email": email, "userid": userId};

  factory UserModel.fromMap(Map<String, dynamic> userMap) => UserModel(
        userId: userMap["userid"],
        name: userMap['name'],
        email: userMap['email'],
      );
}
