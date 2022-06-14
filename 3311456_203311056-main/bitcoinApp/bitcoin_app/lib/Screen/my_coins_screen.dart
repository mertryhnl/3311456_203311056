import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyCoins extends StatelessWidget {
  const MyCoins({Key? key}) : super(key: key);

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
        backgroundColor: Colors.black,
        title: const Text('My Coins'),
      ),
      body: body(),
    );
  }

  Widget body() {
    List<Map<String, dynamic>> _items = [];
    final box = Hive.box("purchased");
    final data = box.keys.map((key) {
      final value = box.get(key);
      return {"key": key, "adet": value["adet"], "fiyat": value["fiyat"]};
    }).toList();
    _items = data.reversed.toList();
    if (_items.isNotEmpty) {
      return ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, index) => Column(
                children: [
                  Text(_items[index]["fiyat"].toString()),
                  Text(_items[index]["adet"].toString()),
                  Text(_items[index]["key"].toString()),
                ],
              ));
    } else {
      // ignore: avoid_unnecessary_containers
      return Container(
        child: const Text("sa"),
      );
    }
  }
}
