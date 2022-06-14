import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Model/firebase_user_model.dart';

class FireAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  signOut() async {
    return await _auth.signOut();
  }

  createPerson(UserModel newUser) async {
    try {
      var user = await _auth.createUserWithEmailAndPassword(
          email: newUser.gmail!, password: newUser.password!);

      await _firestore.collection("Users").doc(user.user!.uid).set({
        "userName": newUser.name,
        "userSurName": newUser.surName,
        "userBirthDay": newUser.birthDay,
        "email": newUser.gmail,
        "telphone": newUser.telphone,
        "admin": "false",
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
