import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PopularCoinScreen extends StatelessWidget {
  PopularCoinScreen({Key? key}) : super(key: key);
  final CollectionReference _popularCoins =
      FirebaseFirestore.instance.collection('PopularCoin');
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
        title: const Text('pupuler coin ekranı'),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                stream: _popularCoins.snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
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
                            child: Row(
                              children: [
                                Text(documentSnapshot['coinName']),
                                returnImage(documentSnapshot),
                              ],
                            ));
                      },
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget returnImage(DocumentSnapshot documentSnapshot) {
    try {
      if (documentSnapshot['imageUrl']
          .toString()
          .toLowerCase()
          .contains(".svg")) {
        return SvgPicture.network(
          documentSnapshot['imageUrl'],
          height: 200,
          width: 200,
          placeholderBuilder: (BuildContext context) => Container(
              padding: const EdgeInsets.all(30.0),
              child: const CircularProgressIndicator()),
        );
      } else {
        return CachedNetworkImage(
          height: 200,
          width: 200,
          imageUrl: documentSnapshot['imageUrl'],
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );
      }
    } catch (e) {
      print(e);
    }
    return Container();
  }
}
