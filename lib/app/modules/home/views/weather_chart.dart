import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/app/data/helpers/datetime_helper.dart';
import 'package:weather_app/app/data/utils/datetime_utils.dart';

import '../../../data/models/get_timeline_weather_data_model.dart';

class WeatherChartWidget extends StatelessWidget {
  const WeatherChartWidget({
    super.key,
    this.data,
  });
  final List<Forecastday>? data;
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.blue,
            tooltipRoundedRadius: 8,
            getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
              return lineBarsSpot.map((lineBarSpot) {
                return LineTooltipItem(
                  '${lineBarSpot.y.ceil()}°C',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList();
            },
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                var time = now.obs;
                var icon = ''.obs;
                for (var i = 0; i < data!.length; i++) {
                  for (var j = 0; j < data![i].hour!.length; j++) {
                    if (value.ceil() == j) {
                      time.value = data![i].hour![j].time!;
                      icon.value = data![i].hour![j].condition!.icon!;
                      print('${time.value}');
                    }
                  }
                }
                return Row(
                  children: [
                    if (value != 24)
                      Image.network(
                        'https:${icon.value}',
                        width: 20,
                        height: 20,
                      ),
                    const SizedBox(width: 2),
                    if (value != 24)
                      Text(
                        formatTime(time.value),
                        style: Get.textTheme.labelMedium?.copyWith(fontSize: 8),
                      ),
                  ],
                );
              },

              interval: 1, // Set the interval for Y-axis labels
            ),
          ),
          rightTitles: const AxisTitles(),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                var hmdt = 0.obs;
                for (var i = 0; i < data!.length; i++) {
                  for (var j = 0; j < data![i].hour!.length; j++) {
                    log('jos ${data![i].hour!.indexed}');
                    if (value.ceil() == j) {
                      hmdt.value = data![i].hour![j].humidity;
                      print('${hmdt.value}');
                    }
                  }
                }
                return Text(
                  (value != 24) ? '${hmdt.value}%' : '',
                  style: Get.textTheme.labelMedium?.copyWith(fontSize: 8),
                );
              },

              interval: 1, // Set the interval for Y-axis labels
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.ceil()}°C',
                  style: Get.textTheme.labelMedium?.copyWith(fontSize: 8),
                );
              },
              interval: 10, // Set the interval for X-axis labels
            ),
          ),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(
                color: Colors.transparent), //BorderSide(color: Get.theme.primaryColor.withOpacity(0.2), width: 4),
            left: BorderSide(color: Colors.transparent),
            right: BorderSide(color: Colors.transparent),
            top: BorderSide(color: Colors.transparent),
          ),
        ),
        minX: 0,
        maxX: 24, //data?.first.hour?.length.toDouble(), // Adjust as needed based on your data
        minY: 0,
        maxY: 40,
        // data?.first.hour
        //     ?.where((element) => element.tempC != null)
        //     .toList()
        //     .toSet()
        //     .length
        //     .toDouble(), // Adjust as needed based on your data
        lineBarsData: [
          for (var i = 0; i < data!.length; i++)
            LineChartBarData(
              spots: [
                for (var j = 0; j < data![i].hour!.length; j++)
                  FlSpot(
                    j.toDouble(),
                    data![i].hour![j].tempC!,
                  ),
              ],
              isCurved: true,
              barWidth: 1,
              color: Colors.blue, //[Colors.blue],
              dotData: FlDotData(
                show: true,
                getDotPainter: (p0, p1, p2, p3) {
                  log('FlSpot$p0');
                  log('double$p1');
                  log('LineChartBarData$p2');
                  log('int$p3');
                  return FlDotCirclePainter(color: Colors.blue);
                },
                checkToShowDot: (spot, barData) {
                  return true;
                },
              ),
              belowBarData: BarAreaData(
                  // show: true,
                  // gradient: LinearGradient(
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  //   colors: [
                  //     Colors.blue.shade100,
                  //     Colors.blue.shade50.withOpacity(.6),
                  //     Colors.white.withOpacity(.2),
                  //   ],
                  // ),
                  ),
            ),
        ],
      ),
    );
  }
}
