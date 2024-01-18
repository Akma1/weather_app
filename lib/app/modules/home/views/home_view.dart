import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/app/data/utils/datetime_utils.dart';

import '../../../data/helpers/datetime_helper.dart';
import '../../../data/themes/color_gradient_theme.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final currentData = controller.data.value.value?.current;
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            body: Stack(
              children: [
                buildStreamBackgroundThemeWidget(
                  customGradient: buildGradientThemeBackground(
                    theme: ColorTheme.sky,
                  ),
                ),
                Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          height: Get.height * .5,
                          decoration: const BoxDecoration(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                formatDate(
                                  now,
                                ), // 'Thursday, 18 January, 2024',
                                style: Get.textTheme.labelLarge
                                    ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              Text(
                                '${controller.data.value.value?.location?.name}, ${controller.data.value.value?.location?.region}, ${controller.data.value.value?.location?.country}', // 'Malang, East Java, Indonesia',
                                style: Get.textTheme.labelSmall?.copyWith(color: Colors.white),
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${currentData?.tempC?.ceil() ?? 0}',
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
                                  const Spacer(),
                                  LottieBuilder.asset(
                                    'assets/lotties/weather-sunny.json',
                                    width: 200,
                                    height: 200,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: width,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                  child: Expanded(
                                    child: Row(
                                      children: [
                                        buildCardInfoHeader(
                                          img: 'assets/icons/wind.png',
                                          label: 'Wind Velocity',
                                          value: '${currentData?.gustKph ?? 0} km/h',
                                          width: width,
                                        ),
                                        buildCardInfoHeader(
                                          width: width,
                                          img: 'assets/icons/ultraviolet-solid.png',
                                          label: 'UV Index',
                                          value: '${currentData?.uv ?? 0}',
                                        ),
                                        buildCardInfoHeader(
                                          width: width,
                                          img: 'assets/icons/humidity.png',
                                          label: 'Humidity',
                                          value: '${currentData?.humidity ?? 0}',
                                        ),
                                        buildCardInfoHeader(
                                          width: width,
                                          img: 'assets/icons/wind-degree.png',
                                          label: 'Wind Degree',
                                          value: '${currentData?.windDegree ?? 0}°',
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
                                          value: currentData!.windDir!.toUpperCase().contains('N')
                                              ? 'NORTH'
                                              : currentData.windDir!.toUpperCase().contains('E')
                                                  ? 'EAST'
                                                  : currentData.windDir!.toUpperCase().contains('S')
                                                      ? 'SOUTH'
                                                      : currentData.windDir!.toUpperCase().contains('W')
                                                          ? 'WEST'
                                                          : 'OTHER',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            height: Get.height,
                            width: width,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.4),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 6,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade200,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
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
                                Container(
                                  width: width,
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: const BoxDecoration(),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                    child: Expanded(
                                      child: Row(
                                        children: [
                                          buildCardForeCast(time: '12:00', img: 'assets/icons/sun.png', degree: '32'),
                                          buildCardForeCast(
                                              time: '16:00', img: 'assets/icons/cloudy.png', degree: '29'),
                                          buildCardForeCast(
                                              time: '18:00', img: 'assets/icons/cloudy.png', degree: '30'),
                                          buildCardForeCast(
                                              time: '19:00', img: 'assets/icons/rainy-day.png', degree: '22'),
                                          buildCardForeCast(time: '22:00', img: 'assets/icons/storm.png', degree: '22'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
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
                    Image.asset(
                      img ?? 'assets/icons/sun.png',
                      width: 36,
                      height: 36,
                    ),
                    const SizedBox(height: 6),
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
        border: Border.all(color: Colors.white, width: .2),
        color: Colors.blue.withOpacity(.4),
        gradient: LinearGradient(colors: [
          Colors.blue.withOpacity(.4),
          Colors.blue,
        ]),
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
