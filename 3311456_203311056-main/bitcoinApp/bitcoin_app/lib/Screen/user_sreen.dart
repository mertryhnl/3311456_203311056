import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  // ignore: prefer_typing_uninitialized_variables
  var name;
  // ignore: prefer_typing_uninitialized_variables
  var surName;
  // ignore: prefer_typing_uninitialized_variables
  var birthDay;
  // ignore: prefer_typing_uninitialized_variables
  var gsm;
  // ignore: prefer_typing_uninitialized_variables
  var email;
  final box = Hive.box("purchased");
  List<Map<String, dynamic>> _items = [];
  double purchasedTotal = 0.0;
  void _refreshItems() {
    final data = box.keys.map((key) {
      final value = box.get(key);
      return {"key": key, "adet": value["adet"], "fiyat": value["fiyat"]};
    }).toList();
    setState(
      () {
        _items = data.reversed.toList();
      },
    );
    for (var element in _items) {
      purchasedTotal += element["fiyat"] * element["adet"];
    }
  }

  userDetailFunc() async {
    var ref = FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    await ref.then((DocumentSnapshot value) async {
      if (mounted) {
        setState(() {
          name = value.get("userName").toString();
          surName = value.get("userSurName").toString();
          birthDay = value.get("userBirthDay").toString();
          gsm = value.get("telphone").toString();
          email = value.get("email").toString();
        });
      }
    });
  }

  @override
  void initState() {
    _refreshItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userDetailFunc();
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              onPressed: () {
                Navigator.pushNamed(context, '/homeScreen');
              },
              child: const Icon(Icons.home),
            ),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              onPressed: () {
                Navigator.pushNamed(context, '/userScreen');
              },
              child: const Icon(Icons.person_pin_circle),
            ),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              onPressed: () {
                Navigator.pushNamed(context, '/basketScreen');
              },
              child: const Icon(Icons.shopping_bag),
            ),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              onPressed: () {
                Navigator.pushNamed(context, '/coinListScreen');
              },
              child: const Icon(Icons.attach_money),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Center(child: Text('User Detail')),
      ),
      body: Column(
        children: [
          const Center(
            child: Icon(
              Icons.person_pin_circle,
              size: 300,
            ),
          ),
          Card(
            elevation: 20,
            child: Text(
              'Yours Name: $name',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            elevation: 20,
            child: Text(
              'Yours Sur Name: $surName',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            elevation: 20,
            child: Text(
              'Yours Birth Day: $birthDay',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            elevation: 20,
            child: Text(
              'Yours GSM: $gsm',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            elevation: 20,
            child: Text(
              'Yours e-mail: $email',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Card(
            elevation: 20,
            child: Text(
              'Purchased Coins Total Money: $purchasedTotal',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 125),
            child: Row(
              children: [
                const Text('My Coins',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    onPressed: () {
                      Navigator.pushNamed(context, '/myCoinScreen');
                    },
                    child: const Icon(Icons.attach_money),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
