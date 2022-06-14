import 'package:bitcoin_app/Screen/home_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../Model/user_model.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
        centerTitle: true,
        title: const Text("KULLANICI BİLGİLERİ GİRİŞ EKRANI"),
      ),
      body: userDetailsBody(context),
    );
  }

  Widget userDetailsBody(BuildContext context) {
    String birthPlace = "", birthDate = "", name = "";
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl:
                  "https://media-cdn.tripadvisor.com/media/photo-s/12/97/eb/31/kursunlu-selalesi-antalya.jpg",
              fit: BoxFit.fill,
              placeholder: (context, url) => const CircularProgressIndicator(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: SizedBox(
                height: 40,
                width: 250,
                child: Card(
                  color: Colors.cyan,
                  elevation: 12.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: const Center(
                    child: Text(
                      "BİLGİLERİNİZİ GİRİNİZ!",
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: TextFormField(
                autocorrect: true,
                decoration: InputDecoration(
                    hintText: "Ad ve Soyadınız",
                    fillColor: Colors.blue.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onChanged: (value) => name = value,
              ),
            ),
            TextFormField(
              autocorrect: true,
              decoration: InputDecoration(
                  hintText: "Doğum Yeri",
                  fillColor: Colors.blue.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              onChanged: (value) => birthPlace = value,
            ),
            TextFormField(
              autocorrect: true,
              decoration: InputDecoration(
                  hintText: "Doğum Tarihi",
                  fillColor: Colors.blue.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              onChanged: (value) => birthDate = value,
            ),
            ElevatedButton(
                onPressed: () {
                  userDetail.add(UserDetailedInfo(birthPlace, birthDate, name));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
                child: const Text("KAYDET")),
          ],
        ),
      ),
    );
  }
}
