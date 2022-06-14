import 'package:bitcoin_app/Model/btc_model.dart';
import 'package:bitcoin_app/Screen/coin_screen.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CoinList extends StatefulWidget {
  const CoinList({Key? key}) : super(key: key);

  @override
  State<CoinList> createState() => _BorsaPageState();
}

class _BorsaPageState extends State<CoinList> {
  Future<List<BtcModel>> getBtc() async {
    try {
      var response = await Dio().get(
          "https://api.nomics.com/v1/currencies/ticker?key=20000965822654cedbf1d6d4fed7b0709f848cd9");
      List<BtcModel> _btcList = [];
      if (response.statusCode == 200) {
        var btcList =
            (response.data as List).map((e) => BtcModel.fromMap(e)).toList();
        return btcList;
      }
      return _btcList;
    } on DioError catch (e) {
      return Future.error(e.message);
    }
  }

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
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 60),
            child: Text(
              ' puvogCoin',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: FutureBuilder<List<BtcModel>>(
          future: getBtc(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var btcList = snapshot.data!;
              return ListView.builder(
                itemCount: btcList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => Coin(btc: btcList[index])));
                    },
                    child: Card(
                      elevation: 20,
                      child: Row(
                        children: [
                          Text(
                            btcList[index].name,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              '\$ ' + btcList[index].symbol,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
