import 'package:bitcoin_app/Model/btc_model.dart';
import 'package:bitcoin_app/Screen/admin_screen.dart';
import 'package:bitcoin_app/Screen/coin_piece_screen.dart';
import 'package:bitcoin_app/Screen/my_coins_screen.dart';
import 'package:bitcoin_app/Screen/user_sreen.dart';
import 'package:bitcoin_app/Screen/credit_cart_screen.dart';
import 'package:bitcoin_app/Screen/coin_list_screen.dart';
import 'package:bitcoin_app/Screen/coin_screen.dart';
import 'package:bitcoin_app/Screen/drop_coin.dart';
import 'package:bitcoin_app/Screen/favorite_screen.dart';
import 'package:bitcoin_app/Screen/graphic_screen.dart';
import 'package:bitcoin_app/Screen/home_screen.dart';
import 'package:bitcoin_app/Screen/login_screen.dart';
import 'package:bitcoin_app/Screen/popular_screen.dart';
import 'package:bitcoin_app/Screen/rise_coin_screen.dart';
import 'package:bitcoin_app/Screen/signup_screen.dart';
import 'package:bitcoin_app/Screen/basket_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Screen/graphic_detail_screen.dart';
import '../path_provider.dart';

class RouteControl {
  static Route<dynamic>? routeGenerator(RouteSettings settings) {
    switch (settings.name) {
      case '/homeScreen':
        return _gotoPage(const HomeScreen(), settings);
      case '/pathProvider':
        return _gotoPage(const PathProvider(title: "Mert"), settings);
      case '/coinListScreen':
        return _gotoPage(const CoinList(), settings);
      case '/adminScreen':
        return _gotoPage(const AdminScreen(), settings);
      case '/creditScreen':
        return _gotoPage(const CreditCartScreen(), settings);
      case '/userScreen':
        return _gotoPage(const UserScreen(), settings);
      case '/coinScreen':
        return _gotoPage(Coin(btc: settings.arguments as BtcModel), settings);
      case '/loginScreen':
        return _gotoPage(const LoginScreen(), settings);
      case '/singupScreen':
        return _gotoPage(const SignUpScreen(), settings);
      case '/basketScreen':
        return _gotoPage(const BasketScreen(), settings);
      case '/populerCoinScreen':
        return _gotoPage(PopularCoinScreen(), settings);
      case '/riseCoinScreen':
        return _gotoPage(RiseCoinScreen(), settings);
      case '/dropCoinScreen':
        return _gotoPage(DropCoinScreen(), settings);
      case '/favoriteScreen':
        return _gotoPage(const FavoriteScreen(), settings);
      case '/graphicScreen':
        return _gotoPage(const GraphicScreen(), settings);
      case '/graphicDetailScreen':
        return _gotoPage(
            GrafikDetailScreen(btcdetay: settings.arguments as BtcModel),
            settings);
      case '/myCoinScreen':
        return _gotoPage(const MyCoins(), settings);
      case '/coinPieceScreen':
        return _gotoPage(
            CoinPieceScreen(btcModel: settings.arguments as BtcModel),
            settings);
    }
    return null;
  }

  static Route<dynamic>? _gotoPage(Widget page, RouteSettings settings) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoPageRoute(
          builder: ((context) => page), settings: settings);
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return MaterialPageRoute(
          builder: ((context) => page), settings: settings);
    } else {
      return CupertinoPageRoute(
          builder: ((context) => page), settings: settings);
    }
  }
}
