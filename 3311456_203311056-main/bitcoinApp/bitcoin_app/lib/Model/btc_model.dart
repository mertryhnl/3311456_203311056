import 'dart:convert';

BtcModel welcomeFromMap(String str) => BtcModel.fromMap(json.decode(str));

String welcomeToMap(BtcModel data) => json.encode(data.toMap());

class BtcModel {
  BtcModel({
    required this.id,
    required this.currency,
    required this.symbol,
    required this.name,
    required this.logoUrl,
    required this.status,
    //required this.platformCurrency,
    required this.price,
    required this.priceDate,
    required this.priceTimestamp,
    required this.circulatingSupply,
    required this.marketCap,
    required this.marketCapDominance,
    required this.numExchanges,
    required this.numPairs,
    required this.numPairsUnmapped,
    required this.firstCandle,
    //required this.firstTrade,
    required this.firstOrderBook,
    required this.rank,
    required this.rankDelta,
    required this.high,
    required this.highTimestamp,
    required this.the1D,
    required this.the7D,
    required this.the30D,
    required this.the365D,
    required this.ytd,
  });

  final String id;
  final String currency;
  final String symbol;
  final String name;
  final String logoUrl;
  final String status;
  //final String platformCurrency;
  final String price;
  final DateTime priceDate;
  final DateTime priceTimestamp;
  final String circulatingSupply;
  final String marketCap;
  final String marketCapDominance;
  final String numExchanges;
  final String numPairs;
  final String numPairsUnmapped;
  final DateTime firstCandle;
  //final DateTime firstTrade;
  final DateTime firstOrderBook;
  final String rank;
  final String rankDelta;
  final String high;
  final DateTime highTimestamp;
  final The1D the1D;
  final The1D the7D;
  final The1D the30D;
  final The1D the365D;
  final The1D ytd;

  factory BtcModel.fromMap(Map<String, dynamic> json) => BtcModel(
        id: json["id"],
        currency: json["currency"],
        symbol: json["symbol"],
        name: json["name"],
        logoUrl: json["logo_url"],
        status: json["status"],
        //platformCurrency: json["platform_currency"],
        price: json["price"],
        priceDate: DateTime.parse(json["price_date"]),
        priceTimestamp: DateTime.parse(json["price_timestamp"]),
        circulatingSupply: json["circulating_supply"],
        marketCap: json["market_cap"],
        marketCapDominance: json["market_cap_dominance"],
        numExchanges: json["num_exchanges"],
        numPairs: json["num_pairs"],
        numPairsUnmapped: json["num_pairs_unmapped"],
        firstCandle: DateTime.parse(json["first_candle"]),
        //firstTrade: DateTime.parse(json["first_trade"]),
        firstOrderBook: DateTime.parse(json["first_order_book"]),
        rank: json["rank"],
        rankDelta: json["rank_delta"],
        high: json["high"],
        highTimestamp: DateTime.parse(json["high_timestamp"]),
        the1D: The1D.fromMap(json["1d"]),
        the7D: The1D.fromMap(json["7d"]),
        the30D: The1D.fromMap(json["30d"]),
        the365D: The1D.fromMap(json["365d"]),
        ytd: The1D.fromMap(json["ytd"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "currency": currency,
        "symbol": symbol,
        "name": name,
        "logo_url": logoUrl,
        "status": status,
        //"platform_currency": platformCurrency,
        "price": price,
        "price_date": priceDate.toIso8601String(),
        "price_timestamp": priceTimestamp.toIso8601String(),
        "circulating_supply": circulatingSupply,
        "market_cap": marketCap,
        "market_cap_dominance": marketCapDominance,
        "num_exchanges": numExchanges,
        "num_pairs": numPairs,
        "num_pairs_unmapped": numPairsUnmapped,
        "first_candle": firstCandle.toIso8601String(),
        //"first_trade": firstTrade.toIso8601String(),
        "first_order_book": firstOrderBook.toIso8601String(),
        "rank": rank,
        "rank_delta": rankDelta,
        "high": high,
        "high_timestamp": highTimestamp.toIso8601String(),
        "1d": the1D.toMap(),
        "7d": the7D.toMap(),
        "30d": the30D.toMap(),
        "365d": the365D.toMap(),
        "ytd": ytd.toMap(),
      };
}

class The1D {
  The1D({
    required this.volume,
    required this.priceChange,
    required this.priceChangePct,
    //required this.volumeChange,
    //required this.volumeChangePct,
    // required this.marketCapChange,
    //required this.marketCapChangePct,
  });

  final String volume;
  final String priceChange;
  final String priceChangePct;
  //final String volumeChange;
  //final String volumeChangePct;
  // final String marketCapChange;
  //final String marketCapChangePct;

  factory The1D.fromMap(Map<String, dynamic> json) => The1D(
        volume: json["volume"],
        priceChange: json["price_change"],
        priceChangePct: json["price_change_pct"],
        //volumeChange: json["volume_change"],
        //volumeChangePct: json["volume_change_pct"],
        //marketCapChange: json["market_cap_change"],
        //marketCapChangePct: json["market_cap_change_pct"],
      );

  Map<String, dynamic> toMap() => {
        "volume": volume,
        "price_change": priceChange,
        "price_change_pct": priceChangePct,
        //"volume_change": volumeChange,
        //"volume_change_pct": volumeChangePct,
        // "market_cap_change": marketCapChange,
        //"market_cap_change_pct": marketCapChangePct,
      };
}
