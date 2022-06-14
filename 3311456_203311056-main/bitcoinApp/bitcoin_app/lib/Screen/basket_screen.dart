import 'package:bitcoin_app/Controller/buy_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({Key? key}) : super(key: key);

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  List<Map<String, dynamic>> _items = [];

  final basket = Hive.box("basket");
  void _refreshItems() {
    final data = basket.keys.map((key) {
      final value = basket.get(key);
      return {"key": key, "adet": value["adet"], "fiyat": value["fiyat"]};
    }).toList();

    setState(
      () {
        _items = data.reversed.toList();
      },
    );
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
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Sepetim'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
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
                      leading: Text(
                          ((_items[index]["fiyat"]) * _items[index]["adet"])
                              .toString()),
                      trailing: Text(_items[index]["adet"].toString()),
                    ));
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.black),
              onPressed: () {
                Navigator.pushNamed(context, '/creditScreen');
              },
              child: const Icon(
                Icons.arrow_forward,
              ),
            )
          ],
        ),
      ),
    );
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
