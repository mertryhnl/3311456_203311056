import 'package:bitcoin_app/Model/btc_model.dart';

class DataControl {
  static List<BtcModel> btcs = [];

  static addBtc(BtcModel btcModeli, int adet) {
    for (int i = 0; i < adet; i++) {
      btcs.add(btcModeli);
    }
  }

  static double btcToplamfiyat() {
    double toplam = 0;
    for (int i = 0; i < btcs.length; i++) {
      toplam += double.parse(btcs[i].price);
    }
    return toplam;
  }
}
