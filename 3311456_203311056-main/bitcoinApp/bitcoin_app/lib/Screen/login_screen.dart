// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();
  late FirebaseAuth _auth;
  final admin = Hive.box('admin');
  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _auth.authStateChanges().listen(
      (User? user) {
        if (user == null) {
          debugPrint('User is currently signed out!');
        } else if (admin.get("admin") == "true") {
          Navigator.pushNamed(context, '/adminScreen');
        } else {
          Navigator.pushNamed(context, '/homeScreen');
        }
      },
    );
  }

  void login() async {
    String email = textEditingControllerEmail.text.trim();
    String password = textEditingControllerPassword.text.trim();
    FirebaseAuth auth = FirebaseAuth.instance;
    String userType = "user";
    if (email == "" || password == "") {
      log("Please fill all the fields!");
    } else {
      try {
        // ignore: unused_local_variable
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        var ref = FirebaseFirestore.instance
            .collection("Users")
            .doc(auth.currentUser!.uid)
            .get();

        await ref.then((DocumentSnapshot documentSnapshot) {
          userType = documentSnapshot.get("admin").toString();
        });

        if (auth.currentUser != null) {
          print(userType);
          if (userType == "true") {
            admin.put("admin", "true");
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushNamed(context, '/adminScreen');
          } else {
            print(admin.get("admin"));
            admin.put("admin", "false");
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushNamed(context, '/homeScreen');
          }
        }
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage("images/tema.jpg"), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 100, right: 20, left: 20),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Form(
                  autovalidateMode: AutovalidateMode.always,
                  child: TextFormField(
                    validator: (value) => validateEmail(value),
                    controller: textEditingControllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: 'email@gmail.com',
                      helperText: 'Enter the Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                TextFormField(
                  controller: textEditingControllerPassword,
                  textCapitalization: TextCapitalization.none,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.password),
                    hintText: '123456abcdefg',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 120),
                  child: Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            login();
                          },
                          child: const Text("Giriş")),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/singupScreen');
                            },
                            child: const Text('kayıt ol')),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else {
      return "";
    }
  }
}
