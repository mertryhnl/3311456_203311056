import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name;
  String? surName;
  String? gmail;
  String? password;
  String? telphone;
  String? birthDay;

  UserModel({
    this.name,
    this.surName,
    this.gmail,
    this.password,
    this.telphone,
    this.birthDay,
  });
  UserModel.empty();
  factory UserModel.fromSnapShot(DocumentSnapshot snapshot) {
    return UserModel(
      name: snapshot["userName"],
      surName: snapshot["userSurName"],
      birthDay: snapshot["userbirthDay"],
      gmail: snapshot["email"],
      telphone: snapshot['telphone'],
    );
  }
}
