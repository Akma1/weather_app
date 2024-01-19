import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:weather_app/app/data/utils/map_util.dart';

import '../configs/app_config.dart';
import '../configs/dio_config.dart';
import '../models/get_timeline_weather_data_model.dart';
import '../models/request_param.dart';

class GeneralService extends GetConnect {
  //
  static Future getRecomendationSchoolData({String? latlong}) async {
    final res = await appClient(AppConfig.BASE_URL2).get(
      'weather/forecast',
      queryParameters: {
        'location': latlong,
        'apikey': AppConfig.API_KEY,
      },
    );
    // log('URLS : ${res.realUri}');

    if (res.statusCode == 200) {
      // log('DATA : ${res.statusCode}');
      return GetTimelineWeatherDataModel.fromJson(res.data);

      // return Location.fromJson((res.data['location']));
      // return res.data;
    }
  }

  static Future getAPI({String? city}) async {
    final res = await appClient(AppConfig.BASE_URL2).get(
      'forecast.json',
      queryParameters: {
        'key': AppConfig.API_KEY2,
        'q': city,
      },
    );
    // log('URLS : ${res.realUri}');

    if (res.statusCode == 200) {
      // log('DATA : ${res.statusCode}');
      return GetTimelineWeatherDataModel.fromJson(res.data);
    }
  }

  Future<Response> getData({
    required String endpoint,
    RequestParam? requestParam,
    dynamic query,
    int? timeout,
    String? base,
  }) async {
    Response? response;
    try {
      // await initAll(timeout: timeout, base: base);
      var param = (query ?? requestParam?.toMap().removeNullValues());
      // if (param != null) {
      //   param['appVersion'] = Get.find<AuthController>().packageInfo.value.value?.version;
      // }
      response = await get(endpoint, query: param);
      if (kDebugMode) {
        log('url ${response.request?.url}');
      }

      return response;
    } on SocketException {
      rethrow;
    } catch (e) {
      // saveError(message: '$e', response: response, query: queryString);
      rethrow;
    }
  }
}

// class ServiceProvider extends GetConnect {
//   void onInit() {
//     initAll();
//     super.onInit();
//   }

//   Future<void> initAll({int? timeout, String? base}) async {
//     allowAutoSignedCert = true;
//     httpClient.baseUrl = base ?? AppConfig.BASE_URL;
//     // httpClient.timeout = Duration(
//     //     seconds: timeout ??
//     //         (Platform.isAndroid ? Get.find<FirebaseController>().remoteConfig.getInt(RemoteVar.appTimeOut) : 20));
//   }

//   Future<Response> getData({
//     required String endpoint,
//     RequestParam? requestParam,
//     dynamic query,
//     int? timeout,
//     String? base,
//   }) async {
//     Response? response;
//     String? queryString;
//     try {
//       await initAll(timeout: timeout, base: base);
//       var param = (query ?? requestParam?.toMap().removeNullValues());
//       if (param != null) {
//         param['appVersion'] = Get.find<AuthController>().packageInfo.value.value?.version;
//       }
//       response = await get(endpoint, query: param);
//       if (kDebugMode) {
//         print('url ${response.request?.url}');
//       }
//       if (!response.isSuccess) {
//         throw response.message;
//       }
//       return response;
//     } on SocketException {
//       rethrow;
//     } catch (e) {
//       saveError(message: '$e', response: response, query: queryString);
//       rethrow;
//     }
//   }
// }
