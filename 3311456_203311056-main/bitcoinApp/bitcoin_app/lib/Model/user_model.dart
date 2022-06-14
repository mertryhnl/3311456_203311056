class User {
  final String? email;
  final String? password;
  User({
    required this.email,
    required this.password,
  });
  List<User> user = [];

  static void add(User user) {}
}

class UserDetailedInfo {
  final String birthPlace;
  final String birthDate;
  final String name;

  UserDetailedInfo(this.birthPlace, this.birthDate, this.name);
}

List<UserDetailedInfo> userDetail = [];
