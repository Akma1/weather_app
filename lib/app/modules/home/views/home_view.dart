import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/app/data/utils/datetime_utils.dart';
import 'package:weather_app/app/data/widgets/run_text_widget.dart';
import 'package:weather_app/app/modules/home/views/cart3.dart';
import 'package:weather_app/app/modules/home/views/chart5.dart';
import 'package:weather_app/app/modules/home/views/weather_chart.dart';

import '../../../data/helpers/datetime_helper.dart';
import '../../../data/themes/color_gradient_theme.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // var currentData = controller.data.value.value?.current;
    return Obx(
      () => Stack(
        children: [
          buildStreamBackgroundThemeWidget(
            customGradient: buildGradientThemeBackground(
              theme: ColorTheme.sky,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: ListView(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          formatDate(
                            now,
                          ), // 'Thursday, 18 January, 2024',
                          style: Get.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          '${controller.data.value.value?.location?.name}, ${controller.data.value.value?.location?.region}, ${controller.data.value.value?.location?.country}', // 'Malang, East Java, Indonesia',
                          style: Get.textTheme.labelSmall?.copyWith(color: Colors.white),
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${controller.data.value.value?.current?.tempC?.ceil() ?? 0}',
                                      style: Get.textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 100,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Transform.translate(
                                      offset: const Offset(0, -20),
                                      child: Text(
                                        '°C',
                                        style: Get.textTheme.labelLarge?.copyWith(
                                          fontSize: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${controller.data.value.value?.current?.condition?.text}',
                                  style: Get.textTheme.labelMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            // Container(
                            //   decoration: const BoxDecoration(),
                            //   child: Image.network(
                            //     'https:${controller.data.value.value?.current?.condition?.icon}',
                            //     width: width * .5,
                            //     height: width * .5,
                            //   ),
                            // ),
                            Container(
                              decoration: const BoxDecoration(),
                              child: LottieBuilder.asset(
                                'assets/lotties/weather-sunny.json',
                                width: width * .5,
                                height: width * .5,
                              ),
                            ),
                          ],
                        ),
                        RunTextWidget(
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/icons/sunrise.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                  Text(
                                    'Sunrise ${controller.data.value.value?.forecast?.forecastday?.first.astro?.sunrise}',
                                    style: Get.textTheme.labelMedium?.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                ' | ',
                                style: Get.textTheme.labelMedium?.copyWith(color: Colors.blue.shade900),
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/icons/sunset.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                  Text(
                                    'Sunset ${controller.data.value.value?.forecast?.forecastday?.first.astro?.sunset}',
                                    style: Get.textTheme.labelMedium?.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                ' | ',
                                style: Get.textTheme.labelMedium?.copyWith(color: Colors.blue.shade900),
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/icons/moonrise.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                  Text(
                                    'Moonrise ${controller.data.value.value?.forecast?.forecastday?.first.astro?.moonrise}',
                                    style: Get.textTheme.labelMedium?.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          child: Row(
                            children: [
                              buildCardInfoHeader(
                                img: 'assets/icons/wind.png',
                                label: 'Wind Velocity',
                                value: '${controller.data.value.value?.current?.gustKph ?? 0} km/h',
                                width: width,
                              ),
                              buildCardInfoHeader(
                                width: width,
                                img: 'assets/icons/ultraviolet-solid.png',
                                label: 'UV Index',
                                value: '${controller.data.value.value?.current?.uv ?? 0}',
                              ),
                              buildCardInfoHeader(
                                width: width,
                                img: 'assets/icons/humidity.png',
                                label: 'Humidity',
                                value: '${controller.data.value.value?.current?.humidity ?? 0} %',
                              ),
                              buildCardInfoHeader(
                                width: width,
                                img: 'assets/icons/water-drop.png',
                                label: 'pH Levels',
                                value: '6',
                              ),
                              buildCardInfoHeader(
                                width: width,
                                img: 'assets/icons/wind-direction.png',
                                label: 'Wind Direction',
                                value:
                                    '${controller.data.value.value?.current?.windDir} - ${controller.data.value.value?.current?.windDegree ?? 0}°',
                                // (controller.data.value.value?.current?.windDir ?? '-')
                                //         .toUpperCase()
                                //         .contains('N')
                                //     ? 'NORTH'
                                //     : (controller.data.value.value?.current?.windDir ?? '-').contains('E')
                                //         ? 'EAST'
                                //         : (controller.data.value.value?.current?.windDir ?? '-')
                                //                 .contains('S')
                                //             ? 'SOUTH'
                                //             : (controller.data.value.value?.current?.windDir ?? '-')
                                //                     .contains('W')
                                //                 ? 'WEST'
                                //                 : 'OTHER',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                controller.isLoading.isTrue
                    ? Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          height: height * .5,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.4),
                            borderRadius:
                                const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                          ),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 6,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade200,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ],
                              ),
                              // const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    'Weather Forecast',
                                    style: Get.textTheme.labelMedium?.copyWith(
                                      color: Colors.blue.shade900,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              ...(controller.data.value.value?.forecast?.forecastday ?? []).map(
                                (e) => SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                  child: Row(
                                    children: [
                                      ...(e.hour ?? []).map(
                                        (hourData) {
                                          return buildCardForeCast(
                                              // time: formatTime(hourData.time ?? now),
                                              // img: 'https:${hourData.condition?.icon}',
                                              // condition: '${hourData.condition?.text}',
                                              // degree: '${hourData.tempC?.ceil()}',
                                              );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                width: double.maxFinite,
                                height: 200,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(.3), borderRadius: BorderRadius.circular(16)),
                                padding: const EdgeInsets.all(8.0),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 1200,
                                      decoration: const BoxDecoration(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(top: 12),
                          height: height * .5,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.4),
                            borderRadius:
                                const BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 6,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade200,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                                  height: height * .5,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(.4),
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                  ),
                                  child: ListView(
                                    padding: EdgeInsets.zero,
                                    children: [
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Text(
                                            'Weather Forecast',
                                            style: Get.textTheme.labelMedium?.copyWith(
                                                // color: Colors.blue.shade900,
                                                ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      ...(controller.data.value.value?.forecast?.forecastday ?? []).map(
                                        (e) => SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                          child: Row(
                                            children: [
                                              ...(e.hour ?? []).map(
                                                (hourData) {
                                                  return buildCardForeCast(
                                                    time: formatTime(hourData.time ?? now),
                                                    img: 'https:${hourData.condition?.icon}',
                                                    condition: '${hourData.condition?.text}',
                                                    degree: '${hourData.tempC?.ceil()}',
                                                  );
                                                },
                                              ),
                                              // buildCardForeCast(time: '16:00', img: 'assets/icons/cloudy.png', degree: '29'),
                                              // buildCardForeCast(time: '18:00', img: 'assets/icons/cloudy.png', degree: '30'),
                                              // buildCardForeCast(time: '19:00', img: 'assets/icons/rainy-day.png', degree: '22'),
                                              // buildCardForeCast(time: '22:00', img: 'assets/icons/storm.png', degree: '22'),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        'Weather forecast in 24 hours',
                                        style: Get.textTheme.labelMedium?.copyWith(
                                            // color: Colors.blue.shade900,
                                            ),
                                      ),
                                      Container(
                                        width: double.maxFinite,
                                        height: 200,
                                        decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(.3),
                                            borderRadius: BorderRadius.circular(16)),
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                          children: [
                                            Container(
                                              height: 200,
                                              width: 1200,
                                              decoration: const BoxDecoration(),
                                              child: WeatherChartWidget(
                                                  data: controller.data.value.value?.forecast?.forecastday),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
          if (controller.isLoading.isTrue)
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(color: Colors.white.withOpacity(.9)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.asset(
                    'assets/lotties/wind-loading.json',
                  ),
                  // LottieBuilder.asset(
                  //   'assets/lotties/loading-text.json',
                  //   width: 100,
                  //   height: 100,
                  // ),
                  Text(
                    'Loading . . .',
                    style: Get.textTheme.labelMedium?.copyWith(),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }

  Padding buildCardForeCast({
    String? time,
    String? img,
    String? condition,
    String? degree,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Column(
        children: [
          Container(
            width: 80,
            decoration: BoxDecoration(
              color: Colors.blue.shade800,
              gradient: LinearGradient(colors: [
                Colors.blue.withOpacity(.4),
                Colors.blue.shade400,
              ]),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Center(
                child: Text(
                  time ?? '14:00',
                  style: Get.textTheme.labelMedium?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              // height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(.2),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    img == null
                        ? Image.asset(
                            'assets/icons/sun.png',
                            width: 36,
                            height: 36,
                          )
                        : Image.network(
                            img,
                            width: 36,
                            height: 36,
                          ),
                    const SizedBox(height: 6),
                    RunTextWidget(
                      child: Text(
                        condition ?? 'condition',
                        style: Get.textTheme.labelMedium?.copyWith(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          degree ?? '32',
                          style: Get.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            // fontSize: 100,
                            color: Colors.blue.shade800,
                          ),
                        ),
                        Transform.translate(
                          offset: const Offset(0, -7),
                          child: Text(
                            '°C',
                            style: Get.textTheme.labelLarge?.copyWith(
                              // fontSize: 30,
                              color: Colors.blue.shade800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildCardInfoHeader({
    String? img,
    String? label,
    String? value,
    double? width,
  }) {
    return Container(
      width: width! * .3,
      height: 100,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: .4),
        color: Colors.blue.withOpacity(.4),
        gradient: LinearGradient(
          colors:
              //  buildGradientThemeBackground(
              //   theme: ColorTheme.sky,
              // ),
              [
            Colors.blue.withOpacity(.4),
            Colors.blue,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            img ?? 'assets/icons/wind.png',
            width: 20,
            height: 20,
            color: Colors.white,
          ),
          const Spacer(),
          Text(
            label ?? 'Wind Velocity',
            style: Get.textTheme.labelMedium?.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value ?? '10 km/h',
            style: Get.textTheme.labelMedium?.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  AspectRatio buildBackgroundImg() {
    return AspectRatio(
      aspectRatio: 4 / 2,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(
              'assets/bg-1.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Text(
          'Temp 30 C',
          style: Get.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}

// Column(
//           children: [
//             AspectRatio(
//               aspectRatio: 4 / 2,
//               child: Container(
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   image: DecorationImage(
//                     image: AssetImage(
//                       'assets/bg-1.jpg',
//                     ),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: Text(
//                   'Temp 30 C',
//                   style: Get.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: ListView(
//                 children: [
//                   for (var i = 0; i < 100; i++)
//                     Text(
//                       'data',
//                     ),
//                   Center(
//                     child: ElevatedButton(
//                       onPressed: () => Get.toNamed(Routes.DASHBOARD),
//                       child: Text(
//                         'Go to Dashboard',
//                         style: Get.textTheme.labelMedium?.copyWith(),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         Positioned(
//           top: 0,
//           child: Transform.translate(
//             offset: Offset(0, Get.height * .26),
//             child: SizedBox(
//               width: width,
//               child: Container(
//                 margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border.all(
//                     color: Colors.grey.shade400,
//                   ),
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text('Cards'),
//                 ),
//               ),
//             ),
//           ),
//         ),
