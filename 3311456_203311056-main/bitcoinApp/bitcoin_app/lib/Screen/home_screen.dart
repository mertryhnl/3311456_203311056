import 'package:bitcoin_app/services/firebase_auth.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

final List<String> imgList = [
  'https://iasbh.tmgrup.com.tr/782bef/752/395/0/0/1138/597?u=https://isbh.tmgrup.com.tr/sbh/2021/02/26/son-dakika-bitcoinde-carpici-uyari-yok-oldu-1614316127876.jpg',
  'https://iasbh.tmgrup.com.tr/e9ca3d/960/505/0/0/1138/600?u=https://isbh.tmgrup.com.tr/sbh/2021/03/05/son-dakika-haber-bitcoin-icin-uyari-ustune-uyari-kripto-para-yatirimcilari-dikkat-1614932563334.jpg',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTplx5Atu_Jbyf7DIOu5YoFRJAk7V75EedZ_-ZF8Mn-hooBIhNB7xa1fsKJb9mTqPkF1lg&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPsrfxSrrEbauEnhJDlZ1wNQyoyLFjzJsb-1VQtbE4KUfeoFoI1SBa3lhCI8oadDZdlI4&usqp=CAU',
  'https://im.haberturk.com/2021/02/23/ver1614073441/2982429_600x314.jpg',
  'https://im.haberturk.com/2021/09/20/ver1632144490/3196686_414x414.jpg'
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<HomeScreen> {
  // ignore: unused_field
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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Center(
            child: Text(
          ' puvogCoin',
          style: TextStyle(
            fontSize: 30,
          ),
        )),
        actions: [
          checkAdmin(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 300,
                color: Colors.red,
                child: const CarouselWithIndicatorDemo()),
            Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                setState(() {});
                Navigator.pushNamed(context, '/populerCoinScreen');
              },
              child: SizedBox(
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    FadeInImage.assetNetwork(
                        placeholder: "images/tema.jpg",
                        image:
                            'https://rayhaber.com/wp-content/uploads/2022/02/Coin-Yorum-Coin-Gelecegi-ve-Kripto-Para.jpg',
                        fit: BoxFit.cover),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Popüler Coinler',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                setState(() {});
                Navigator.pushNamed(context, '/riseCoinScreen');
              },
              child: SizedBox(
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    FadeInImage.assetNetwork(
                        placeholder: "images/tema.jpg",
                        image:
                            'https://media.istockphoto.com/photos/stack-of-coins-financial-business-saving-and-interest-increasing-picture-id1062067188?s=612x612',
                        fit: BoxFit.cover),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Yükselen Coinler',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                setState(() {});
                Navigator.pushNamed(context, '/dropCoinScreen');
              },
              child: SizedBox(
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    FadeInImage.assetNetwork(
                        placeholder: "images/tema.jpg",
                        image:
                            'https://media.istockphoto.com/photos/red-arrow-moving-down-over-graph-paper-background-picture-id1158023944?s=612x612',
                        fit: BoxFit.cover),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Düşen Coinler',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                setState(() {});
                Navigator.pushNamed(context, '/pathProvider');
              },
              child: SizedBox(
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    FadeInImage.assetNetwork(
                        placeholder: "images/tema.jpg",
                        image:
                            'https://c.files.bbci.co.uk/15A3D/production/_124773688_whatsubject.jpg',
                        fit: BoxFit.cover),
                    const Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Text(
                        'Favori Coinlerim',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                setState(() {});
                Navigator.pushNamed(context, '/graphicScreen');
              },
              child: SizedBox(
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    FadeInImage.assetNetwork(
                        placeholder: "images/tema.jpg",
                        image:
                            'https://yatirimakademisi.envizyon.com.tr/wp-content/uploads/sites/7/2020/04/Renko-Grafik-2-6-1-1024x574.png',
                        fit: BoxFit.cover),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Grafikler',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
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
          Navigator.pushNamed(context, '/adminScreen');
          break;
        case 1:
          FirebaseAuth.instance.signOut();
          Navigator.pop(context, '/loginScreen');
          break;
      }
    } else {
      switch (value) {
        case 0:
          FirebaseAuth.instance.signOut();
          Navigator.pop(context);
          break;
      }
    }
  }
}

final List<Widget> imageSliders = imgList
    .map(
      (item) => Container(
        margin: const EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              FadeInImage.assetNetwork(
                placeholder: "images/tema.jpg",
                image: item,
                fit: BoxFit.cover,
                width: 1000.0,
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.yellow,
                          blurRadius: 1,
                          offset: Offset(5, 10))
                    ],
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    )
    .toList();

class CarouselWithIndicatorDemo extends StatefulWidget {
  const CarouselWithIndicatorDemo({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CarouselSlider(
            items: imageSliders,
            carouselController: _controller,
            options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map(
            (entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
