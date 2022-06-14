import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:hive/hive.dart';

class CreditCartScreen extends StatefulWidget {
  const CreditCartScreen({Key? key}) : super(key: key);

  @override
  State<CreditCartScreen> createState() => _CreditCartScreenState();
}

class _CreditCartScreenState extends State<CreditCartScreen> {
  String cardNumber = "";
  String expiryDate = "";
  String cardHolderName = "";
  String cvvCode = "";
  bool showBackView = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final boxPurchased = Hive.box("purchased");
  final boxBasket = Hive.box("basket");
  List<Map<String, dynamic>> _items = [];
  // ignore: unused_field
  final List<Map<String, dynamic>> _itemsPurchased = [];

  void _refreshItems() {
    final data = boxBasket.keys.map((key) {
      final value = boxBasket.get(key);
      return {"key": key, "adet": value["adet"], "fiyat": value["fiyat"]};
    }).toList();

    setState(
      () {
        _items = data.reversed.toList();
      },
    );
  }

  void addItems() {
    // ignore: unused_local_variable
    Map<String, dynamic> map = {};
    for (var element in _items) {
      boxPurchased.put(element["key"],
          map = {"adet": element["adet"], "fiyat": element["fiyat"]});
    }
    boxBasket.clear();
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage("images/tema.jpg"), fit: BoxFit.cover),
        ),
        child: SafeArea(
            child: Column(
          children: [
            CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                isHolderNameVisible: true,
                cvvCode: cvvCode,
                showBackView: showBackView,
                onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {}),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CreditCardForm(
                        cardNumber: cardNumber,
                        expiryDate: expiryDate,
                        cardHolderName: cardHolderName,
                        cvvCode: cvvCode,
                        onCreditCardModelChange: onCreditCardModelChange,
                        themeColor: Colors.blue.shade900,
                        formKey: formKey),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 140),
              child: Row(
                children: [
                  Card(
                    elevation: 8,
                    color: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_right_alt_outlined),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          addItems();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Satış İşlemi Başırılı")));
                          Navigator.pushNamed(context, '/myCoinScreen');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      showBackView = creditCardModel.isCvvFocused;
    });
  }
}
