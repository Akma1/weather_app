import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue.shade800,
                foregroundColor: Colors.white,
                title: Text(
                  'Dashboard',
                  style: Get.textTheme.titleMedium?.copyWith(color: Colors.white),
                ),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1.5,
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: LineChart(
                              // LineChartData(
                              //   gridData: FlGridData(show: false),
                              //   titlesData: FlTitlesData(show: false),
                              //   borderData: FlBorderData(
                              //     show: true,
                              //     border: Border.all(color: const Color(0xff37434d), width: 1),
                              //   ),
                              //   minX: 0,
                              //   maxX: 7,
                              //   minY: 0,
                              //   maxY: 50,
                              //   lineBarsData: [
                              //     LineChartBarData(
                              //       spots: [
                              //         // ...(controller.data.value.value?.forecast?.forecastday ?? []).map(
                              //         //   (e) => FlSpot(1, e.day!.avgtempC!.toDouble()),
                              //         // )
                              //         FlSpot(0, 20),
                              //         FlSpot(1, 25),
                              //         FlSpot(2, 32),
                              //         FlSpot(3, 28),
                              //         FlSpot(4, 35),
                              //         FlSpot(5, 40),
                              //         FlSpot(6, 38),
                              //         FlSpot(7, 45),
                              //         FlSpot(8, 20),
                              //         FlSpot(9, 25),
                              //         FlSpot(10, 32),
                              //         FlSpot(11, 28),
                              //         FlSpot(12, 35),
                              //         FlSpot(13, 40),
                              //         FlSpot(14, 38),
                              //         FlSpot(15, 45),
                              //       ],
                              //       isCurved: true,
                              //       color: Colors.amber,
                              //       dotData: FlDotData(show: false),
                              //       belowBarData: BarAreaData(show: true, color: Colors.amber.withOpacity(.1)),
                              //     ),
                              //   ],
                              // ),
                              LineChartData(
                            lineTouchData: LineTouchData(
                                touchTooltipData: LineTouchTooltipData(
                                    tooltipRoundedRadius: 10,
                                    tooltipBgColor: Colors.orange.shade100,
                                    getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                                      return touchedBarSpots.map((barSpot) {
                                        return LineTooltipItem(
                                            'Data 1', TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                            textAlign: TextAlign.start);
                                      }).toList();
                                    }

                                    //getTooltipItems:
                                    ),
                                handleBuiltInTouches: true,
                                getTouchedSpotIndicator: (barData, spotIndexes) {
                                  return List.generate(
                                      spotIndexes.length,
                                      (index) => TouchedSpotIndicatorData(
                                          FlLine(color: Colors.transparent),
                                          FlDotData(
                                              show: true,
                                              getDotPainter: (spot, _, __, ___) {
                                                return FlDotCirclePainter(
                                                    color: Colors.orange,
                                                    strokeWidth: 0,
                                                    radius: 4,
                                                    strokeColor: Colors.transparent);
                                              })));
                                }),
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: false,
                              horizontalInterval: 1,
                              verticalInterval: 1,
                              drawHorizontalLine: false,
                            ),
                            titlesData: FlTitlesData(
                              show: true,
                              // rightTitles: AxisTitles(),
                              // topTitles: AxisTitles(),
                              // bottomTitles: AxisTitles(),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 1,
                                  getTitlesWidget: leftTitleWidgetsPrice,
                                  reservedSize: 50,
                                ),
                              ),
                            ),
                            borderData:
                                FlBorderData(show: false, border: Border.all(color: const Color(0xff37434d), width: 1)),
                            minX: 0,
                            maxX: 100,
                            minY: 0,
                            maxY: 200,
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  for (var i = 0; i < 100; i++)
                                    FlSpot(
                                      i.toDouble(),
                                      i + 10,
                                    )
                                ],
                                isCurved: false,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.blue,
                                    Colors.blue.shade700,
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                barWidth: 1,
                                isStrokeCapRound: true,
                                dotData: FlDotData(
                                  show: false,
                                ),
                                belowBarData: BarAreaData(
                                  show: true,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.amber,
                                      Colors.amber.shade700,
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                              ),
                            ],
                          )),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.data.value.value?.forecast?.forecastday?.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ...controller.data.value.value!.forecast!.forecastday![index].hour!.map(
                              (e) => Column(
                                children: [
                                  Text('${e.tempC}'),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              )),
          if (controller.isLoading.isTrue)
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.4),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  int getModulo(int value) {
    int modulo = 1;
    if (value > 25) {
      modulo = (value / 5).round();
    } else if (value > 20) {
      modulo = 5;
    } else if (value > 15) {
      modulo = 4;
    } else if (value > 10) {
      modulo = 3;
    } else if (value > 5) {
      modulo = 2;
    }
    return modulo;
  }

  String convertToIdr(
    dynamic number,
    int decimalDigit, {
    bool compact = false,
    bool symbolIdr = true,
  }) {
    NumberFormat currencyFormatter = compact
        ? NumberFormat.compactCurrency(
            locale: 'id',
            symbol: symbolIdr == true ? 'Rp ' : '',
            decimalDigits: decimalDigit,
          )
        : NumberFormat.currency(
            locale: 'id',
            symbol: symbolIdr == true ? 'Rp ' : '',
            decimalDigits: decimalDigit,
          );
    return currencyFormatter.format(number);
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontSize: 10,
    );
    print(controller.listLabelBuyPrice.length);
    for (var i = 0; i < controller.listLabelBuyPrice.length; i++) {
      if (value.toInt() == i && value.toInt() % getModulo(controller.listLabelBuyPrice.length) == 0) {
        return Text(
          '${convertToIdr(controller.listLabelBuyPrice[i], 0, compact: true)}',
          style: style,
          textAlign: TextAlign.left,
        );
      }
    }
    return Container();
  }

  Widget leftTitleWidgetsPrice(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontSize: 10,
    );

    for (var i = 0; i < controller.listLabelSellPrice.length; i++) {
      if (value.toInt() == i && value.toInt() % getModulo(controller.listLabelSellPrice.length) == 0) {
        return Text('${convertToIdr(controller.listLabelSellPrice[i], 0, compact: true)}',
            style: style, textAlign: TextAlign.left);
      }
    }
    return Container();
  }
}
