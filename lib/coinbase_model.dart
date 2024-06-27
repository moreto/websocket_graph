// To parse this JSON data, do
//
//     final coinbaseModel = coinbaseModelFromJson(jsonString);

import 'dart:convert';

CoinbaseModel coinbaseModelFromJson(String str) => CoinbaseModel.fromJson(json.decode(str));

String coinbaseModelToJson(CoinbaseModel data) => json.encode(data.toJson());

class CoinbaseModel {
  String? type;
  int? sequence;
  String? productId;
  String? price;
  String? open24H;
  String? volume24H;
  String? low24H;
  String? high24H;
  String? volume30D;
  String? bestBid;
  String? bestBidSize;
  String? bestAsk;
  String? bestAskSize;
  String? side;
  DateTime? time;
  int? tradeId;
  String? lastSize;

  CoinbaseModel({
    this.type,
    this.sequence,
    this.productId,
    this.price,
    this.open24H,
    this.volume24H,
    this.low24H,
    this.high24H,
    this.volume30D,
    this.bestBid,
    this.bestBidSize,
    this.bestAsk,
    this.bestAskSize,
    this.side,
    this.time,
    this.tradeId,
    this.lastSize,
  });

  factory CoinbaseModel.fromJson(Map<String, dynamic> json) => CoinbaseModel(
        type: json["type"],
        sequence: json["sequence"],
        productId: json["product_id"],
        price: json["price"],
        open24H: json["open_24h"],
        volume24H: json["volume_24h"],
        low24H: json["low_24h"],
        high24H: json["high_24h"],
        volume30D: json["volume_30d"],
        bestBid: json["best_bid"],
        bestBidSize: json["best_bid_size"],
        bestAsk: json["best_ask"],
        bestAskSize: json["best_ask_size"],
        side: json["side"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        tradeId: json["trade_id"],
        lastSize: json["last_size"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "sequence": sequence,
        "product_id": productId,
        "price": price,
        "open_24h": open24H,
        "volume_24h": volume24H,
        "low_24h": low24H,
        "high_24h": high24H,
        "volume_30d": volume30D,
        "best_bid": bestBid,
        "best_bid_size": bestBidSize,
        "best_ask": bestAsk,
        "best_ask_size": bestAskSize,
        "side": side,
        "time": time?.toIso8601String(),
        "trade_id": tradeId,
        "last_size": lastSize,
      };
}
