import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Model/btc_model.dart';

// ignore: must_be_immutable
class GrafikDetailScreen extends StatelessWidget {
  BtcModel btcdetay;
  GrafikDetailScreen({required this.btcdetay, Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<GrafikModel> data = [
      GrafikModel(
          date: "gün",
          deger: double.parse(btcdetay.the1D.priceChange.toString())),
      GrafikModel(
          date: "hafta",
          deger: double.parse(btcdetay.the7D.priceChange.toString())),
      GrafikModel(
          date: "ay",
          deger: double.parse(btcdetay.the30D.priceChange.toString())),
      GrafikModel(
          date: "yıl",
          deger: double.parse(btcdetay.the365D.priceChange.toString())),
    ];
    // ignore: avoid_print
    print(btcdetay.the1D.toString() + "amcı");
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
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Bigdata'),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          //Initialize the chart widget
          SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            // Chart title
            title: ChartTitle(text: ' analysis'),
            // Enable legend
            legend: Legend(isVisible: true),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<GrafikModel, String>>[
              LineSeries<GrafikModel, String>(
                  dataSource: data,
                  xValueMapper: (GrafikModel model, _) => model.date,
                  yValueMapper: (GrafikModel model, _) => model.deger,
                  name: 'Sales',
                  // Enable data label
                  dataLabelSettings: const DataLabelSettings(isVisible: true))
            ],
          ),
        ],
      ),
    );
  }
}

class GrafikModel {
  final String date;
  final double deger;

  GrafikModel({required this.date, required this.deger});
}
