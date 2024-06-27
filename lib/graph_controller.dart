import 'dart:convert';

import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:websocket_graph/coinbase_model.dart';

class GraphController extends GetxController {
  final channel = WebSocketChannel.connect(Uri.parse('wss://ws-feed.pro.coinbase.com'));
  CoinbaseModel coinbaseModel = CoinbaseModel();
  List<CoinbaseModel> listCoinbaseModel = [];
  bool hasData = false;
  bool hasData2 = false;

  List<Map> data2 = [];
  List<Map> dataTemp = [];
  int qtd = 0;

  initialize() {
    getData();
  }

  attValue() {
    hasData = true;
    update();
  }

  attGraph() {
    hasData = true;
    hasData2 = true;
    update();
  }

  getData() async {
    channel.sink.add(
      jsonEncode(
        {
          "type": "subscribe",
          "channels": [
            {
              "name": "ticker",
              "product_ids": ["BTC-USD"]
            }
          ]
        },
      ),
    );

    await channel.ready;

    channel.stream.listen((message) {
      Map<String, dynamic> json = jsonDecode(message);
      coinbaseModel = CoinbaseModel.fromJson(json);

      if (coinbaseModel.time != null || coinbaseModel.price != null) {
        qtd++;
        hasData = true;

        var modulo = qtd % 7;
        if (modulo == 0) {
          data2 = dataTemp;
          dataTemp = [];

          attGraph();
        } else {
          dataTemp.add({'time': "${coinbaseModel.time!.second}:${coinbaseModel.time!.millisecond}", 'price': num.parse(coinbaseModel.price.toString())});
          attValue();
        }
      }
    });
  }
}
