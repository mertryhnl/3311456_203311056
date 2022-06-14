import 'package:bitcoin_app/Controller/buy_controller.dart';
import 'package:bitcoin_app/Model/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<Map<String, dynamic>> _items = [];

  final basket = Hive.box("basket");
  void _refreshItems() {
    final data = basket.keys.map((key) {
      final value = basket.get(key);
      return {"key": key, "adet": value["adet"], "fiyat": value["fiyat"]};
    }).toList();

    setState(() {
      _items = data.reversed.toList();
      // we use "reversed" to sort items in order from the latest to the oldest
    });
  }

  @override
  Widget build(BuildContext context) {
    _refreshItems();
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
      appBar: AppBar(title: const Text('kullanıcı ekranı')),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Card(
              elevation: 8,
              child: Column(
                children: <Widget>[
                  takeUserDetail(),
                ],
              ),
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: _items.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.black26,
                    child: ListTile(
                      title: Text(_items[index]["key"]),
                      leading: Text((double.parse(_items[index]["fiyat"]) *
                              _items[index]["adet"])
                          .toString()),
                      trailing: Text(_items[index]["adet"].toString()),
                    ));
              },
            ),
            SizedBox(
              height: 50,
              child: Card(
                  elevation: 8,
                  color: Colors.amber,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(child: Text("a"))),
            )
          ],
        ),
      ),
    );
  }

  Widget takeUserDetail() {
    if (userDetail.isNotEmpty) {
      return Column(
        children: [
          Text(userDetail.first.birthPlace),
          Text(userDetail.first.birthDate),
          Text(userDetail.first.name)
        ],
      );
    } else if (userDetail.isEmpty) {
      return const Center(child: Text("KULLANICI BİLGİSİ BULUNAMADI"));
    } else {
      return Container();
    }
  }

  Widget takeImage(int index) {
    if (DataControl.btcs[index].logoUrl.contains(".jpg") ||
        DataControl.btcs[index].logoUrl.contains(".png")) {
      return CachedNetworkImage(
        imageUrl: DataControl.btcs[index].logoUrl,
        height: 120,
        width: 120,
        placeholder: (context, url) => const CircularProgressIndicator(),
        fit: BoxFit.cover,
      );
    } else {
      return SvgPicture.network(
        DataControl.btcs[index].logoUrl,
        height: 120,
        width: 120,
        fit: BoxFit.cover,
      );
    }
  }
}
/* return Scaffold(
      appBar: AppBar(title: const Text('kullanıcı ekranı')),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Card(
              elevation: 8,
              child: Column(
                children: <Widget>[
                  takeUserDetail(),
                ],
              ),
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: DataControl.btcs.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.black26,
                  child: ListTile(
                      leading: takeImage(index),
                      title: Text(DataControl.btcs[index].name),
                      subtitle: Text(DataControl.btcs[index].price)),
                );
              },
            ),
            SizedBox(
              height: 50,
              child: Card(
                  elevation: 8,
                  color: Colors.amber,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Text(DataControl.btcToplamfiyat().toString()))),
            )
          ],
        ),
      ),
    );*/