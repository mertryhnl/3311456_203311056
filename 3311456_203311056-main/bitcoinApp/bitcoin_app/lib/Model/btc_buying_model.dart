import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

@HiveType(typeId: 1)
class BtcBuyingModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String btcName;
  @HiveField(2)
  final double money;
  @HiveField(3)
  final double sumMoney;

  BtcBuyingModel(this.id, this.btcName, this.money, this.sumMoney);

  factory BtcBuyingModel.create(
      {required String btcName,
      required double money,
      required double sumMoney}) {
    return BtcBuyingModel(const Uuid().v1(), btcName, money, sumMoney);
  }
}
