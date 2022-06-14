import 'package:bitcoin_app/Model/btc_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);
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
    final CollectionReference _users =
        FirebaseFirestore.instance.collection('Users');

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Text("Admin Paneli"),
        actions: [
          PopupMenuButton<int>(
            onSelected: (value) => makeFunction(context, value),
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text("Ana Sayfa"),
                value: 0,
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            takeUsersData(_users),
            getCoinData(),
          ],
        ),
      ),
    );
  }

  Widget getCoinData() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          const Text(
            "Coinler",
            style: TextStyle(fontSize: 20),
          ),
          Card(
            elevation: 8,
            color: Colors.red,
            child: FutureBuilder<List<BtcModel>>(
              future: getBtc(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var btcList = snapshot.data!;
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: btcList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Card(
                          elevation: 20,
                          child: SizedBox(
                            height: 100,
                            child: Row(
                              children: [
                                Text(
                                  btcList[index].name,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  child: Column(
                                    children: [
                                      IconButton(
                                          onPressed: () async {
                                            FirebaseFirestore.instance
                                                .collection("UpperCoin")
                                                .doc(btcList[index].name)
                                                .set({
                                              "coinName": btcList[index].name,
                                              "imageUrl":
                                                  btcList[index].logoUrl,
                                            });
                                          },
                                          icon: const Icon(Icons.arrow_upward)),
                                      IconButton(
                                          onPressed: () async {
                                            FirebaseFirestore.instance
                                                .collection("UpperCoin")
                                                .doc(btcList[index].name)
                                                .delete();
                                          },
                                          icon: const Icon(Icons.delete)),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection("LowerCoin")
                                              .doc(btcList[index].name)
                                              .set({
                                            "coinName": btcList[index].name,
                                            "imageUrl": btcList[index].logoUrl,
                                          });
                                        },
                                        icon: const Icon(Icons.arrow_downward)),
                                    IconButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection("LowerCoin")
                                              .doc(btcList[index].name)
                                              .delete();
                                        },
                                        icon: const Icon(Icons.delete)),
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection("PopularCoin")
                                              .doc(btcList[index].name)
                                              .set({
                                            "coinName": btcList[index].name,
                                            "imageUrl": btcList[index].logoUrl,
                                          });
                                        },
                                        icon: const Icon(
                                            Icons.people_outline_sharp)),
                                    IconButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection("PopularCoin")
                                              .doc(btcList[index].name)
                                              .delete();
                                        },
                                        icon: const Icon(Icons.delete)),
                                  ],
                                ),
                              ],
                            ),
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
        ],
      ),
    );
  }

  Widget takeUsersData(CollectionReference<Object?> _users) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
              child: Text(
            "Kullanıcılar",
            style: TextStyle(fontSize: 20),
          )),
        ),
        Card(
          elevation: 8,
          color: Colors.grey,
          child: StreamBuilder(
            stream: _users.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(documentSnapshot['userName']),
                      ),
                    );
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ],
    );
  }

  void makeFunction(BuildContext context, int value) {
    switch (value) {
      case 0:
        Navigator.pushNamed(context, '/homeScreen');
        break;
    }
  }
}
