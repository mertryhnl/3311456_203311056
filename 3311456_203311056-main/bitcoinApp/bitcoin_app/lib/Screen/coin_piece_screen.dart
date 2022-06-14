import 'package:bitcoin_app/Model/btc_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';

class CoinPieceScreen extends StatefulWidget {
  const CoinPieceScreen({Key? key, required this.btcModel}) : super(key: key);
  final BtcModel btcModel;
  @override
  State<CoinPieceScreen> createState() => _CoinPieceScreenState();
}

class _CoinPieceScreenState extends State<CoinPieceScreen> {
  final box = Hive.box("basket");
  double count = 0.0;
  Map<String, double> map = {};
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
        title: const Text("coin satıl alma adeti "),
      ),
      body: Center(
          child: Column(children: [
        returnImage(),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            widget.btcModel.currency,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        Card(
          child: Column(
            children: [
              Text(
                "Satın alınma adeti : " + count.toString(),
                style: const TextStyle(fontSize: 20),
              ),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 140),
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          count++;
                          box.put(
                              widget.btcModel.name,
                              map = {
                                "adet": count,
                                "fiyat": double.parse(widget.btcModel.price),
                              });
                        });
                      },
                      icon: const Icon(Icons.add)),
                ),
                IconButton(
                    onPressed: () {
                      count--;
                      box.put(
                          widget.btcModel.name,
                          map = {
                            "adet": count,
                            "fiyat": double.parse(widget.btcModel.price),
                          });
                    },
                    icon: const Icon(Icons.delete)),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/basketScreen');
                    },
                    icon: const Icon(Icons.arrow_circle_right))
              ]),
            ],
          ),
        ),
      ])),
    );
  }

  Widget returnImage() {
    if (!widget.btcModel.logoUrl.toLowerCase().toString().contains(".svg")) {
      return Image.network(
        widget.btcModel.logoUrl,
        height: 200,
        width: 200,
      );
    } else {
      return SvgPicture.network(
        widget.btcModel.logoUrl,
        height: 200,
        width: 200,
        placeholderBuilder: (BuildContext context) => Container(
            padding: const EdgeInsets.all(30.0),
            child: const CircularProgressIndicator()),
      );
    }
  }
}
