import 'dart:developer';

import 'package:get/get.dart';

import '../../../data/models/get_timeline_weather_data_model.dart';
import '../../../data/services/general_service.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final data = Rxn<GetTimelineWeatherDataModel>().obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future getData() async {
    isLoading(true);
    try {
      await GeneralService.getAPI(city: 'jakarta').then((value) {
        if (value is GetTimelineWeatherDataModel) {
          data.value.value = value;
          // log('DATA : ${data.value.value}');
        }
      });
    } catch (e) {
      isLoading(false);
      log('ERROR NIH : $e');
    }
    isLoading(false);
  }
}
