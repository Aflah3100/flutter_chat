class UserModel {
  UserModel({required this.userId,required this.name, required this.email, required this.password});

  String? userId;
  String name;
  String email;
  String password;

  Map<String, dynamic> toMap() =>
      {"name": name, "email": email, "password": password};

  factory UserModel.fromMap(Map<String, dynamic> userMap) => UserModel(
      userId: userMap["userid"],
      name: userMap['name'],
      email: userMap['email'],
      password: userMap["password"]);
}
