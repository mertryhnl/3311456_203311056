import 'package:bitcoin_app/Screen/admin_screen.dart';
import 'package:bitcoin_app/Screen/home_screen.dart';
import 'package:bitcoin_app/Screen/login_screen.dart';
import 'package:bitcoin_app/Screen/user_screen.dart';
import 'package:bitcoin_app/services/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final FirebaseAuth _auth;
  // ignore: unused_field
  late final FireAuth _myAuth;
  final admin = Hive.box("admin");
  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _myAuth = FireAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_auth.currentUser!.email.toString()),
        actions: [
          checkAdmin(),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
                child: const Text("Coinleri Görüntüle")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserScreen()));
                },
                child: const Text("Sepet")),
          ],
        ),
      ),
    );
  }

  PopupMenuButton<int> checkAdmin() {
    if (admin.get("admin") == "true") {
      return PopupMenuButton<int>(
        onSelected: (value) => makeFunction(context, value),
        itemBuilder: (context) => [
          const PopupMenuItem(
            child: Text("Admin Paneli"),
            value: 0,
          ),
          const PopupMenuItem(
            child: Text("Çıkış"),
            value: 1,
          ),
        ],
      );
    } else {
      return PopupMenuButton<int>(
        onSelected: (value) => makeFunction(context, value),
        itemBuilder: (context) => [
          const PopupMenuItem(
            child: Text("Çıkış"),
            value: 0,
          ),
        ],
      );
    }
  }

  makeFunction(BuildContext context, int value) {
    if (admin.get("admin") == "true") {
      switch (value) {
        case 0:
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AdminScreen()));
          break;
        case 1:
          FirebaseAuth.instance.signOut();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
          break;
      }
    } else {
      switch (value) {
        case 0:
          FirebaseAuth.instance.signOut();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
          break;
      }
    }
  }
}
