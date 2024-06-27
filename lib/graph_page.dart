import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphic/graphic.dart';

import 'graph_controller.dart';

class GraphPage extends GetView<GraphController> {
  const GraphPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GraphController());
    controller.initialize();

    List<Map> data = [];
    final rdm = Random();
    data = [
      {'time': 'Sports', 'price': rdm.nextInt(300)},
      {'time': 'Strategy', 'price': rdm.nextInt(300)},
      {'time': 'Action', 'price': rdm.nextInt(300)},
      {'time': 'Shooter', 'price': rdm.nextInt(300)},
      {'time': 'Other', 'price': rdm.nextInt(300)},
    ];

    return GetBuilder<GraphController>(
        init: GraphController(),
        builder: (controller) => Scaffold(
              appBar: AppBar(title: const Text('CoinBase - BTC-USD')),
              body: controller.hasData
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [const Text('Value'), Text(controller.coinbaseModel.price.toString())])),
                          controller.hasData2
                              ? Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: SizedBox(
                                    // margin: const EdgeInsets.only(top: 10),
                                    //  width: Get.width - 32.0,
                                    height: 150,
                                    child: Chart(
                                      rebuild: false,
                                      data: controller.data2,
                                      variables: {
                                        'time': Variable(accessor: (Map map) => map['time'] as String),
                                        'price': Variable(accessor: (Map map) => map['price'] as num),
                                      },
                                      marks: [IntervalMark()],
                                      axes: [Defaults.horizontalAxis, Defaults.verticalAxis],
                                      selections: {
                                        'tap': PointSelection(
                                          on: {
                                            GestureType.hover,
                                            GestureType.tap,
                                          },
                                          dim: Dim.x,
                                        )
                                      },
                                      tooltip: TooltipGuide(
                                        backgroundColor: Colors.black,
                                        elevation: 5,
                                        textStyle: Defaults.textStyle,
                                        variables: ['time', 'price'],
                                      ),
                                      crosshair: CrosshairGuide(),
                                    ),
                                  ),
                                )
                              : Container(),
                          controller.hasData2
                              ? SizedBox(
                                  // margin: const EdgeInsets.only(top: 10),
                                  //   width: Get.width - 32.0,
                                  height: 150,
                                  child: Chart(
                                    data: controller.data2,
                                    variables: {
                                      'Date': Variable(
                                        accessor: (Map map) => map['time'] as String,
                                        scale: OrdinalScale(tickCount: 5),
                                      ),
                                      'Close': Variable(
                                        accessor: (Map map) => (map['price'] ?? double.nan) as num,
                                      ),
                                    },
                                    marks: [
                                      AreaMark(
                                        shape: ShapeEncode(value: BasicAreaShape(smooth: true)),
                                        color: ColorEncode(value: Defaults.colors10.first.withAlpha(80)),
                                      ),
                                      LineMark(
                                        shape: ShapeEncode(value: BasicLineShape(smooth: true)),
                                        size: SizeEncode(value: 0.5),
                                      ),
                                    ],
                                    axes: [
                                      Defaults.horizontalAxis,
                                      Defaults.verticalAxis,
                                    ],
                                    selections: {
                                      'touchMove': PointSelection(
                                        on: {GestureType.scaleUpdate, GestureType.tapDown, GestureType.longPressMoveUpdate},
                                        dim: Dim.x,
                                      )
                                    },
                                    tooltip: TooltipGuide(
                                      followPointer: [false, true],
                                      align: Alignment.topLeft,
                                      offset: const Offset(-20, -20),
                                    ),
                                    crosshair: CrosshairGuide(followPointer: [false, true]),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    )
                  : const Center(child: CircularProgressIndicator()),
              // StreamBuilder(
              //     stream: controller.channel.stream,
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return (const Text('...'));
              //       } else {
              //         return const Center(child: CircularProgressIndicator());
              //       }
              //     }),
            ));
  }
}
